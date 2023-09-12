;;; -*- lexical-binding: t; -*-

;;; Snippet: ‘yasnippet’

(setq yas-snippet-dirs `(,(file-name-concat user-emacs-directory
                                            "etc/yas-snippets/")))
(require 'yasnippet)
(yas-reload-all)

(keymap-set yas-minor-mode-map "TAB"
            nil)
(keymap-set yas-minor-mode-map "<tab>"
            ;; yas-maybe-expand
            nil)

;;; Delimiter

(setq blink-matching-paren-highlight-offscreen t)

;;; Cursor Move

;; 一次移动即越过 被渲染为类似 “...” 的区域.
(setq global-disable-point-adjustment nil)

;;; Deletion

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

;;; Predefined Text

(keymap-global-set "<f9>"
                   (lambda ()
                     "插入非常常见的, 在任何时候都应该提供补全的文本."
                     (interactive)
                     (insert (let (message-log-max)
                               (eval-when-compile
                                 (require 'cl-lib))
                               (cl-second
                                (read-multiple-choice
                                 "插入文本"
                                 '(
                                   (?0 "")
                                   (?1 "")
                                   (?2 "")
                                   (?3 "")
                                   (?4 "")
                                   (?5 "")
                                   (?6 "")
                                   (?7 "")
                                   (?8 "")
                                   (?9 "")
                                   (?a "")
                                   (?b "")
                                   (?c "")
                                   (?d "")
                                   (?e "")
                                   (?f "")
                                   (?g "")
                                   (?h "")
                                   (?i "")
                                   (?j "")
                                   (?k "")
                                   (?l "")
                                   (?m "")
                                   (?n "")
                                   (?o "")
                                   (?p "")
                                   (?q "")
                                   (?r "")
                                   (?s "shynur")
                                   (?t "")
                                   (?u "")
                                   (?v "")
                                   (?w "")
                                   (?x "")
                                   (?y "")
                                   (?z "")
                                   )))))))

;;; CUA

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

;;; Whitespace

(setq-default indent-tabs-mode nil
              tab-width 4)

;; 执行 ‘delete-trailing-whitespace’ 时, 还删除首尾的多余的空行.
(setq delete-trailing-lines t)

;; 不高亮行尾的 whitespace, 因为没必要.
(setq show-trailing-whitespace nil)

;;; Indent

(setq tab-always-indent t)

;;; Region

(setq mark-even-if-inactive nil)
(transient-mark-mode)  ; 高亮 region.

(setq shift-select-mode t)

;; 选中文本后输入字符, 会先删除刚刚选择的文本, 再插入输入的字符.
(delete-selection-mode)

;;; Jump

;; 调用 ‘goto-line’ 时, 每个 buffer 使用自己的 历史记录.
(setq goto-line-history-local t)

;;; Mark

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
