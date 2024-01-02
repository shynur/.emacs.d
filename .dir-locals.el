;;; -*- lexical-binding: t; -*-
;; 读取本文件时, 似乎本来就默认开启了‘lexical-binding’.

;;; Comments:
;;
;; 能放到该文件的配置都放到该文件, file local variable 要尽可能少.
;; 因为 Emacs 启动时会读取本文件, 将结果加到 ‘safe-local-variable-values’ 中, 当启用这些配置时, _无需确认_.

((auto-mode-alist . (;; 诸如 auto-save 之类的文件.
                     ("[~#]\\'" . (ignore t))  ; e.g., ‘a.txt~’, ‘#a.txt#’.

                     ("/[^/[:blank:]]+\\.ps1\\'" . powershell-mode)

                     ("/[^/[:blank:]]+\\.md\\'"      . markdown-mode)
                     ("/[^/[:blank:]]+\\.textile\\'" . textile-mode)

                     ("/\\.nosearch\\'" . text-mode)
                     ("/[^/[:blank:]]+\\.ya?ml\\'" . yaml-mode)
                     ("/var/yas-snippets/[^/[:blank:]]+-mode/\\(?:\\.yas-skip\\|\\.yas-parents\\|[^/[:blank:]]+\\.yasnippet\\)\\'" . snippet-mode)

                     ("/\\.gitignore\\'" . gitignore-mode)
                     ("/\\.gitmodules\\'" . gitconfig-mode)

                     ("/media/images/shynur-[^/]+\\.xpm\\'" . c-mode)
                     ))

 (nil . ((make-backup-files . nil)
         (mode . auto-save)
         (auto-revert-verbose . nil)

         (outline-minor-mode-cycle . t)
         (outline-minor-mode-prefix . [nil])

         (lexical-binding . t)
         (no-byte-compile . t)

         (project-vc-merge-submodules . nil)

         (imenu-auto-rescan . t)
         (imenu-sort-function . imenu--sort-by-name)
         (eval . (ignore-error 'imenu-unavailable
                   (imenu-add-menubar-index)))

         (mode . which-function)
         (which-func-modes . t)

         (eval . (when-let ((buffer-file-name (buffer-file-name)))
                   (when (string-match-p "\\`\\(?:LICENSE\\|COPYING\\)\\(?:\\.[^.[:blank:]]+\\)?\\'"  ; ‘LICENSE’ 没有注释语法, 只能写在这里了.
                                         (file-name-nondirectory buffer-file-name))
                     (setq-local buffer-read-only t))))

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "[.:~/]*\\(?:shynur\\|谢骐\\)\\(?:[_.:/-]+[[:alnum:]_.:/*-]*\\)?"
                                     'underline)))

         (tab-width . 4)
         (indent-tabs-mode . nil)  ; 为什么不是 “(mode . indent-tabs)”?  不知道, manual 中的示例如此.
         (delete-trailing-lines . t)
         (require-final-newline . t)
         (sentence-end-double-space . t)

         (before-save-hook . ((lambda ()
                                "自动加 UTF-8-UNIX 编码的声明."
                                (save-excursion
                                  (funcall (if (bound-and-true-p shynur/.emacs.d:add-coding-at-propline?)
                                               #'add-file-local-variable-prop-line
                                             #'add-file-local-variable)
                                           'coding 'utf-8-unix)))
                              delete-trailing-whitespace
                              whitespace-cleanup
                              (lambda ()  ; 在 ‘whitespace-cleanup’ 之后查看第一行的内容.
                                "给 XPM 文件 的 第一行 加 声明."
                                (when-let ((buffer-file-name (buffer-file-name)))
                                  (when (string-match-p "/media/images/shynur-[^/]+\\.xpm\\'" buffer-file-name)
                                    (without-restriction
                                      (save-excursion
                                        (goto-char 1)
                                        (when (not (string-match-p "\\`[[:blank:]]*/\\*[[:blank:]]*XPM[[:blank:]]*\\*/[[:blank:]]*\\'" (buffer-substring-no-properties 1 (line-end-position))))
                                          (insert "/* XPM */\n" ?\n)))))))
                              t))
         ))

 (prog-mode . ((mode . electric-quote-local)))

 (emacs-lisp-mode . ((eval . (imenu-add-menubar-index))

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)
                     ))

 (org-mode . ((eval . (keymap-local-set "<f9>"
                                        "\N{ZERO WIDTH SPACE}"))

              ;; 链接🔗 保持原样渲染.
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

 (makefile-gmake-mode . ((mode . indent-tabs)))

 (yaml-mode . ((tab-width . 2)))

 ("media/images/" . ((nil . ((mode . image-minor)))))

 ("var/" . ((nil . ())
            ("yas-snippets/" . ((snippet-mode . ((require-final-newline . nil)
                                                 (mode . whitespace-newline)

                                                 (shynur/.emacs.d:add-coding-at-propline? . t)))))))

 ("local-elpa/" . ((nil . ((before-save-hook . (t))))))

 ("modules/src/" . ((nil . ((eval . (when-let ((buffer-file-name (buffer-file-name)))
                                      (when (string-match-p "emacs-module"  ; 这玩意有 GPL 污染, 切割!
                                                            (file-name-nondirectory buffer-file-name))
                                        (setq-local buffer-read-only t))))

                            (tags-file-name . "ETAGS.txt")
                            (eval . (when-let ((--buffer-file-name (buffer-file-name)))  ; 正在访问文件, 而不是 ‘Dired’ 之类的 buffer.
                                      (let ((default-directory (file-name-concat (with-temp-buffer
                                                                                   (insert --buffer-file-name)
                                                                                   (search-backward "/modules/src/")
                                                                                   (buffer-substring-no-properties 1 (point)))
                                                                                 "modules/src/")))
                                        (when (or (not (file-exists-p tags-file-name))
                                                  (> (time-to-number-of-days (time-since (file-attribute-modification-time (file-attributes tags-file-name))))
                                                     1))
                                          (eshell-command (format "ls *.[ch] | etags --output=%s - "
                                                                  tags-file-name)))))))))))

;; Local Variables:
;; coding: utf-8-unix
;; End:
