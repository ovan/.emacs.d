;; Projectile for project file navigation
(require-package 'projectile)
(require-package 'helm-projectile)

(evil-leader/set-key
  "ag" 'helm-projectile-ag
  "cpf" 'helm-projectile-find-file
  "cpd" 'helm-projectile-find-dir
  "cpt" 'projectile-toggle-between-implementation-and-test
  "cpp" 'helm-projectile-switch-project
  "ff" 'helm-projectile)

;; Enable globally
(projectile-global-mode)

(provide 'init-projectile)
