;;; ~shynur/.emacs.d/early-init.el --- Part of Shynur’s Emacs Configuration  -*- lexical-binding: t; -*-

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

(setq load-prefer-newer nil)

(make-directory "~/.emacs.d/.shynur/" t)

(defun shynur/message-format (format-string)
  #("在开头加上“Shynur: ”"
    6 13 (face (shadow italic)))
  (declare (pure t)
           (indent 1))
  (format #("Shynur: %s"
            0 7 (face (shadow italic)))
          format-string))

(defmacro shynur/buffer-eval-after-created (buffer-or-name &rest body)
  (declare (indent 1))
  (let ((&buffer-or-name (gensym "shynur/buffer-eval-after-created-")))
    `(let ((,&buffer-or-name ,buffer-or-name))
       (make-thread (lambda ()
                      (while (not (get-buffer ,&buffer-or-name))
                        (thread-yield)))
                    ,@body))))

(defun shynur/pathname-~/.emacs.d/.shynur/ (&rest pathnames)
  (declare (pure t))
  (apply #'file-name-concat
         "~/.emacs.d/.shynur/" pathnames))

(defvar shynur/time-running-minutes -2)

;; Local Variables:
;; coding: utf-8-unix
;; End:
;;; ~shynur/.emacs.d/early-init.el ends here
