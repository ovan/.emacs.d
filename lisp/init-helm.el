(require-package 'helm)
(require-package 'helm-ls-git)

(require 'helm-config)

;; Switch the default Helm command prefix C-x c -> C-c h to avoid
;; accidental C-x C-c. This idea (and many other things in this conf)
;; copied from: http://tuhdo.github.io/helm-intro.html
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; Bind helm version of M-x
(global-set-key (kbd "M-x") 'helm-M-x)
;; In evil mode double tapping SPC brings up M-x
(when evil-normal-state-map
  (define-key evil-normal-state-map (kbd "SPC SPC") 'helm-M-x))

;; Helm version of find files
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Helm kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Bind helm browse project to replace list-directory
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

(evil-leader/set-key
 "x" #'helm-M-x
 "fb" #'helm-browse-project
 "bb" #'helm-mini
 "bs" #'mode-line-other-buffer
 "hh" #'helm-resume)

;; Always show helm window at the bottom
;; https://www.reddit.com/r/emacs/comments/345vtl/make_helm_window_at_the_bottom_without_using_any/
(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

;; Make helm the default completion mode. This has to be called before messing
;; with helm-map.
(helm-mode)

;; Show relative paths in helm browse project
(setq helm-ls-git-show-abs-or-relative 'relative)

;; Switch around persistent action and list actions keybindings
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(provide 'init-helm)
