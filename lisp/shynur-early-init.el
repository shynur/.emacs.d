;;; -*- lexical-binding: t; -*-

(dolist (filename '("subdirs.el"
                    "leim-list.el"
                    ))
  (load-file (file-name-concat user-emacs-directory
                               "lisp/" filename)))

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

(require 'shynur-package)  ; (find-file-other-window "./shynur-package.el")

(provide 'shynur-early-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
