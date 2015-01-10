(require-package 'evil)

;; Enable the evil mode package globally
(evil-mode 1)

;; Evil binds q to macro recording in many contexts. Preserve access to quit-window
(global-set-key (kbd "C-c q") 'quit-window)


(defun my-evil/enable-symbol-word-search ()
  "Helper to enable using symbols, not words, for * and # behavior."
  (interactive)
  (setq evil-symbol-word-search t))

;; Make evil behave like Vim by including _ and - to definition of a word
;; See FAQ at the bottom of: https://bitbucket.org/lyro/evil/wiki/Home
(defun my-evil/extend-word-definition ()
  "Make _ and - part of the word definition in current buffer. Enable mode wide by attaching to mode hook."
  (interactive)
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w"))

(provide 'init-evil)
