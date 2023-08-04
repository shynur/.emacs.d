;;; -*- lexical-binding: t; -*-

;; 你只被允许修改这一页 (在下一个‘’字符出现前) 的变量的值.
;; 这些变量的定义式形如‘def*’.

;; 建议: 填入指向高性能 SSD 的路径.
(defvar shynur/c-appdata/ "d:/Documents/Apps/emacs/"
  "存放杂七杂八的数据的目录 (绝对路径), 不包括配置文件.
有些数据 (e.g., 最近访问的文件名) 可能包含隐私信息.")

(add-hook 'before-init-hook
          (lambda ()
            (defvar shynur/c-clang-format-path "d:/Progs/LLVM/bin/clang-format.exe")
            (defvar shynur/c-clang-path "d:/Progs/LLVM/bin/clang.exe")
            (defvar shynur/c-commonlisp-path "d:/Progs/Steel_Bank_Common_Lisp/sbcl.exe")
            (defvar shynur/c-email "one.last.kiss@outlook.com")
            (defvar shynur/c-filename-coding 'chinese-gb18030)
            (defvar shynur/c-os "MS-Windows 11")
            (defvar shynur/c-python-path "python")
            (defvar shynur/c-shell-coding 'chinese-gb18030)
            (defvar shynur/c-truename "谢骐")))

;; 定义成 macro 主要是因为我懒得写‘quote’和双引号.
(defmacro shynur/c-appdata/ (base &optional extension seq-type &rest forms)
  "将“‘shynur/c-appdata/’BASE+EXTENSION”赋给 BASE; 确保父目录存在.
EXTENSION 可能的值为:
  1. nil - pure file (也就是说, 处理不了‘*.nil’文件)
  2.   / - 目录
  3. filename extension - 文件类型

若 SEQ-TYPE 非-nil 则说明 BASE 的值应当为 SEQ-TYPE 类型, 调用函数 SEQ-TYPE 并将返回值赋给 BASE;
若 FORMS 非-nil 则忽略 EXTENSION 和 SEQ-TYPE, 执行 FORMS 就像在‘progn’中, 结果赋给 BASE.

返回值为 BASE."
  (declare (indent 3))
  `(set ',base
        ,(if forms
             `(progn
                ,@forms)
           `(,(or seq-type
                  'identity)
             ,(let ((&appdata/* (gensym "shynur/")))
                `(let ((,&appdata/* (file-name-concat shynur/c-appdata/
                                                      (concat (symbol-name ',base)
                                                              ,(if extension
                                                                   `(concat ,(if (not (eq extension '/))
                                                                                 "."
                                                                               "")
                                                                            (symbol-name ',extension))
                                                                 "")))))
                   (prog1 ,&appdata/*
                     (make-directory (file-name-directory ,&appdata/*) "DWIM"))))))))

(provide 'shynur/custom)

;; Local Variables:
;; read-symbol-shorthands: (("shynur/c-"  ; 我并没有写过‘shynur-c.el’, 所以不会混淆.
;;                           . "shynur/custom-"))
;; coding: utf-8-unix
;; End:
