;;; -*- lexical-binding: t; -*-

;;; 书写习惯:

(setopt sentence-end-without-period nil
        sentence-end-double-space t
        colon-double-space nil)

;;; Org:

;; headline
(add-hook 'org-mode-hook
          (lambda ()
            "打开 Org 文件时, 折叠所有其余部分."
            (when (and (featurep 'saveplace)
                       (default-value 'save-place-mode))
              (org-fold-hide-block-all)
              (org-fold-hide-sublevels most-positive-fixnum)
              (org-reveal)))
          99)
(add-hook 'org-mode-hook #'org-num-mode)
;; Org 似乎已经有了‘org-eldoc-load’, 加上这一句反而不能开启.
;; (add-hook 'org-mode-hook #'eldoc-mode)  ; 编辑 headline 时显示层级.
(setopt org-tags-column -60)  ; 将 tags 的右边缘与 C60 对齐.

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local prettify-symbols-alist prettify-symbols-alist)) -100)
(add-hook 'org-mode-hook #'prettify-symbols-mode 99)

(with-eval-after-load 'org
  (keymap-set org-mode-map "<f9>" "\N{ZERO WIDTH SPACE}"))
(add-hook 'org-mode-hook
          (lambda ()
            (push '("\N{ZERO WIDTH SPACE}" . ?‸) prettify-symbols-alist)))

(add-hook 'org-mode-hook
          (lambda ()
            (when (bound-and-true-p electric-indent-mode)
              (electric-indent-local-mode -1))))

(setopt org-link-descriptive nil)  ; 展开 link.

(setopt org-support-shift-select t)

(add-hook 'org-mode-hook
          (lambda ()
            "有续行"
            (toggle-truncate-lines 0)))

(add-hook 'outline-mode-hook #'page-break-lines-mode)

(setopt org-entities-user '(("newline" "\\\\" "\\\\" "<br />" "\n" "\n" "\n")))

;; Babel
(with-eval-after-load 'recentf
  (push (lambda (path)
          (string-prefix-p
           (file-name-concat temporary-file-directory "babel-")
           path
           t)) recentf-exclude))
(progn
  (make-variable-buffer-local 'shynur/org:remove-RESUILTS-before-saving)
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'before-save-hook
                        (lambda ()
                          (when (bound-and-true-p shynur/org:remove-RESUILTS-before-saving)
                            (org-babel-remove-result-one-or-many t)))
                        -90 "buffer local"))))

;; TODO
(setopt org-export-with-priority t)

;;; Makefile:

(add-hook 'makefile-gmake-mode-hook #'indent-tabs-mode)

;;; Binary:

(add-hook 'hexl-mode-hook
          (lambda ()
            "初始化 ‘before-save-hook’, 排除元素 t 以阻止运行全局 ‘before-save-hook’."
            (setq-local before-save-hook ())))

;;; Web:

;;; HTML
(add-hook 'html-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (zerop (buffer-size)))
              (insert "<!DOC"))))
;; E.g., 让 “#ffffff” 显示白色.
(add-hook 'html-mode-hook  #'rainbow-mode)
;; 有时 HTML 会嵌套很深, 因此需要更大的PDL.  在此使 PDL 自动增长.
(setopt shr-offer-extend-specpdl t)

(add-hook 'css-mode-hook   #'rainbow-mode)
(add-hook 'javascript-mode-hook #'rainbow-mode)

;;; JavaScript
(add-hook 'javascript-mode-hook #'hs-minor-mode)

;;; Lisp:

;; E.g., 让 “#ffffff” 显示白色.
(add-hook 'emacs-lisp-mode-hook #'rainbow-mode)

(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(add-hook 'ielm-mode-hook  #'eldoc-mode)

;; Common Lisp 解释器
(setopt inferior-lisp-program shynur/custom:commonlisp-path)

;;; Python:

(setopt python-shell-interpreter shynur/custom:python-path
        ;; python-shell-interpreter-interactive-arg "-i"
        )

;;; SQL:

(setopt sql-product 'ansi)  ; 选择方言以使用合适的高亮方案.

(add-hook 'sql-mode-hook #'abbrev-mode)

;;; CC:

(add-hook 'c-mode-common-hook #'hs-minor-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            "使用 行注释 注释掉 region."
            (c-toggle-comment-style -1)))

;; 只保留 当前编译环境下 生效的 ifdef 从句.
(add-hook 'c-mode-hook #'hide-ifdef-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)))

(add-hook 'c-initialization-hook
          (lambda ()
            "写 C 宏 时换行自动加反斜线; 写注释时换行相当于‘c-indent-new-comment-line’."
            (define-key c-mode-base-map "\C-m"
                        #'c-context-line-break)))

(setopt c-basic-offset 4
        c-tab-always-indent t)

;;; 混用:

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(keymap-set
 prog-mode-map "C-c f"
 (lambda ()
   "调用“clang-format --Werror --fallback-style=none --ferror-limit=0 --style=file:~/.emacs.d/etc/clang-format.yaml”.
在 C 语系中直接 (整个 buffer 而不仅是 narrowed region) 美化代码, 否则美化选中区域."
   (interactive)
   (let ((clang-format shynur/custom:clang-format-path)
         (options `("--Werror"
                    "--fallback-style=none"
                    "--ferror-limit=0"
                    ,(format "--style=file:%s"
                             (expand-file-name "~/.emacs.d/etc/clang-format.yaml"))))
         (programming-language (pcase major-mode
                                 ('c-mode    "c"   )
                                 ('c++-mode  "cpp" )
                                 ('java-mode "java")
                                 ('js-mode   "js"  )
                                 (_ (unless mark-active
                                      (user-error (shynur/message-format "无法使用“clang-format”处理当前语言")))))))
     (if (stringp programming-language)
         (shynur/save-cursor-relative-position-in-window
           ;; TODO:
           ;;     不确定这边的‘without-restriction’有没有必要,
           ;;   以及要不要和‘shynur/save-cursor-relative-position-in-window’互换位置.
           (without-restriction
             (apply #'call-process-region
                    1 (point-max) clang-format t t nil
                    (format "--assume-filename=a.%s" programming-language)
                    (format "--cursor=%d" (1- (point)))
                    options)
             (goto-char 1)
             (goto-char (1+ (string-to-number (prog1 (let ((case-fold-search nil))
                                                       (save-match-data
                                                         (buffer-substring-no-properties
                                                          (re-search-forward "\\`[[:blank:]]*{[[:blank:]]*\"Cursor\":[[:blank:]]*")
                                                          (re-search-forward "[[:digit:]]+"))))
                                                (delete-line)))))))
       (let ((formatted-code (let ((buffer-substring `(,(current-buffer) ,(region-beginning) ,(region-end))))
                               (with-temp-buffer
                                 (apply #'insert-buffer-substring-no-properties
                                        buffer-substring)
                                 (apply #'call-process-region
                                        1 (point-max) clang-format t t nil
                                        (format "--assume-filename=a.%s"
                                                (completing-read #("assume language: "
                                                                   0 16 (face italic))
                                                                 '("c" "cpp" "java" "js" "json" "cs")))
                                        options)
                                 (buffer-substring-no-properties 1 (point-max)))))
             (point-at-region-end (prog1 (= (point) (region-end))
                                    (delete-active-region))))
         (if point-at-region-end
             (insert formatted-code)
           (save-excursion
             (insert formatted-code))))))))

(provide 'shynur-lang)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
