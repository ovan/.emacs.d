(require-package 'helm)
(require-package 'helm-ls-git)

(require 'helm-config)

;; Make helm the default completion mode
(helm-mode)

;; Bind helm version of M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; Bind helm browse project to replace list-directory
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

;; Always show helm window at the bottom
;; https://www.reddit.com/r/emacs/comments/345vtl/make_helm_window_at_the_bottom_without_using_any/
(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

;; In evil mode double tapping SPC brings up M-x
(when evil-normal-state-map
  (define-key evil-normal-state-map (kbd "SPC SPC") 'helm-M-x))

;; Show relative paths in helm browse project
(setq helm-ls-git-show-abs-or-relative 'relative)

(evil-leader/set-key
 "x" 'helm-M-x
 "fb" 'helm-browse-project
 "bb" 'helm-buffers-list
 "bs" 'mode-line-other-buffer)

(provide 'init-helm)
