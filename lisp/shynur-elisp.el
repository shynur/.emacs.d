;;; 与 语言 核心 有关的 设置.  -*- lexical-binding: t; -*-

(setq integer-width 127)  ; Bignum 的位宽.

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

(setq print-circle t  ; 使用 “#N=(#N#)” 语法 打印 递归结构.
      ;; 允许 (字面上) 读取循环结构.
      read-circle t)

(setq print-integers-as-characters nil  ; 打印 字符常量 的方式: “115 (#o163, ...)” instea of “?s (#o163, ...)”.
      ;; 打印 字符常量 时 括号内: “(#o163, #x73)” instead of “(#o163, #x73, ?s)”.
      eval-expression-print-maximum-character most-positive-fixnum)

;; Debugger 以 C 风格 显示 函数调用, 而不是 Lisp 风格.
(setopt debugger-stack-frame-as-list nil)

;; 有关该值的合适范围的讨论 (无果): <https://emacs.stackexchange.com/q/76246/39388>
(setopt max-lisp-eval-depth 800)

;; GC 时在 echo area 显示信息, 但不会并入到 “*Messages*” 中.
(setopt garbage-collection-messages t)

;;; Compilation:

(defun shynur/elisp:compile-dir (dir)
  (interactive "DCompile ELisp Files Under: ")
  (dolist (pathname (directory-files-recursively dir
                                                 "[^/]+\\.el\\'"
                                                 t))
    (byte-compile-file pathname)))

(provide 'shynur-elisp)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
