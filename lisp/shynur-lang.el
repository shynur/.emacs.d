;;; -*- lexical-binding: t; -*-

;;; Org:

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key [f9] "\N{ZERO WIDTH SPACE}")))

(add-hook 'org-mode-hook
          #'org-num-mode)

;; [[package:melpa][org-superstar]]
(add-hook 'org-mode-hook
          #'org-superstar-mode)

(add-hook 'org-mode-hook
          #'yas-minor-mode)

(add-hook 'org-mode-hook
          (lambda ()
            (when (bound-and-true-p electric-indent-mode)
              (electric-indent-local-mode -1))))

(setq org-link-descriptive nil)  ; 展开link.

(setq org-support-shift-select t)

(add-hook 'org-mode-hook
          (lambda ()
            "有续行"
            (toggle-truncate-lines 0)))

;;; Binary:

(add-hook 'hexl-mode-hook
          (lambda ()
            "初始化 ‘before-save-hook’, 排除元素 t 以阻止运行全局 ‘before-save-hook’."
            (setq-local before-save-hook ())))

;;; Web:

(add-hook 'html-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (zerop (buffer-size)))
              (insert "<!DOC"))))

;;; SQL:

(setq sql-product 'ansi)  ; 选择方言以使用合适的高亮方案.

;;; CC:

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

(provide 'shynur-lang)

;; Local Variables:
;; coding: utf-8-unix
;; End:
