;;; ~shynur/.emacs.d/early-init.el --- Part of Shynur's Emacs Configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2023 谢骐 <one.last.kiss@outlook.com>

;;; Code:

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789
      load-prefer-newer nil)

(make-directory "~/.emacs.d/.shynur/" t)

(defun shynur/edit-reverse-characters (beginning end)
  "将选中的区域的所有字符倒序排列"
  (declare (pure   nil)
           (indent nil)
           (interactive-only nil)
           (side-effect-free nil)
           (completion (lambda (_symbol current-buffer)
                         "read-only的缓冲区肯定编辑不了"
                         (with-current-buffer current-buffer
                           (not buffer-read-only)))))
  (interactive "r")
  (insert (nreverse (delete-and-extract-region beginning end))))

(defun shynur/message (format-string &rest arguments)
  #("效果同`message',只是在开头加上\"Shynur: \""
    21 29 (face (shadow italic)))
  (declare (indent 1)
           (side-effect-free nil))
  (message #("Shynur: %s"
             0 8 (face (shadow italic)))
           (apply #'format
                  format-string arguments)))

(defmacro shynur/buffer-eval-after-created (buffer-or-name &rest body)
  (declare (indent 1))
  (let ((&buffer-or-name (gensym "shynur/buffer-gensym-")))
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

;;; End of Code

;; Local Variables:
;; coding: utf-8-unix
;; eval: (let ((case-fold-search t))
;;         (highlight-phrase "shynur[^[:blank:][:space:][:cntrl:]()`'\"]*"
;;                           'underline))
;; prettify-symbols-alist: (("lambda" . ?λ))
;; eval: (prettify-symbols-mode)
;; no-byte-compile: t
;; no-native-compile: t
;; End:
;;; ~shynur/.emacs.d/early-init.el ends here
