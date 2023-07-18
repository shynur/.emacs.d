;;; -*- lexical-binding: t; -*-

(defun shynur/init-data/ (option type)
  "确保在“USER-EMACS-DIRECTORY/.data/”下有一个新路径, 其名为 OPTION, 类型为 TYPE; 将该绝对路径赋给 OPTION.
TYPE 的可能值为: \"\" 无后缀, \"/\" 目录, \".EXTENSION\" 文件类型."
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

;; 顺序应当是不重要的.
(require 'shynur-tmp)
(require 'shynur-org)

(provide 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
