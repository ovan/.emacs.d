;; Whitespace handling functions
;; from: https://github.com/candera/emacs/blob/3cc572daf3148a1aebe2fc69c1c93e462dba2fee/init.el#L298
;;
(defun detabify-buffer ()
  "Calls untabify on the current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun clean-up-whitespace ()
  "Calls untabify and delete-trailing-whitespace on the current buffer."
  (interactive)
  (detabify-buffer)
  (delete-trailing-whitespace))

(defun toggle-show-whitespace ()
  (interactive)
  (setq show-trailing-whitespace
        (not show-trailing-whitespace)))

(defun setup-highlighting-whitespace ()
  "Use with mode hooks to setup automatic trailing whitespace highlighting"
  (setq show-trailing-whitespace t))

(defun stop-highlighting-whitespace ()
  (setq show-trailing-whitespace nil))

(global-set-key (kbd "C-x t") 'clean-up-whitespace)

; Don't show line break $ in whitespace-mode
(setq whitespace-style '(face spaces space-mark tabs tab-mark))

(provide 'init-whitespace)

