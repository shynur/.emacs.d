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
(setopt completion-cycle-threshold nil  ; 补全时, 按 <tab> 会轮换候选词.
        completion-ignored-extensions '()
        completion-styles '(basic partial-completion initials))
(setopt completion-auto-help t  ; 按一次 <tab> 以显示 help 列表.
        ;; 对符号进行 completion 时, 在符号所在的那一行显示符号的类型和文档首行.
        completions-detailed t)

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

(keymap-global-set "C-c s" #'shortdoc-display-group)

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

(global-so-long-mode)

;;; Backup & Auto-Saving & Reverting:

(setopt make-backup-files t
        ;; 备份到哪个目录列表, 默认为当前目录.
        backup-directory-alist ())
(setopt backup-by-copying nil
        backup-by-copying-when-linked t
        ;; 当不 copy 就会改变文件的 owner/group 时,
        backup-by-copying-when-mismatch t
        ;; 对所有用户应用 ‘backup-by-copying-when-mismatch’.
        backup-by-copying-when-privileged-mismatch most-positive-fixnum)
(setopt version-control nil  ; 自动选择是否使用记数备份 (e.g., “file.txt.~42~”).
        kept-old-versions 1  ; 仅保留最初版本
        kept-new-versions 3  ; 和 3 个最新版本.
        delete-old-versions t
        ;; 执行 ‘dired-clean-directory’ 时保留的新版本数.
        dired-kept-versions kept-new-versions)

;; 此外, Emacs 在发生致命错误 (e.g., “kill %emacs”) 时会直接触发自动保存.
(setopt auto-save-default t
        auto-save-no-message nil)
(setopt auto-save-interval 20  ; 键入这么多个字符之后触发自动保存.
        ;; 经过这么多秒数的 idleness 之后触发自动保存,
        ;; 还可能执行一次 GC (这是一条 heuristic 的建议, Emacs 可以不遵循, e.g., 当编辑大文件时).
        auto-save-timeout 30)
(setopt delete-auto-save-files t  ; 保存时自动删除 auto-save-file.
        kill-buffer-delete-auto-save-files nil)
(shynur/custom:appdata/ tramp-auto-save-directory /)
(shynur/custom:appdata/ auto-save-list-file-prefix /)

(setopt revert-without-query '("[^z-a]")  ; 调用 ‘revert-buffer’ 时无需确认.
        revert-buffer-quick-short-answers t)
(setq revert-buffer-with-fine-grain-max-seconds most-positive-fixnum)
(setopt auto-revert-use-notify t
        ;; 默认同时使用被动的 OS 级 file-notification 和主动的 poll (poll 在编辑 remote-file 时无可替代).
        ;; 在此关闭 polling.
        auto-revert-avoid-polling t)
(setq-local buffer-auto-revert-by-notification t)  ; E.g., 令 Dired 使用 file-notification.
(setopt auto-revert-remote-files t
        global-auto-revert-non-file-buffers t
        ;; Auto-revert 时还检查 VC 状态, 即使文件没有修改时也检查.
        auto-revert-check-vc-info t)
(setopt auto-revert-verbose t)
(setopt auto-revert-interval 5)  ; Buffer-menu 只使用 poll 更新.
(global-auto-revert-mode)

;;; Evaluation:

(setopt debug-on-quit nil  ; 按下 “C-g” 时是否要进入 debugger.
        ;; 在 ‘eval-expression’ 时暂时地将 ‘debug-on-error’ 设置为 t.
        eval-expression-debug-on-error t)

(provide 'shynur-general)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
