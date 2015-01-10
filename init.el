;;;
;;; My Emacs configuration.
;;; Structure based on: https://github.com/purcell/emacs.d

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)       ;; Machinery for installing required packages
(require 'init-basic-conf) ;; Basic global configurations like toolbar disabling, indent-tabs-mode etc.

;;----------------------------------------------------------------------------
;; Supporting modes and packages
;;----------------------------------------------------------------------------
(require 'init-evil)
(require 'init-ido-smex)
(require 'init-smartparens)
(require 'init-projectile)

;; Enable the company mode autocompletion for all buffers
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Enable global flycheck mode
;; (add-hook 'after-init-hook #'global-flycheck-mode)

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
(add-hook 'clojure-mode-hook 'my-evil/enable-symbol-word-search)

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

;; TODO (require-package 'projectile-rails)

; Use Flycheck with global mode instead
; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

(setq ruby-deep-indent-paren nil)

(global-set-key (kbd "C-c r r") 'inf-ruby)
(global-set-key (kbd "C-c r c") 'inf-ruby-console-auto)
(add-to-list 'evil-emacs-state-modes 'inf-ruby-mode)

(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ruby-mode-hook 'my-evil/enable-symbol-word-search)

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
(add-hook 'emacs-lisp-mode-hook 'my-evil/enable-symbol-word-search)


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
