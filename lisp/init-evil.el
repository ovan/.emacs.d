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
;;
;; Note! Changing the default for evil-symbol-word-search mostly makes
;; this unnecessary but let's keep it around for cases when symbol
;; search is not desired but wider word definition still is.
(defun my-evil/extend-word-definition ()
  "Make _ and - part of the word definition in current buffer. Enable mode wide by attaching to mode hook."
  (interactive)
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w"))

;; Reverse the default behavior and make make evil * and # search for
;; symbols instead of words. This can be overridden per mode if
;; desired.
(setq-default evil-symbol-word-search t)

;; Use , as <leader> key, just like I do in Vim. Home sweet home.
(evil-leader/set-leader ",")

;; Map the behavior of ESC to §-key because Phil Schiller stole my
;; hardware ESC on mbp :(.
(global-set-key (kbd "§") 'evil-force-normal-state)

;; Show line numbers relative to current position using nlinum-relative
;; (nlinum-relative-setup-evil)
(evil-leader/set-key
  "ll" 'nlinum-relative-toggle)

;; Enable the evil mode package globally
(global-evil-leader-mode)
(evil-mode 1)

(provide 'init-evil)
