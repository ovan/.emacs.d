;; CSS / SCSS mode

(require-package 'scss-mode)
(require-package 'rainbow-mode)

(setq css-indent-offset 2)
(setq scss-compile-at-save nil)

;; Enable rainbow mode in css mode always to highligh colors inline
(add-hook 'css-mode-hook 'rainbow-mode)

(provide 'init-css)

