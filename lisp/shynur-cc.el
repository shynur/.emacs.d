;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'cc-mode
  (add-hook 'c-mode-common-hook
            (lambda ()
              "使用 行注释 注释掉 region."
              (c-toggle-comment-style -1)))

  ;; 只保留 当前编译环境下 生效的 ifdef 从句.
  (add-hook 'c-mode-common-hook
            #'hide-ifdef-mode)

  (add-hook 'c-mode-common-hook
            (lambda ()
              (c-set-offset 'case-label '+)))

  (add-hook 'c-initialization-hook
            (lambda ()
              "写 C 宏 时换行自动加反斜线; 写注释时换行相当于‘c-indent-new-comment-line’."
              (define-key c-mode-base-map "\C-m"
                #'c-context-line-break))))

(setq c-basic-offset 4)

(setq c-tab-always-indent t)

(provide 'shynur-cc)

;; Local Variables:
;; coding: utf-8-unix
;; End:
