;;; -*- lexical-binding: t; -*-

(dolist (subdir '("themes/"
                  ))
  (push (file-name-concat user-emacs-directory
                          "lisp/" subdir) load-path))

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

(require 'shynur-package)  ; (find-file-other-window "./shynur-package.el")

(provide 'shynur-early-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
