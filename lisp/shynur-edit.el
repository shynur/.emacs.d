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
                               (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=")))
                             (and (looking-at-p (concat "\\=\\(" search-whitespace-regexp "\\)?$"))
                                  (save-match-data
                                    (looking-back (concat search-whitespace-regexp "\\="))))))
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
                                    (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=")))
                                  (looking-at-p (concat "\\=" search-whitespace-regexp)))))
                    (prog1 nil
                      (c-hungry-delete-forward))
                  t))))

(provide 'shynur-edit)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
