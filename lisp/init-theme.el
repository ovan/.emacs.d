(require-package 'solarized-theme)
;; (require-package 'dracula-theme)
;; (require-package 'spacemacs-theme)
;; (require-package 'zenburn-theme)

;; Solarized configuration options
;;
;; make the fringe stand out from the background
;; (setq solarized-distinct-fringe-background t)
;; Don't change the font for some headings and titles
;; (setq solarized-use-variable-pitch nil)
;; make the modeline high contrast
;; (setq solarized-high-contrast-mode-line t)
;; Use less bolding
;; (setq solarized-use-less-bold t)
;; Use more italics
;; (setq solarized-use-more-italic t)
;; Use less colors for indicators such as git:gutter, flycheck and similar
;; (setq solarized-emphasize-indicators nil)

;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

;; (load-theme 'zenburn t)
;; (load-theme 'spacemacs-dark t)
;; (load-theme 'solarized-light t)
(load-theme 'solarized-dark t)

;; On Mac, change the font to Inconsolata
(when (eq system-type 'darwin)
  (custom-set-faces
   '(default ((t (:height 150 :width normal :family "Inconsolata"))))))

; Reset background color of whitespace-mode to work with solarized
(custom-set-faces
 '(whitespace-space ((t (:foreground "#073642")))))

(provide 'init-theme)
