;;;; Global basic confs

;; Disable tool bar
(tool-bar-mode -1)

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Show line numbers
(global-linum-mode t)
;; Show column number in mode line
(setq column-number-mode t)

;; By default indent with spaces only
(setq-default indent-tabs-mode nil)

;; Automatically revert buffers when files change on disk
(global-auto-revert-mode t)

(global-superword-mode 1)

;; Disable cursor blinking
(blink-cursor-mode -1)

;; Don't show the startup screen
(setq inhibit-startup-screen t)

;; Use paths to name buffers, not just file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(provide 'init-basic-conf)
