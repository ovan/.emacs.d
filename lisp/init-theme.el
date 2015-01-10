(require-package 'color-theme-solarized)

;; Load the solarized dark. Handle starting as daemon by only loading the theme
;; when a frame has been created.
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (f)
                (with-selected-frame f
                  (set-frame-parameter f 'background-mode 'dark)
                  (load-theme 'solarized t)))))

;; On Mac, change the font to Inconsolata
(when (eq system-type 'darwin)
  (custom-set-faces
   '(default ((t (:height 140 :width normal :family "Inconsolata"))))))

; Reset background color of whitespace-mode to work with solarized
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :width normal :family "Inconsolata"))))
 '(whitespace-space ((t (:foreground "#073642")))))

(provide 'init-theme)

