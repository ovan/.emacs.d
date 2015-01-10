(require-package 'company)
;; Enable the company mode autocompletion for all buffers
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
