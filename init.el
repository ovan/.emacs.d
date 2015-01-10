;;; package --- My little emacs config

;;; Commentary:

;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

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

;; Use paths to name buffers, not just file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Enable the evil mode package globally
(evil-mode 1)

(defun evil-enable-symbol-word-search ()
  "Helper to enable sane * and # behavior to use with mode hooks"
    (setq evil-symbol-word-search t))

;; Evil binds q to macro recording in many contexts. Preserve access to quit-window
(global-set-key (kbd "C-c q") 'quit-window)

;; Enable ido for better file navigation & buffer switching
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(ido-everywhere 1)
(flx-ido-mode 1) ;; Improved flex matching algorithm
;; Disable ido faces to see flx highlights
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

;; Smex for better M-x (fuzzy completion etc.)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(when evil-normal-state-map
  (define-key evil-normal-state-map (kbd "SPC SPC") 'smex))


;; Ace jump mode to simulate EasyMotion from Vim
(autoload 'ace-jump-mode
          "ace-jump-mode"
          "Emacs quick move minor mode"
          t)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)


;; Smartparens
(smartparens-global-mode t)
(require 'smartparens-config)
(sp-use-paredit-bindings)

(sp-pair "(" ")" :wrap "M-(")
(sp-pair "[" "]" :wrap "M-[")
(sp-pair "{" "}" :wrap "M-{")

;; Projectile for project file navigation
(projectile-global-mode)

;; Ag
(setq ag-highlight-search t)

;; Enable the company mode autocompletion for all buffers
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Enable global flycheck mode
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Autoload markdown mode for .md, .markdown, .text
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Clojure configuration

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'show-smartparens-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'evil-enable-symbol-word-search)

;; Disable evil mode for repl and stacktrace modes
(add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-macroexpansion-minor-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)
(setq cider-repl-result-prefix ";; => ")
(setq cider-interactive-eval-result-prefix ";; => ")

(evil-define-key 'insert clojure-mode-map (kbd "RET") 'sp-newline)
;; Allow jumping to source
(evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump)

;; Bindings for some smartparens commands
(evil-define-key 'normal clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-J") 'sp-join-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-J") 'sp-join-sexp)

;; Eval last sexp
;; (defadvice backward-sexp (around evil-cider activate)
;;   "In normal-state, last sexp ends at point."
;;   (if (evil-normal-state-p)
;;       (save-excursion
;;         (unless (or (eobp) (eolp)) (forward-char))
;;         ad-do-it)
;;     ad-do-it))


;; Known issues:
;;
;; Improvement ideas:
;;   Make view doc + source under point that work the same way as
;;   company mode (buffer which exits when you move point)



;; Ruby development
;

; Use Flycheck with global mode instead
; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

(setq ruby-deep-indent-paren nil)

(global-set-key (kbd "C-c r r") 'inf-ruby)
(global-set-key (kbd "C-c r c") 'inf-ruby-console-auto)
(add-to-list 'evil-emacs-state-modes 'inf-ruby-mode)

(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ruby-mode-hook 'evil-enable-symbol-word-search)

;; Rebind M-. back to 'robe-jump instead of evil mode repeat
(evil-define-key 'normal ruby-mode-map (kbd "M-.") 'robe-jump)

;; Autoindent newlines in insert mode
(evil-define-key 'insert ruby-mode-map (kbd "RET") 'sp-newline)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-to-list 'company-backends 'company-robe)

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(add-hook 'ruby-mode 'rspec-mode)

; Use bash to run rspecs. ZSH messes up ruby path and version
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))

(ad-activate 'rspec-compile)


;; Emacs Lisp mode customizations
;;
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'evil-enable-symbol-word-search)


;; JS mode customizations
(setq js-indent-level 2)
(evil-define-key 'insert js-mode-map (kbd "RET") 'sp-newline)


;; CSS / SCSS mode
(setq css-indent-offset 2)
(setq scss-compile-at-save nil)


;; Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work-dev.org"))

;; Whitespace
;; from: https://github.com/candera/emacs/blob/3cc572daf3148a1aebe2fc69c1c93e462dba2fee/init.el#L298
;;
(defun detabify-buffer ()
  "Calls untabify on the current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun clean-up-whitespace ()
  "Calls untabify and delete-trailing-whitespace on the current buffer."
  (interactive)
  (detabify-buffer)
  (delete-trailing-whitespace))

(defun toggle-show-whitespace ()
  (interactive)
  (setq show-trailing-whitespace
        (not show-trailing-whitespace)))

(defun setup-highlighting-whitespace ()
  (setq show-trailing-whitespace t))

(defun stop-highlighting-whitespace ()
  (setq show-trailing-whitespace nil))

(global-set-key (kbd "C-x t") 'clean-up-whitespace)

(add-hook 'text-mode-hook 'setup-highlighting-whitespace)
(add-hook 'emacs-lisp-mode-hook 'setup-highlighting-whitespace)
(add-hook 'clojure-mode-hook 'setup-highlighting-whitespace)
(add-hook 'ruby-mode-hook 'setup-highlighting-whitespace)
(add-hook 'haml-mode-hook 'setup-highlighting-whitespace)

; Reset background color of whitespace-mode to work with solarized
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :width normal :family "Inconsolata"))))
 '(whitespace-space ((t (:foreground "#073642")))))

; Don't show line break $ in whitespace-mode
(setq whitespace-style '(face spaces space-mark tabs tab-mark))

;; Rotate windows from http://www.emacswiki.org/emacs/TransposeWindows
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 0)
          (num-windows (count-windows)))
      (while  (< i (- num-windows 1))
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (% (+ i 1) num-windows)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(defalias 'rw 'rotate-windows)

;; For Mac it's easier to preserve Alt for things like [, {, \, |, etc.
;; and use Cmd as Meta instead.
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq ns-right-command-modifier 'super)
  (setq ns-option-modifier nil))


;; Load the solarized dark. Handle starting as daemon by only loading the theme
;; when a frame has been created.
(if (daemonp)
  (add-hook 'after-make-frame-functions
            '(lambda (f)
               (with-selected-frame f
                 (load-theme 'solarized-dark t)))))

;; On Mac, change the font to Inconsolata
(when (eq system-type 'darwin)
  (custom-set-faces
   '(default ((t (:height 140 :width normal :family "Inconsolata"))))))
