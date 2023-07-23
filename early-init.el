;;; -*- lexical-binding: t; -*-

(setq load-prefer-newer nil
      force-load-messages t)

(push (file-name-concat user-emacs-directory
                        "lisp/") load-path)

(require 'shynur-early-init)  ; (find-file-other-window "./lisp/shynur-early-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; End:
