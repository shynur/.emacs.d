;;; ~shynur/.emacs.d/early-init.el --- Part of Shynur's .emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Xie Qi <one.last.kiss@outlook.com>

;;; Code:

(setq gc-cons-threshold 1000000000
      gc-cons-percentage 0.36789
      load-prefer-newer nil)

(defconst shynur/etc/ "~/.emacs.d/shynur/etc/")

(defun shynur/edit-reverse-region-char (beginning end)
  (interactive "r")
  (insert (nreverse (delete-and-extract-region beginning end))))

(defun shynur/message (format-string &rest args)
  (message #("shynur: %s"
             0 6 (face italic))
           (apply #'format format-string args)))

(defmacro shynur/buffer-eval-after-created (buffer-or-name &rest body)
  (declare (indent 1))
  `(make-thread (lambda ()
                  (while (not (get-buffer ,buffer-or-name))
                    (thread-yield))
                  ,@body)))

(make-directory "~/.emacs.d/.shynur/" t)
(defun shynur/pathname-ensure-parent-directory-exist (pathname)
  (declare (pure t)
           (side-effect-free nil))
  (make-directory (file-name-directory pathname) t)
  pathname)

(defun shynur/string-text->regexp (string)
  (declare (pure t)
           (side-effect-free t))
  (let ((replace-pairs '(("\\" . "\\\\")
                         ("."  . "\\.")
                         ("*"  . "\\*")
                         ("+"  . "\\+"))))
    (mapc (lambda (replace-pair)
            (let ((from (car replace-pair))
                  (to   (cdr replace-pair)))
              (setq string (string-replace from to string)))) replace-pairs))
  string)

(defvar shynur/emacs-running-minutes -2)

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
