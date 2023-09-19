;;; -*- lexical-binding: t; -*-

;;; Mode:

(setq-default major-mode 'text-mode)

(setq auto-mode-case-fold t)

;; 如有必要, 会在 写入/重命名 文件后 执行 ‘normal-mode’ 以使用恰当的 major mode.
(setq change-major-mode-with-file-name t)

;;; Custom Mode:

(setq custom-search-field nil)  ; 感觉不如‘customize-apropos’.
(setq custom-buffer-done-kill nil)  ; 按“[Exit]”(GUI 下 该图标 位于 tool bar) 并不 kill buffer.

(shynur/custom:appdata/ custom-file el)  ; 该文件需要 手动‘load-file’, 所以 直接 设置 即可, 无后顾之忧.

;;; Buffer:

(keymap-global-set "C-x C-b" #'bs-show)

;;; Minibuffer:

(add-hook 'minibuffer-mode-hook
          (lambda ()
            (keymap-set minibuffer-local-completion-map "SPC"
                        #'self-insert-command)
            (keymap-set minibuffer-local-completion-map "?"
                        #'self-insert-command)))

;;; Invoke Command
(setq meta-prefix-char ?\e)

(keymap-global-unset "C-x ESC ESC")  ; ‘repeat-complex-command’

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

;;; Confirmation
;; TODO: 取消 minibuffer 中 <return> 的补全功能.
;;       当可能匹配的结果只有一个时, 它会补全, 但这有些自作主张.

(let ((shynur--completion-regexp-list (mapcar (lambda (regexp)
                                                (concat
                                                 "\\(?:" regexp "\\)"
                                                 "\\|\\`:?shynur[^[:alnum:]]")) '(;; 滤除 ‘prefix--*’ (i.e., 不允许两个 “-” 连续出现).
                                                                                  "\\`-?\\(?:[^-]+\\(?:-[^-]+\\)*-?\\)?\\'"
                                                                                  ;; 滤除 ‘*-internal’ (i.e., 不允许出现 “-internal”).
                                                                                  "\\(?:\\(?:\\`\\|[^l]\\)\\|\\(?:\\`\\|[^a]\\)l\\|\\(?:\\`\\|[^n]\\)al\\|\\(?:\\`\\|[^r]\\)nal\\|\\(?:\\`\\|[^e]\\)rnal\\|\\(?:\\`\\|[^t]\\)ernal\\|\\(?:\\`\\|[^n]\\)ternal\\|\\(?:\\`\\|[^i]\\)nternal\\|\\(?:\\`\\|[^-]\\)internal\\)\\'")))
      (completers [try-completion
                   test-completion
                   all-completions]))
  (seq-doseq (key ["C-h f"
                   "C-h o"
                   "C-h v"
                   ;; "C-h w"  ; 未生效.
                   "C-h x"
                   "M-x"
                   "M-S-x"])
    (let ((original-command (keymap-global-lookup key)))
      (keymap-global-set key
                         (lambda ()
                           (interactive)
                           (unwind-protect
                               (progn
                                 (let ((shynur--completion-regexp-list+ `(,@completion-regexp-list
                                                                          ,@shynur--completion-regexp-list)))
                                   (seq-doseq (completer completers)
                                     (advice-add completer :around
                                                 (lambda (advised-function &rest arguments)
                                                   "Bug#64351#20"
                                                   (let ((completion-regexp-list shynur--completion-regexp-list+))
                                                     (apply advised-function
                                                            arguments))) '((name . "shynur--let-bind-completion-regexp-list")))))
                                 (call-interactively original-command))
                             (seq-doseq (completer completers)
                               (advice-remove completer "shynur--let-bind-completion-regexp-list"))))))))

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

;;; 阅览:

;;; 文字方向
(setq bidi-inhibit-bpa t)  ; 实测 Unicode 字符 202E 仍能生效.
(setq-default bidi-paragraph-direction 'left-to-right)

(put 'narrow-to-region 'disabled '(query nil "禁用该命令 只是为了 演示一下 如何 禁用命令"))

;;; Idle:

(setq idle-update-delay most-positive-fixnum)  ; (Experimental) 永不 update 某些东西.

;;; 改善性能:

;; 不清除 字体 缓存.
(setq inhibit-compacting-font-caches t)

(provide 'shynur-general)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
