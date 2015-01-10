(require-package 'smartparens)

;; Enable globally (should this be only for prog-modes?)
(smartparens-global-mode t)

;; Load smartparens default conf
(require 'smartparens-config)

(sp-use-paredit-bindings)

;; Keybindings for wrapping
(sp-pair "(" ")" :wrap "M-(")
(sp-pair "[" "]" :wrap "M-[")
(sp-pair "{" "}" :wrap "M-{")

(evil-leader/set-key
  "(" (lambda () (interactive) (sp-wrap-with-pair "("))
  "[" (lambda () (interactive) (sp-wrap-with-pair "["))
  "{" (lambda () (interactive) (sp-wrap-with-pair "{")))

(provide 'init-smartparens)
