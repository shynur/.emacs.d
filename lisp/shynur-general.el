;;; -*- lexical-binding: t; -*-

;;; Mode:

(setq-default major-mode 'text-mode)

;; 如有必要, 会在 写入/重命名 文件后 执行 ‘normal-mode’ 以使用恰当的 major mode.
(setq change-major-mode-with-file-name t)

;;; Minibuffer:

;;; Minibuffer Completion
(setq completion-cycle-threshold nil  ; 补全时, 按 <tab> 会轮换候选词.
      completion-ignored-extensions '())

;;; Read
(setq read-extended-command-predicate #'command-completion-default-include-p
      read-file-name-completion-ignore-case t
      ;; “C-q” 后接 16 进制.
      read-quoted-char-radix 16
      read-buffer-completion-ignore-case t)

(setq enable-recursive-minibuffers t)

;; 大部分情况下, 保留从 ‘read-from-minibuffer’ 获取的文本的属性.
(setq minibuffer-allow-text-properties t)
(setq minibuffer-default-prompt-format #(" (default %s)"
                                         10 12 (face (underline (:foreground "VioletRed1")))))
(setq file-name-shadow-mode t)  ; ‘find-file’时, 若输入绝对路径, 则调暗默认值的前景.

;; 获取输入之后, 恢复进入 minibuffer 之前 当前 frame 的 window-configurations.
(setq read-minibuffer-restore-windows t)

;;; Minibuffer History
(setq history-delete-duplicates t)
(setq history-length t)  ; 无上限.

;;; Register:

;; 用 ‘append-to-register’ 将文本并入已经存储了文本的 register 中时,
;; 可以插入分隔符.  分隔符存储在该变量所指定的 register 中.
(set-register (setq register-separator ?+) "\n\n")

;;; Help:

;; 通过不完整的函数名调用 command 时, 在 echo area 中提示 command 全名.
(setq extended-command-suggest-shorter t)

(setq help-enable-autoload t
      help-enable-completion-autoload t
      ;; 如果一个 autoloaded 符号的 autoload 形式没有提供 docstring,
      ;; 那就加载包含它的定义的文件 以查看 docstring.
      help-enable-symbol-autoload t)

(provide 'shynur-general)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
