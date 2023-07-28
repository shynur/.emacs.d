;;; -*- lexical-binding: t; -*-

;; See (info "(emacs) Early Init File")
;;
;;      This file is loaded before the package system and GUI is
;;   initialized, so in it you can customize variables that affect
;;   the package initialization process, such as
;;   ‘package-enable-at-startup’, ‘package-load-list’, and
;;   ‘package-user-dir’.
;;
;;      We don’t recommend you move into ‘early-init.el’
;;   customizations that can be left in ‘init.el’.  That is because
;;   ‘early-init.el’ is read before the GUI is initialized, so
;;   customizations related to GUI features will not work reliably in
;;   ‘early-init.el’.  By contrast, ‘init.el’ is read after the GUI
;;   is initialized.  If you must have customizations in
;;   ‘early-init.el’ that rely on GUI features, make them run off
;;   hooks provided by the Emacs startup, such as ‘window-setup-hook’
;;   or ‘tty-setup-hook’.

(dolist (subdir '("lisp/themes/"
                  "modules/"
                  ))
  (push (file-name-concat user-emacs-directory
                          subdir) load-path))

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

(startup-redirect-eln-cache ".data/eln-cache")
(require 'shynur-package)  ; (find-file-other-window "./shynur-package.el")

(provide 'shynur-early-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
