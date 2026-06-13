#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd' | sed "s|^$HOME|~|")
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

LEDGER_DIR="$HOME/.claude/usage-ledger"
mkdir -p "$LEDGER_DIR"
ledger="$LEDGER_DIR/${session_id}.jsonl"

now=$(date +%s)

# Throttle: append a sample only if >=30s since last sample for this session
if [ -f "$ledger" ]; then
  last_ts=$(tail -n 1 "$ledger" 2>/dev/null | jq -r '.ts // 0' 2>/dev/null)
  [ -z "$last_ts" ] && last_ts=0
  if [ "$((now - last_ts))" -ge 30 ]; then
    printf '{"ts":%s,"cost":%s}\n' "$now" "$cost" >> "$ledger"
  fi
else
  printf '{"ts":%s,"cost":%s}\n' "$now" "$cost" >> "$ledger"
fi

# Occasional cleanup of session files older than 14 days
[ $((now % 50)) -eq 0 ] && find "$LEDGER_DIR" -name '*.jsonl' -mtime +14 -delete 2>/dev/null

# Lifetime total: track per-session previous cost, accumulate deltas into .lifetime
LIFETIME_FILE="$LEDGER_DIR/.lifetime"
STATE_DIR="$LEDGER_DIR/.state"
mkdir -p "$STATE_DIR"
state_file="$STATE_DIR/${session_id}.cost"
prev_cost=$(cat "$state_file" 2>/dev/null)
[ -z "$prev_cost" ] && prev_cost=0
delta=$(awk -v c="$cost" -v p="$prev_cost" 'BEGIN{d=c-p; if(d<0)d=0; printf "%.6f", d}')
printf '%s' "$cost" > "$state_file"
lifetime=$(cat "$LIFETIME_FILE" 2>/dev/null)
[ -z "$lifetime" ] && lifetime=0
lifetime=$(awk -v l="$lifetime" -v d="$delta" 'BEGIN{printf "%.6f", l+d}')
printf '%s' "$lifetime" > "$LIFETIME_FILE"
[ $((now % 100)) -eq 0 ] && find "$STATE_DIR" -name '*.cost' -mtime +30 -delete 2>/dev/null

# Budgets ($ API-equivalent). Override via env vars.
W5H_BUDGET="${CLAUDE_5H_BUDGET:-50}"
WEEK_BUDGET="${CLAUDE_WEEK_BUDGET:-500}"

w5h_start=$((now - 18000))    # 5 hours
week_start=$((now - 604800))  # 7 days

# Aggregate per-session window cost = max(cost) - min(cost) over samples within window
calc_window() {
  since=$1
  total=0
  for f in "$LEDGER_DIR"/*.jsonl; do
    [ -f "$f" ] || continue
    fmtime=$(stat -f %m "$f" 2>/dev/null || echo 0)
    [ "$fmtime" -lt "$since" ] && continue
    contrib=$(jq -s --argjson since "$since" '
      map(select(.ts >= $since)) |
      if length == 0 then 0
      else (map(.cost) | (max - min)) end
    ' "$f" 2>/dev/null)
    [ -z "$contrib" ] && contrib=0
    total=$(awk -v a="$total" -v b="$contrib" 'BEGIN{printf "%.6f", a+b}')
  done
  printf '%s' "$total"
}

w5h_cost=$(calc_window "$w5h_start")
week_cost=$(calc_window "$week_start")

# Progress bar with color: green<70%, yellow<90%, red>=90%
bar() {
  current=$1
  maxv=$2
  width=8
  ratio=$(awk -v c="$current" -v m="$maxv" 'BEGIN{r=c/m; if(r>1)r=1; if(r<0)r=0; print r}')
  pct=$(awk -v r="$ratio" 'BEGIN{printf "%d", r*100}')
  filled=$(awk -v r="$ratio" -v w="$width" 'BEGIN{printf "%d", r*w}')
  empty=$((width - filled))

  if [ "$pct" -ge 90 ]; then color="\033[31m"
  elif [ "$pct" -ge 70 ]; then color="\033[33m"
  else color="\033[32m"
  fi

  f=""
  e=""
  i=0
  while [ "$i" -lt "$filled" ]; do f="${f}█"; i=$((i+1)); done
  i=0
  while [ "$i" -lt "$empty" ]; do e="${e}░"; i=$((i+1)); done

  printf "%b%s%s\033[0m %3d%%" "$color" "$f" "$e" "$pct"
}

# Line 1: cwd | user
printf "\033[33m%s\033[0m|\033[32m%s\033[0m\n" "$cwd" "$(whoami)"

# Line 2: model + context %
line2=""
[ -n "$model" ] && line2="\033[36m${model}\033[0m"
if [ -n "$used" ]; then
  [ -n "$line2" ] && line2="${line2} "
  line2="${line2}\033[90mctx:$(printf '%.0f' "$used")%\033[0m"
fi
[ -n "$line2" ] && printf '%b\n' "$line2"

# Line 3: cost + 5h + 7d progress bars + lifetime total
printf "\033[90m\$%.2f\033[0m | 5h %b \033[90m\$%.2f/\$%d\033[0m | 7d %b \033[90m\$%.2f/\$%d\033[0m | \033[35mΣ\$%.2f\033[0m\n" \
  "$cost" \
  "$(bar "$w5h_cost" "$W5H_BUDGET")" "$w5h_cost" "$W5H_BUDGET" \
  "$(bar "$week_cost" "$WEEK_BUDGET")" "$week_cost" "$WEEK_BUDGET" \
  "$lifetime"
