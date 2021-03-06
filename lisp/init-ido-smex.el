(require-package 'ido-vertical-mode)
(require-package 'flx)
(require-package 'flx-ido)
(require-package 'smex)

;; Enable ido for better file navigation & buffer switching
(ido-mode 1)
(ido-everywhere 1)

;; Vertical mode to make it actually usable
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; Improved flex matching algorithm
(flx-ido-mode 1)
;; Disable ido faces to see flx highlights
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

;; Smex for better M-x (fuzzy completion etc.)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Evil mode and evil leader bindings
;;

(when evil-normal-state-map
  (define-key evil-normal-state-map (kbd "SPC SPC") 'smex))

(evil-leader/set-key
  "x" 'smex
  "bb" 'ido-switch-buffer
  "bo" 'ido-switch-buffer-other-window
  "bs" 'mode-line-other-buffer
  "bn" 'next-buffer
  "bp" 'previous-buffer)

(provide 'init-ido-smex)

