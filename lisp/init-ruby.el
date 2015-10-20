;;;; Ruby and Rails development

(require-package 'rake)
(require-package 'robe)
(require-package 'inf-ruby)
(require-package 'rvm)
(require-package 'rspec-mode)
(require-package 'feature-mode)
(require-package 'yaml-mode)
(require-package 'haml-mode)


(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ruby-mode-hook 'my-evil/extend-word-definition)
(add-hook 'ruby-mode-hook 'rspec-mode)
(add-hook 'ruby-mode-hook 'setup-highlighting-whitespace)

(add-hook 'haml-mode-hook 'setup-highlighting-whitespace)

(add-to-list 'evil-emacs-state-modes 'inf-ruby-mode)


(setq ruby-deep-indent-paren nil)

;; Rebind M-. back to 'robe-jump instead of evil mode repeat
(evil-define-key 'normal ruby-mode-map (kbd "M-.") 'robe-jump)

;; Autoindent newlines in insert mode
(evil-define-key 'insert ruby-mode-map (kbd "RET") 'sp-newline)

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-to-list 'company-backends 'company-robe)

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

; Use bash to run rspecs. ZSH messes up ruby path and version
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))

(ad-activate 'rspec-compile)

(provide 'init-ruby)

