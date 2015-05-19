;;;
;;; My Emacs configuration.
;;; Structure based on: https://github.com/purcell/emacs.d

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;;----------------------------------------------------------------------------
;; Custom's stuff
;;----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default))))


;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)       ;; Machinery for installing required packages
(require 'init-basic-conf) ;; Basic global configurations like toolbar disabling, indent-tabs-mode etc.
(require 'init-mac)
(require 'init-theme)
(require 'init-smart-mode-line)

;;----------------------------------------------------------------------------
;; Supporting modes and packages
;;----------------------------------------------------------------------------
(require 'init-whitespace)
(require 'init-windowmove)
(require 'init-evil)
(require 'init-ido-smex)
(require 'init-smartparens)
(require 'init-projectile)
(require 'init-ag)
(require 'init-company)
(require 'init-flycheck)
(require 'init-rainbowdelimiters)
(require 'init-magit)

;;----------------------------------------------------------------------------
;; Language / format modes
;;----------------------------------------------------------------------------
(require 'init-markdown)
(require 'init-clojure)
(require 'init-ruby)
(require 'init-elisp)
(require 'init-js)
(require 'init-css)
(require 'init-org)
(require 'init-docker)
