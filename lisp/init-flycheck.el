(require-package 'flycheck)

;; Enable global flycheck mode
;; TODO Remove this in favor of per mode enabling. Can be irritating
(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'init-flycheck)
