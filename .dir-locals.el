;;; -*- lexical-binding: t; -*-
;; 读取本文件时, 似乎本来就默认开启了‘lexical-binding’.

;;; Comments:
;;
;; 能放到该文件的配置都放到该文件, file local variable 要尽可能少.
;; 因为 Emacs 启动时会读取本文件, 将结果加到 ‘safe-local-variable-values’ 中, 当启用这些配置时, _无需确认_.
;;
;; 可选的优化: 在‘lambda’前加‘byte-compile’, 但是这样看上去比较乱.

((auto-mode-alist . (;; 这些是 auto-save 之类的文件.
                     ("~\\'" . (ignore t))
                     ("#[[:alnum:]]*\\'" . (ignore t))

                     ("/\\.dir-locals\\(?:-2\\)?\\.el\\'" . lisp-data-mode)

                     ;; shynur/TODO: 我tm自己都看不懂了, 有空补一下注释.
                     ("/[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\(?:\\(?:-[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.md\\'"      . markdown-mode)
                     ("/[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\(?:\\(?:-[[:alnum:]]\\(?:[[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.textile\\'" . textile-mode)

                     ("/[^/-][^/]*\\.ya?ml\\'" . yaml-mode)
                     ("/etc/yas-snippets/[^/]+-mode/\\(?:\\.yas-skip\\|\\.yas-parents\\|[^/]+\\.yasnippet\\)\\'" . snippet-mode)

                     ("/\\.gitignore\\'" . gitignore-mode)
                     ("/\\.gitmodules\\'" . gitconfig-mode)
                     ))

 (nil . ((outline-minor-mode-cycle . t)
         (outline-minor-mode-prefix . [nil])

         (sentence-end-double-space . t)

         (lexical-binding . t)
         (no-byte-compile . t)

         (mode . auto-save)

         (project-vc-merge-submodules . nil)

         (imenu-auto-rescan . t)
         (imenu-sort-function . imenu--sort-by-name)

         (mode . which-function)
         (which-func-modes . (emacs-lisp-mode
                              markdown-mode
                              org-mode
                              makefile-gmake-mode))

         (eval . (when-let ((buffer-file-name (buffer-file-name)))
                   (when (string-match-p "\\`LICENSE\\(?:\\.[^.]+\\)?\\'"  ; ‘LICENSE’没有注释语法, 只能写在这里了.
                                         (file-name-nondirectory buffer-file-name))
                     (setq-local buffer-read-only t))))

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "~?\\(?:shynur\\|谢骐\\)[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                     'underline)))

         (tab-width . 4)
         (indent-tabs-mode . nil)  ; 为什么不是“(mode . indent-tabs)”?  不知道, manual 中的示例如此.

         (delete-trailing-lines . t)
         (require-final-newline . t)

         (eval . (progn
                   (unless (get 'shynur/before-save-hook:~/.emacs.d/* :shynur/ready?)
                     (fset 'shynur/before-save-hook:~/.emacs.d/*
                           (lambda ()
                             (when (file-in-directory-p default-directory user-emacs-directory)
                               (run-hook-with-args 'shynur/before-save-hook:~/.emacs.d/*))))
                     (add-hook 'before-save-hook #'shynur/before-save-hook:~/.emacs.d/*)
                     (put 'shynur/before-save-hook:~/.emacs.d/*
                          :shynur/ready? t))

                   (unless (get 'shynur/after-save-hook:~/.emacs.d/* :shynur/ready?)
                     (fset 'shynur/after-save-hook:~/.emacs.d/*
                           (lambda ()
                             (when (file-in-directory-p default-directory user-emacs-directory)
                               (run-hook-with-args 'shynur/after-save-hook:~/.emacs.d/*))))
                     (add-hook 'after-save-hook #'shynur/after-save-hook:~/.emacs.d/*)
                     (put 'shynur/after-save-hook:~/.emacs.d/*
                          :shynur/ready? t))
                   ))

         (eval . (unless (get 'shynur/before-save-hook:~/.emacs.d/* :shynur/.emacs.d/)
                   (seq-doseq (function (vector
                                         #'delete-trailing-whitespace
                                         (lambda ()
                                           (save-excursion
                                             (add-file-local-variable 'coding 'utf-8-unix)))
                                         ))
                     (add-hook 'shynur/before-save-hook:~/.emacs.d/* function))
                   (put 'shynur/before-save-hook:~/.emacs.d/*
                        :shynur/.emacs.d/ t)))
         ))

 (emacs-lisp-mode . ((eval . (imenu-add-menubar-index))

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)

                     (eval . (unless (get 'shynur/after-save-hook:~/.emacs.d/* :shynur/.emacs.d/:emacs-lisp)
                               (seq-doseq (function (vector
                                                     (lambda ()
                                                       (when (eq 'emacs-lisp-mode major-mode)
                                                         (let ((byte-compile-log-warning-function #'ignore))
                                                           ;; 建议手动‘check-declare-file’一下.
                                                           (byte-compile-file (buffer-file-name)))))
                                                     ))
                                 (add-hook 'shynur/after-save-hook:~/.emacs.d/* function))
                               (put 'shynur/after-save-hook:~/.emacs.d/*
                                    :shynur/.emacs.d/:emacs-lisp t)))
                     ))

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

 ("etc/" . ((nil . (;; 该目录不在‘load-path’里, 所以其下的那些 ELisp 文件 是_绝对路径_指定的.
                    ;; 那些 ELisp library 的 feature 也和文件名不符, 只能显式地用‘load-file’.
                    (no-byte-compile . t)))))
 ("modules/src/" . ((nil . ((eval . (when-let ((buffer-file-name (buffer-file-name)))
                                      (when (string-match-p "emacs-module"  ; 这玩意有 GPL 污染, 切割!
                                                            (file-name-nondirectory buffer-file-name))
                                        (setq-local buffer-read-only t))))

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
