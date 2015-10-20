;; Projectile for project file navigation
(require-package 'projectile)
(require-package 'helm-projectile)

;; Enable globally
(projectile-global-mode)

;; Use helm as completion system
(setq projectile-completion-system 'helm)

;; Enable helm keybindings
(helm-projectile-on)

(evil-leader/set-key
  "ag" 'helm-projectile-ag
  "cpf" 'helm-projectile-find-file
  "cpd" 'helm-projectile-find-dir
  "cpt" 'projectile-toggle-between-implementation-and-test
  "cpp" 'helm-projectile-switch-project
  "ff" 'helm-projectile)

(provide 'init-projectile)
