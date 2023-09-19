;;; -*- lexical-binding: t; -*-

;;; Delimiter:

(setq blink-matching-paren-highlight-offscreen t)

;;; Cursor Motion:

;; 一次移动即越过 被渲染为类似 “...” 的区域.
(setq global-disable-point-adjustment nil)

;;; Deletion:

(progn
  (require 'cc-mode)
  (advice-add 'backward-kill-word :before-while
              (lambda (arg)
                "前面顶多只有空白字符 或 后面顶多只有空白字符且前面有空白字符 时,删除前方所有空白"
                (if (and (called-interactively-p 'any)  ; 只在使用键盘且
                         ;; 没有前缀参数时执行.
                         (= 1 arg)
                         (or (save-match-data
                               (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=") nil))
                             (and (looking-at-p (concat "\\=\\(" search-whitespace-regexp "\\)?$"))
                                  (save-match-data
                                    (looking-back (concat search-whitespace-regexp "\\=") nil)))))
                    (prog1 nil
                      (c-hungry-delete))
                  t)))
  (advice-add 'kill-word :before-while
              (lambda (arg)
                "后面顶多只有空白字符 或 前面顶多只有空白字符且后面有空白字符 时, 删除后面所有空白"
                (if (and (called-interactively-p 'any)  ; 只在使用键盘且
                         ;; 没有前缀参数时执行.
                         (= 1 arg)
                         (or (looking-at-p (concat "\\=\\(" search-whitespace-regexp "\\)?$"))
                             (and (save-match-data
                                    (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=") nil))
                                  (looking-at-p (concat "\\=" search-whitespace-regexp)))))
                    (prog1 nil
                      (c-hungry-delete-forward))
                  t))))

;;; Predefined Text:

;;; Abbreviation
(setq abbrev-file-name (prog1 (cl-some (lambda (.extension)
                                         (let ((shynur--abbrev-file (file-name-concat user-emacs-directory
                                                                                      "var" (concat "abbrev_defs" .extension))))
                                           (when (file-exists-p shynur--abbrev-file)
                                             shynur--abbrev-file))) load-suffixes)
                         (add-hook 'after-init-hook
                                   (lambda ()
                                     (shynur/custom:appdata/ abbrev-file-name el))))
      ;; 触发 ‘保存’ 时会询问, 此时可查看是否包含隐私信息.
      save-abbrevs "ask")
(set-register ?a `(file . ,(file-name-concat user-emacs-directory
                                             "var" "abbrev_defs.el")))
(setq only-global-abbrevs nil
      abbrev-minor-mode-table-alist '())
;; ‘POSIX’ => “Portable Operating System Interface”
;; instead of “PORTABLE OPERATING SYSTEM INTERFACE”.
(setq abbrev-all-caps nil)
(setq abbrev-suggest t  ; 手动写下 expansion 时, 提示可以用 abbrev.
      ;; 若写 abbrev 比手写 expansion 节约这么多字符数, 则启用 ‘abbrev-suggest’.
      abbrev-suggest-hint-threshold 0)
;; (customize-set-variable 'abbrev-mode t)
(keymap-global-unset "C-x a i")  ; ‘inverse-add-{mode,global}-abbrev’
(keymap-global-unset "C-x a e")  ; ‘expand-abbrev’

;;; Dynamic Abbreviation
(setq dabbrev-limit nil  ; 不限制 Dynamic Abbrev Expansion 的搜索范围.
      dabbrev-check-other-buffers t
      dabbrev-check-all-buffers   nil)
(setq dabbrev-case-fold-search nil
      dabbrev-case-replace nil)
(keymap-global-unset   "M-/")  ; ‘dabbrev-expand’
(keymap-global-unset "C-M-/")  ; ‘dabbrev-completion’

;;; Snippet
(setq yas-snippet-dirs `(,(file-name-concat user-emacs-directory
                                            "etc/yas-snippets/")))
(require 'yasnippet)
(yas-reload-all)
(keymap-set yas-minor-mode-map "TAB"
            nil)
(keymap-set yas-minor-mode-map "<tab>"
            ;; yas-maybe-expand
            nil)

;;; CUA:

(setq kill-ring-max most-positive-fixnum
      ;; 不将 重复的文本 加到 ‘kill-ring’ 中 (具体行为受 ‘equal-including-properties’ 影响).
      kill-do-not-save-duplicates t)
(setq kill-whole-line nil)  ; ‘kill’ 不删除换行符.
(setq kill-read-only-ok nil)  ; Kill 只读的文本时, beep 且显示 error 消息.
;; (该例选自 <https://gnu.org/s/emacs/manual/html_node/emacs/Kill-Options.html>.)
(setq kill-transform-function (lambda (killed-text)
                                "将它应用到被 kill 的文本上, 并将其返回值加入到 ‘kill-ring’ 中; 若返回 nil 则不加入."
                                (if (string-blank-p killed-text)
                                    killed-text
                                  (string-trim killed-text))))

(keymap-global-set "<mouse-2>" #'mouse-yank-at-click)

;;; Completion:

;;; ‘company’
(setq company-idle-delay 0
      company-minimum-prefix-length 2)
(setq company-dabbrev-code-everywhere t)  ; 还在 comment 和 string 中进行 completion.
(setq company-dabbrev-code-other-buffers t  ; 在具有相同‘major-mode’的 buffer 中搜索候选词.
      ;; 在 current buffer 中搜索代码块中的关键词的时间限制.
      company-dabbrev-code-time-limit 2)
(setq company-show-quick-access t  ; 给候选词编号.
      company-tooltip-offset-display 'lines  ; 原本在候选词界面的右侧是由 scroll bar, 现改成: 上/下面分别有多少候选词.
      company-tooltip-limit 10)
(setq company-clang-executable shynur/custom:clang-path)
(global-company-mode)

;;; Whitespace:

(setq-default indent-tabs-mode nil
              tab-width 4)

;; 执行 ‘delete-trailing-whitespace’ 时, 还删除首尾的多余的空行.
(setq delete-trailing-lines t)

;; 不高亮行尾的 whitespace, 因为没必要.
(setq show-trailing-whitespace nil)

;;; Indent:

(setq tab-always-indent t)

;;; Region:

(setq mark-even-if-inactive nil)
(transient-mark-mode)  ; 高亮 region.

(setq shift-select-mode t)

;; 选中文本后输入字符, 会先删除刚刚选择的文本, 再插入输入的字符.
(delete-selection-mode)

;;; Jump:

;; 调用 ‘goto-line’ 时, 每个 buffer 使用自己的 历史记录.
(setq goto-line-history-local t)

;;; Mark:

(setq mark-ring-max 10  ; 太大的话就不能轮回访问了.
      ;; ‘global-mark-ring’ 只会在离开某个 buffer 时, 记住那个 buffer
      ;; 最后设置的 mark, 这相当于将 buffer 作为节点的路径;
      ;; 因此, 可以设置为较大的值.
      global-mark-ring-max most-positive-fixnum)

(provide 'shynur-edit)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
