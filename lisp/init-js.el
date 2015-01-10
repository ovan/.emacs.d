;; JS mode customizations

(setq js-indent-level 2)
(evil-define-key 'insert js-mode-map (kbd "RET") 'sp-newline)

(add-hook 'js-mode-hook 'rainbow-delimiters-mode)
(add-hook 'js-mode-hook 'my-evil/extend-word-definition)
(add-hook 'js-mode-hook 'setup-highlighting-whitespace)

(provide 'init-js)

