;; Clojure configuration

(require-package 'clojure-mode)
(require-package 'cider)
(require-package 'align-cljlet)
(require-package 'evil-smartparens)
(require-package 'clojure-cheatsheet)

;; Not spending time to learn to use this right now but maybe one day...
;; (require-package 'clj-refactor)


(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'show-smartparens-mode)
(add-hook 'cider-repl-mode-hook
          (lambda ()
            (define-key cider-repl-mode-map (kbd "C-w h") 'evil-window-left)
            (define-key cider-repl-mode-map (kbd "C-w l") 'evil-window-right)
            (define-key cider-repl-mode-map (kbd "C-w j") 'evil-window-down)
            (define-key cider-repl-mode-map (kbd "C-w k") 'evil-window-up)))


(add-hook 'cider-mode-hook 'eldoc-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'show-smartparens-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'my-evil/extend-word-definition)
(add-hook 'clojure-mode-hook 'setup-highlighting-whitespace)
(add-hook 'clojure-mode-hook #'evil-smartparens-mode)

;; Special indentation rules for known library forms
(add-hook 'clojure-mode-hook
          (lambda ()
            (define-clojure-indent
              (checking 2)))) ; test.check / test.chuck macro

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

;; Allow jumping to source/resource/ns
(evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-find-dwim)

;; Some leader bindings for clojure-mode / cider commands
(evil-leader/set-key-for-mode 'clojure-mode
  "gj" 'cider-jump-to-var
  "gb" 'cider-jump-back
  "gr" 'cider-jump-to-resource
  "ge" 'cider-jump-to-compilation-error
  "al" 'align-cljlet
  "cj" 'cider-jack-in
  "cc" 'cider-connect
  "cr" 'cider-restart
  "cm1" 'cider-macroexpand-1
  "cmm" 'cider-macroexpand-all
  "cn" 'clojure-insert-ns-form)


;; Bindings for some smartparens commands
(evil-define-key 'normal clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-j") 'sp-down-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-k") 'sp-backward-up-sexp)
(evil-define-key 'normal clojure-mode-map (kbd "M-J") 'sp-join-sexp)
(evil-define-key 'insert clojure-mode-map (kbd "M-J") 'sp-join-sexp)

;; Define versions of typical cider-eval-last-x functions to work with
;; evil's normal mode where point is one char left from where it would
;; be in insert mode.

(defun my-clojure/do-with-append (EVAL-FUNC &optional ARGS)
  (let ((args (if (null ARGS) nil ARGS)))
    (cond
     ((evil-normal-state-p)
      (evil-append 1)
      (apply EVAL-FUNC args)
      (evil-normal-state)))))

(defun my-clojure/eval-last-sexp ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp))

(defun my-clojure/pprint-eval-last-sexp ()
  (interactive)
  (my-clojure/do-with-append 'cider-pprint-eval-last-sexp))

(defun my-clojure/eval-last-sexp-to-repl ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp-to-repl))

;; This has a bug that leaves sending buffer to insert mode
(defun my-clojure/insert-last-sexp-in-repl ()
  (interactive)
  (my-clojure/do-with-append 'cider-insert-last-sexp-in-repl))

(defun my-clojure/eval-last-sexp-and-replace ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp-and-replace))

(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "C-c C-e") 'my-clojure/eval-last-sexp)
            (define-key cider-mode-map (kbd "C-c C-p") 'my-clojure/pprint-eval-last-sexp)
            (define-key cider-mode-map (kbd "C-c M-e") 'my-clojure/eval-last-sexp-to-repl)
            (define-key cider-mode-map (kbd "C-c M-p") 'my-clojure/insert-last-sexp-in-repl)
            (define-key cider-mode-map (kbd "C-c C-w") 'my-clojure/eval-last-sexp-and-replace)))

;; Adapted from:
;; https://github.com/stuartsierra/dotfiles/blob/d0d1c46ccc4fdd8d2add363615e625cc29d035b0/.emacs#L307-L312
(defun my-clojure/cider-reset ()
  (interactive)
  (cider-ensure-connected)
  (save-some-buffers)
  (cider-interactive-eval
   "(user/reset)"))

(evil-leader/set-key-for-mode 'clojure-mode
  "ev" #'my-clojure/eval-last-sexp
  "ep" #'my-clojure/pprint-eval-last-sexp
  "er" #'my-clojure/eval-last-sexp-to-repl
  "ei" #'my-clojure/insert-last-sexp-in-repl
  "ew" #'my-clojure/eval-last-sexp-and-replace
  "ek" #'cider-eval-buffer
  "el" #'cider-load-file
  "en" #'cider-eval-ns-form
  "er" #'cider-eval-region
  "et" #'cider-eval-defun-at-point
  "cs" #'clojure-cheatsheet
  "r"  #'my-clojure/cider-reset)

;; Known issues:
;;
;; Improvement ideas:
;;   - Make view doc + source under point that work the same way as
;;     company mode (buffer which exits when you move point)
;;

(provide 'init-clojure)
