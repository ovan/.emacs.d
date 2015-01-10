;; Projectile for project file navigation
(require-package 'projectile)

(evil-leader/set-key
  "ag" 'projectile-ag
  "ff" 'projectile-find-file
  "fd" 'projectile-find-dir
  "ft" 'projectile-toggle-between-implementation-and-test
  "fp" 'projectile-switch-project)

;; Enable globally
(projectile-global-mode)

(provide 'init-projectile)
