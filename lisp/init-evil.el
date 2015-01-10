(require-package 'evil)

;; Enable the evil mode package globally
(evil-mode 1)

;; Evil binds q to macro recording in many contexts. Preserve access to quit-window
(global-set-key (kbd "C-c q") 'quit-window)


(defun my-evil/enable-symbol-word-search ()
  "Helper to enable sane * and # behavior to use with mode hooks"
  (interactive)
  (setq evil-symbol-word-search t))

(provide 'init-evil)
