;;;
;;; My Emacs configuration.
;;; Structure based on: https://github.com/purcell/emacs.d

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)       ;; Machinery for installing required packages
(require 'init-basic-conf) ;; Basic global configurations like toolbar disabling, indent-tabs-mode etc.
(require 'init-mac)
(require 'init-theme)

;;----------------------------------------------------------------------------
;; Supporting modes and packages
;;----------------------------------------------------------------------------
(require 'init-whitespace)
(require 'init-windowmove)
(require 'init-evil)
(require 'init-ido-smex)
(require 'init-smartparens)
(require 'init-projectile)
(require 'init-ag)
(require 'init-company)
(require 'init-flycheck)
(require 'init-rainbowdelimiters)
(require 'init-magit)

;;----------------------------------------------------------------------------
;; Language / format modes
;;----------------------------------------------------------------------------
(require 'init-markdown)
(require 'init-clojure)



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

(add-hook 'text-mode-hook 'setup-highlighting-whitespace)
(add-hook 'emacs-lisp-mode-hook 'setup-highlighting-whitespace)
(add-hook 'ruby-mode-hook 'setup-highlighting-whitespace)
(add-hook 'haml-mode-hook 'setup-highlighting-whitespace)

