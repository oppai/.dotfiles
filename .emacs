;;boost
(setenv "CPLUS_INCLUDE_PATH" "/opt/local/include:$CPLUS_INCLUDE_PATH")

;;言語を日本語にする
(set-language-environment 'Japanese)
;;極力UTF-8とする
(prefer-coding-system 'utf-8)

;;command <-> control
;;'(ns-command-modifier (quote control)) 
;;'(ns-control-modifier (quote meta))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ns-command-modifier (quote control))
 '(ns-control-modifier (quote super)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;====================================
;;; 折り返し表示ON/OFF
;;====================================
(defun toggle-truncate-lines()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

(global-set-key "\C-c\C-l" 'toggle-truncate-lines)  ; 折り返し表示ON/OFF

(add-to-list 'load-path "~/.emacs.d/scala-mode")
(require 'scala-mode-auto)


;; Gauche
(show-paren-mode t) ; 対応する括弧を表示する
(setq process-coding-system-alist
(cons '("/opt/local/bin/gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "/opt/local/bin/gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(define-key global-map "\C-cs" 'run-scheme) ; C-c s で emacs 上で Gauche が走るようにする
(setq inhibit-startup-message t) ; 起動画面を表示しない
;;(run-scheme scheme-program-name) ; 起動時にいきなり scheme 処理系を走らせる

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(tool-bar-mode nil))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)