#! /usr/bin/emacs --script
;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; 像从 命令行 启动‘python’一样, 进入 Emacs Lisp 交互环境.

;;; Code:

(message "Emacs Lisp (v%s, %s) [%s] on %s
Type \"%s\" to exit."  ; shynur/TODO: Colorize?
         emacs-version
         (format-time-string "%b %e %Y, %T %z"
                             emacs-build-time)
         system-configuration
         system-type
         ;; shynur/TODO:
         ;;      It is inconvenient to type the entire ‘(kill-emacs)’ to
         ;;   exit from REPL.  It would be nice to recognize character ‘^C’.
         "(kill-emacs)")

(let (;; 一些基本设置, 使其更像 Common Lisp.
      ;; 摘自‘~shynur/lisp/shynur-elisp.el’.

      (print-gensym t)

      ;; 打印成“'foo”而非“(quote foo)”.
      (print-quoted t)

      ;; 字符串中的 换行 打印成 转义序列“\n”.
      (print-escape-newlines t)
      ;; "打印成“^C”而非“\3”, 但“\n”和“\f”仍受‘print-escape-newlines’控制.
      print-escape-control-characters
      ;; 不把 multibyte 打印成‘\xXXXX’.
      print-escape-multibyte
      (ctl-arrow t)
      (display-raw-bytes-as-hex t)

      ;; 当打印的 列表 元素数 > 该值时, 超出部分用省略号表示.
      print-length
      eval-expression-print-length

      print-level
      eval-expression-print-level

      ;; 使用“#N=(#N#)”语法 打印 递归结构.
      (print-circle t)

      ;; 打印 字符常量 的方式: “115 (#o163, ...)” instea of “?s (#o163, ...)”.
      print-integers-as-characters
      ;; 打印 字符常量 时 括号内: “(#o163, #x73)” instead of “(#o163, #x73, ?s)”.
      (eval-expression-print-maximum-character most-positive-fixnum)

      ;; Debugger 以 C 风格 显示 函数调用, 而不是 Lisp 风格.
      debugger-stack-frame-as-list
      )

  ;; shynur/TODO:
  ;;      If user simply type blank characters, REPL will exit together
  ;;   with annoying error messages.  That is silly.

  ;; shynur/TODO:
  ;;      Anyway to show error messages and backtraces, WITHOUT REPL
  ;;   exiting?

  (while t
    (write-char ?\n)
    (call-interactively #'eval-expression)))

;; Local Variables:
;; coding: utf-8-unix
;; End:
