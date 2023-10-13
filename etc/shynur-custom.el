;;; -*- lexical-binding: t; -*-

;; 你 应当修改 且 只被允许修改 这一页的变量的值 (这些变量的定义式形如
;;     (defconst shynur/c:* ...)
;; ).
;; 如果实在不知道该填什么, 那就 在不改变 数据类型 的前提下 填_空值_:
;;   - 字符串: ""
;;   - 符号 (e.g., ‘'chinese-gb18030’): nil

;; 建议: 填入指向高性能 SSD 的路径.
(defconst shynur/c:appdata/ "d:/Documents/Apps/emacs/"
  "存放杂七杂八的数据的目录 (绝对路径), 不包括配置文件.
可能包含隐私信息 (e.g., 最近访问的文件名).
你必须拥有对该目录的绝对访问权限 (e.g., ‘chmod’任何文件).")

;; 一些 从逻辑上讲 不需要 在 加载 ‘early-init.el’ 时使用的变量,
;; IOW, 下列表达式可以放在 ‘before-init-hook’ 中.
(defconst shynur/c:clang-format-path "d:/Progs/LLVM/bin/clang-format.exe")
(defconst shynur/c:clang-path "d:/Progs/LLVM/bin/clang.exe")
(defconst shynur/c:commonlisp-path "d:/Progs/Steel_Bank_Common_Lisp/sbcl.exe")
(defconst shynur/c:email "one.last.kiss@outlook.com")
(defconst shynur/c:filename-coding 'chinese-gb18030)
(defconst shynur/c:os "MS-Windows 11")
(defconst shynur/c:python-path "d:/Progs/Python/python.exe")
(defconst shynur/c:shell-coding 'utf-8-dos)
(defconst shynur/c:truename "谢骐")

;;; Commentary:
;;
;; 本文件应该尽量做最少的工作; 必须可以独立于其它文件存在 (i.e., 可以被‘emacs -Q’正常执行).

;; 定义成 macro 主要是因为我懒得写‘quote’和双引号.
(defmacro shynur/c:appdata/ (base &optional extension seq-type &rest forms)
  "将“‘shynur/custom:appdata/’BASE+EXTENSION”赋给 BASE; 确保父目录存在.
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
                `(let ((,&appdata/* (file-name-concat shynur/c:appdata/
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
;; coding: utf-8-unix
;; no-byte-compile: t  ; 该文件按名查找.
;; read-symbol-shorthands: (("shynur/c:"  ; 我并没有写过‘shynur-c.el’, 所以不会混淆.
;;                           . "shynur/custom:"))
;; End:
