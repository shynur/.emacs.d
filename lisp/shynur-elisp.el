;;; -*- lexical-binding: t; -*-

;;; 与 语言 核心 有关的 设置:

(setq print-gensym t)

(setq print-quoted t) ; 打印成“'foo”而非“(quote foo)”.

(setq print-escape-newlines t               ; 字符串中的 换行 打印成 转义序列“\n”.  注意, 自己写 字符常量 时, 要表示 空格 推荐使用“?\s”.
      print-escape-control-characters nil)  ; "打印成“^C”而非“\3”, 但“\n”和“\f”仍受‘print-escape-newlines’控制.

(setq print-length nil  ; 当打印的 列表 元素数 > 该值时, 超出部分用省略号表示.
      eval-expression-print-length nil)

(setq print-level nil
      eval-expression-print-level nil)

(setq print-circle t)  ; 使用“#N=(#N#)”语法 打印 递归结构.

(setq print-integers-as-characters nil  ; 打印 字符常量 的方式: “115 (#o163, ...)” instea of “?s (#o163, ...)”.
      eval-expression-print-maximum-character most-positive-fixnum)  ; 打印 字符常量 时 括号内: “(#o163, #x73)” instead of “(#o163, #x73, ?s)”.

;;; Feature: ‘emacs-lisp’

(provide 'shynur-elisp)

;; Local Variables:
;; coding: utf-8-unix
;; End:
