;;; -*- lexical-binding: t; -*-

(require 'shynur-package)  ; (find-file-other-window "./shynur-package.el")

(defun shynur/init-data/ (option type)
  "确保在“USER-EMACS-DIRECTORY/.data/”下有一个新路径, 其名为 OPTION, 类型为 TYPE; 将该绝对路径赋给 OPTION.
TYPE 的可能值为: \"\" 无后缀, \"/\" 目录, \".EXTENSION\" 文件类型.
返回值为该绝对路径."
  (let ((shynur/init-data/path (file-name-concat user-emacs-directory ".data/"
                                                 (concat (symbol-name option)
                                                         type))))
    (make-directory (file-name-directory shynur/init-data/path)
                    "DWIM")
    (set option shynur/init-data/path)))

(defvar shynur--tmp-count 0)
(defun shynur--intern&bind-tmp ()
  (let ((interned-symbol (intern (format "shynur--%d"
                                         (cl-incf shynur--tmp-count)))))
    (set interned-symbol nil)
    interned-symbol))

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

(defvar shynur/time-running-minutes (1- (- (random 2)))
  "启动时立即加 1, 刚好又到了 整分钟 点, 又加 1: IOW, 极端情况下一启动就 增加 2.")

;; 顺序应当是不重要的.
(require 'shynur-tmp)  ; (find-file-other-window "./shynur-tmp.el")
(require 'shynur-org)  ; (find-file-other-window "./shynur-org.el")

(provide 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
