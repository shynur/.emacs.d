;;; -*- lexical-binding: t; -*-

;; See file “PREFIXDIR/share/emacs/28.2/lisp/subdirs.el” which comes
;; with Emacs distribution:
;;
;;      In load-path, after this directory should come certain of its
;;  subdirectories.  Here we specify them.

(normal-top-level-add-to-load-path (mapcar (lambda (filename)
                                             (file-name-concat user-emacs-directory
                                                               "lisp/" filename))
                                           '("themes")))

;; Local Variables:
;; coding: utf-8-unix
;; End:
