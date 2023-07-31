;; 能放到该文件的配置都放到该文件, file local variable 要尽可能少.
;; 因为 Emacs 启动时会读取本文件, 将结果加到 ‘safe-local-variable-values’ 中, 当启用这些配置时, _无需确认_.

((auto-mode-alist . (;; 有些设置是多余的, 但出于 教学/参考 的目的, 保留下来.

                     ;; 这些是 auto-save 之类的文件.
                     ("~\\'" . (ignore t))
                     ("#[[:alnum:]]*\\'" . (ignore t))

                     ;; (Bug#64415)
                     ("/[^/-][^/]*\\.el\\'" . emacs-lisp-mode)
                     ("/\\.dir-locals\\(?:-2\\)?\\.el\\'" . lisp-data-mode)

                     ;; shynur/TODO: 我tm自己都看不懂了, 有空补一下注释.
                     ("/[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\(?:\\(?:-[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.md\\'"      . markdown-mode)
                     ("/[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\(?:\\(?:-[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.textile\\'" . textile-mode)

                     ("/[^/-][^/]*\\.ya?ml\\'" . yaml-mode)
                     ("/etc/yas-snippets/[^/-][^/]*\\.yasnippet\\'" . snippet-mode)
                     ("/\\.gitignore\\'" . gitignore-mode)
                     ("/\\.gitmodules\\'" . gitconfig-mode)
                     ))

 (nil . ((outline-minor-mode-cycle . t)
         (outline-minor-mode-prefix . [nil])

         (sentence-end-double-space . t)

         (lexical-binding . t)

         (mode . auto-save)

         (imenu-auto-rescan . t)
         (imenu-sort-function . imenu--sort-by-name)

         (mode . which-function)
         (which-func-modes . (emacs-lisp-mode
                              markdown-mode
                              org-mode
                              makefile-gmake-mode))

         (shynur--read-only-when-filename-match . (lambda (regexp)
                                                    (when-let ((buffer-file-name (buffer-file-name)))
                                                      (when (string-match-p regexp (file-name-nondirectory buffer-file-name))
                                                        (setq-local buffer-read-only t)))))
         (eval . (funcall shynur--read-only-when-filename-match "LICENSE"))  ; ‘LICENSE’没有注释语法, 只能写在这里了.


         (eval . (let ((case-fold-search t))
                   (highlight-phrase "~?\\(?:shynur\\|谢骐\\)[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                     'underline)))

         (tab-width . 4)
         (indent-tabs-mode . nil)  ; 为什么不是“(mode . indent-tabs)”?  不知道, manual 中的示例如此.

         (delete-trailing-lines . t)
         (require-final-newline . t)
         (eval . (prog1 (add-hook 'before-save-hook 'shynur/run-functions-before-save:~/.emacs.d/*)
                   (fset 'shynur/run-functions-before-save:~/.emacs.d/*
                         (lambda ()
                           (when (file-in-directory-p default-directory user-emacs-directory)
                             (funcall #'delete-trailing-whitespace)
                             (save-excursion
                               (add-file-local-variable 'coding 'utf-8-unix)))))))))

 (emacs-lisp-mode . ((eval . (imenu-add-menubar-index))

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)))

 (markdown-mode . ((eval . (imenu-add-menubar-index))))

 (org-mode . ((eval . (imenu-add-menubar-index))

              (eval . (local-set-key [f9] "\N{ZERO WIDTH SPACE}"))

              (org-link-descriptive . nil)))

 (gitignore-mode . ((outline-regexp . "^#+outline:\\(?1:[[:blank:]]+\\(?:[._[:alnum:]-]+/\\)+\\)?")
                    (outline-heading-end-regexp . "/\n")
                    (outline-level . (lambda ()
                                       (let ((slash-amount 0))
                                         (seq-doseq (character (match-string-no-properties 1))
                                           (when (char-equal character ?/)
                                             (cl-incf slash-amount)))
                                         slash-amount)))
                    (mode . outline-minor)

                    (eval . (define-key gitignore-mode-map (kbd "TAB")
                              (lambda ()
                                (interactive)
                                (back-to-indentation)
                                (delete-horizontal-space))))))

 (makefile-gmake-mode . ((eval . (imenu-add-menubar-index))

                         (mode . indent-tabs)))

 ("etc/" . ((nil . (;; 其下的 Emacs Lisp 文件 几乎 只负责 定义 变量, 完全没必要编译.
                    ;; 而且该目录也不在‘load-path’里, 所以那些 Emacs Lisp 是_绝对路径_指定的.
                    (no-byte-compile . t)
                    (no-native-compile . t)))
            ("yas-snippets/" . ((auto-mode-alist . (("/etc/yas-snippets/[^/-][^/]*\\.yasnippet\\'" . snippet-mode)))))))
 ("lisp/" . ((nil . (;; 编写用于 解释执行 的代码更加轻松, 但是会在未来的某一天重构成_可编译的_.
                     ;; ‘site-lisp/’中则尽量编写可编译的代码.
                     (no-byte-compile . t)
                     (no-native-compile . t)))))
 ("modules/src/" . ((nil . ((eval . (funcall shynur--read-only-when-filename-match "emacs-module"))  ; 这玩意有 GPL 污染, 切割!

                            (tags-file-name . "ETAGS.txt")
                            (eval . (when (buffer-file-name)  ; 正在访问文件, 而不是‘dired’之类的 buffer.
                                      (let ((default-directory (file-name-concat user-emacs-directory
                                                                                 "modules/src/")))
                                        (when (or (not (file-exists-p tags-file-name))
                                                  (> (time-to-number-of-days (time-since (file-attribute-modification-time (file-attributes tags-file-name))))
                                                     1))
                                          (eshell-command (format "ls *.[ch] | etags --output=%s - "
                                                                  tags-file-name)))))))))))

;; Local Variables:
;; coding: utf-8-unix
;; End:
