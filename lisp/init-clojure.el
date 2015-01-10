;; Clojure configuration

(require-package 'clojure-mode)
(require-package 'cider)
(require-package 'align-cljlet)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'show-smartparens-mode)

(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'show-smartparens-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'my-evil/enable-symbol-word-search)
(add-hook 'clojure-mode-hook 'setup-highlighting-whitespace)

;; Disable evil for repl, stacktrace, etc modes
(add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-macroexpansion-minor-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)

;; Customize eval output
(setq cider-repl-result-prefix ";; => ")
(setq cider-interactive-eval-result-prefix ";; => ")

;; Make sure we use indenting newline on RET
(evil-define-key 'insert clojure-mode-map (kbd "RET") 'sp-newline)

;; Allow jumping to source
(evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump)

;; Bindings for some smartparens commands
(evil-define-key 'normal clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-J") 'sp-join-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-J") 'sp-join-sexp)

;; Eval last sexp
;; (defadvice backward-sexp (around evil-cider activate)
;;   "In normal-state, last sexp ends at point."
;;   (if (evil-normal-state-p)
;;       (save-excursion
;;         (unless (or (eobp) (eolp)) (forward-char))
;;         ad-do-it)
;;     ad-do-it))


;; Known issues:
;;
;; Improvement ideas:
;;   - Make view doc + source under point that work the same way as
;;     company mode (buffer which exits when you move point)
;;   - evaluate to work with evil in normal mode as expected
;;   - evil leader + bindings for smartparents commands
;;   - clj-refactor?
;;

(provide 'init-clojure)

