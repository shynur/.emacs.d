;;; -*- lexical-binding: t; -*-

(setq load-prefer-newer nil)
(add-to-list 'load-path (file-name-concat user-emacs-directory
                                          "lisp/"))

(require 'shynur-early-init)  ; (find-file-other-window "./lisp/shynur-early-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; End:
