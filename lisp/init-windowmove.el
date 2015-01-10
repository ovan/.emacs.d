
;; Rotate windows from http://www.emacswiki.org/emacs/TransposeWindows
(defun my-window/rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 0)
          (num-windows (count-windows)))
      (while  (< i (- num-windows 1))
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (% (+ i 1) num-windows)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(defalias 'rw 'my-window/rotate-windows)


;; Deal with stuff that opens to other window but doesn't switch focus so you can't quit immediately
(defun my-window/quit-in-other-window ()
  "Run window-quit in other window and then switch back. No-op if != 2 windows"
  (interactive)
  (cond
   ((not (= (count-windows) 2))
    (message "Only applicable with exactly 2 windows!"))
   (t
    (other-window 1)
    (quit-window)
    (other-window 0))))

(evil-leader/set-key
  "Q" 'my-window/quit-in-other-window
  "rw" 'my-window/rotate-windows
  "b" 'mode-line-other-buffer)

(provide 'init-windowmove)

