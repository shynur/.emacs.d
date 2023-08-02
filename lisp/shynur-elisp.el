;;; -*- lexical-binding: t; -*-

;;; 与 语言 核心 有关的 设置:

(setq print-gensym t)

(setq print-quoted t) ; 打印成“'foo”而非“(quote foo)”.

(setq print-escape-newlines t  ; 字符串中的 换行 打印成‘\n’.  注意, 推荐用‘?\s’表示空格的字符常量.
      ;; "打印成‘^C’而非‘\3’, 但‘\n’和‘\f’仍受‘print-escape-newlines’控制.
      print-escape-control-characters nil
      ctl-arrow t
      ;; 不把 multibyte 打印成‘\xXXXX’.
      print-escape-multibyte nil
      ;; 若不启用‘ctl-arrow’, 则‘\x80’而非‘\200’.
      display-raw-bytes-as-hex t)

(setq print-length nil  ; 当打印的 列表 元素数 > 该值时, 超出部分用省略号表示.
      eval-expression-print-length nil)

(setq print-level nil
      eval-expression-print-level nil)

(setq print-circle t)  ; 使用“#N=(#N#)”语法 打印 递归结构.

(setq print-integers-as-characters nil  ; 打印 字符常量 的方式: “115 (#o163, ...)” instea of “?s (#o163, ...)”.
      eval-expression-print-maximum-character most-positive-fixnum)  ; 打印 字符常量 时 括号内: “(#o163, #x73)” instead of “(#o163, #x73, ?s)”.

;; Debugger 以 C 风格 显示 函数调用, 而不是 Lisp 风格.
(setq debugger-stack-frame-as-list nil)

;;; Feature: ‘emacs-lisp’

(provide 'shynur-elisp)

;; Local Variables:
;; coding: utf-8-unix
;; End:
