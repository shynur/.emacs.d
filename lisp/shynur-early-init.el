;;; -*- lexical-binding: t; -*-

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

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
    `(progn
       (setq ,&buffer-or-name ,buffer-or-name)
       (make-thread (lambda ()
                      (while (not (get-buffer ,&buffer-or-name))
                        (thread-yield))
                      ,@body)))))

(defvar shynur/time-running-minutes -2)

(provide 'shynur-early-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
