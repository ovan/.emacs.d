;; Emacs Lisp mode customizations
;;
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'my-evil/enable-symbol-word-search)
(add-hook 'emacs-lisp-mode-hook 'show-smartparens-mode)
(add-hook 'emacs-lisp-mode-hook 'setup-highlighting-whitespace)

(provide 'init-elisp)

