;;;; OSX specific keybindings and modifications
;;;;

;; For Mac it's easier to preserve Alt for things like [, {, \, |, etc.
;; and use Cmd as Meta instead.
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq ns-right-command-modifier 'super)
  (setq ns-option-modifier nil))

(provide 'init-mac)

