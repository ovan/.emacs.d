;;;
;;; My Emacs configuration.
;;; Structure based on: https://github.com/purcell/emacs.d

;; This is handled at init-elpa but Emacs 25 seems to require it here
;; in comments still.
;; (package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa)       ;; Machinery for installing required packages
(require 'init-basic-conf) ;; Basic global configurations like toolbar disabling, indent-tabs-mode etc.
(require 'init-mac)
(require 'init-theme)
(require 'init-spaceline-mode-line)
;; (require 'init-smart-mode-line)

;;----------------------------------------------------------------------------
;; Supporting modes and packages
;;----------------------------------------------------------------------------
(require 'init-whitespace)
(require 'init-windowmove)
(require 'init-evil)
;; (require 'init-ido-smex)
(require 'init-helm)
(require 'init-smartparens)
(require 'init-projectile)
(require 'init-ag)
(require 'init-company)
(require 'init-flycheck)
(require 'init-rainbowdelimiters)
(require 'init-magit)
(require 'init-ace-window)
(require 'init-restclient)

;;----------------------------------------------------------------------------
;; Language / format modes
;;----------------------------------------------------------------------------
(require 'init-markdown)
(require 'init-clojure)
(require 'init-elixir)
(require 'init-ruby)
(require 'init-elisp)
(require 'init-js)
(require 'init-web)
(require 'init-css)
(require 'init-org)
(require 'init-docker)

(custom-set-variables
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))

