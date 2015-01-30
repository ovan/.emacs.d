;; (require-package 'color-theme-solarized)
(require-package 'zenburn-theme)

;; Use dark version always
;; (setq frame-background-mode 'dark)

;; Handle starting as daemon by only loading the theme when a frame has been created.
(add-hook 'after-make-frame-functions
          (lambda (f)
            (load-theme 'zenburn t)))
            ;; (load-theme 'solarized t)))

;; On Mac, change the font to Inconsolata
(when (eq system-type 'darwin)
  (custom-set-faces
   '(default ((t (:height 140 :width normal :family "Inconsolata"))))))

; Reset background color of whitespace-mode to work with solarized
(custom-set-faces
 '(whitespace-space ((t (:foreground "#073642")))))

(provide 'init-theme)
