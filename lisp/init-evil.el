(require-package 'evil)
(require-package 'evil-leader)

;; Evil binds q to macro recording in many contexts. Preserve access to quit-window
(global-set-key (kbd "C-c q") 'quit-window)
(evil-leader/set-key "q" 'quit-window)

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

;; Use , as <leader> key, just like I do in Vim. Home sweet home.
(evil-leader/set-leader ",")

;; Leader binding for extending word definition ad hoc per buffer
(evil-leader/set-key "ew" 'my-evil/extend-word-definition)

;; Enable the evil mode package globally
(global-evil-leader-mode)
(evil-mode 1)

(provide 'init-evil)
