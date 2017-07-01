;;;; Global basic confs

(require-package 'nlinum-relative)

;; Add homebrew bin to exec-path
(add-to-list 'exec-path "/usr/local/bin")

;; Disable tool bar
(tool-bar-mode -1)

;; Disable scroll bar
(scroll-bar-mode -1)

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(global-linum-mode t)
;; (global-nlinum-relative-mode t) - Disabled by default

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

;; Show the full file path in frame title instead of just file name.
;;
;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(provide 'init-basic-conf)
