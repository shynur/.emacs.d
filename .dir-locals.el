;;; -*- lexical-binding: t; -*-
;; 读取本文件时, 似乎本来就默认开启了‘lexical-binding’.

;;; Comments:
;;
;; 能放到该文件的配置都放到该文件, file local variable 要尽可能少.
;; 因为 Emacs 启动时会读取本文件, 将结果加到 ‘safe-local-variable-values’ 中, 当启用这些配置时, _无需确认_.

((auto-mode-alist . (;; 诸如 auto-save 之类的文件.
                     ("[~#]\\'" . (ignore t))  ; e.g., ‘a.txt~’, ‘#a.txt#’.

                     ("/[^/[blank]]+\\.ps1\\'" . powershell-mode)

                     ("/[^/[blank]]+\\.md\\'"      . markdown-mode)
                     ("/[^/[blank]]+\\.textile\\'" . textile-mode)

                     ("/[^/[blank]]+\\.ya?ml\\'" . yaml-mode)
                     ("/etc/yas-snippets/[^/[blank]]+-mode/\\(?:\\.yas-skip\\|\\.yas-parents\\|[^/[blank]]+\\.yasnippet\\)\\'" . snippet-mode)

                     ("/\\.gitignore\\'" . gitignore-mode)
                     ("/\\.gitmodules\\'" . gitconfig-mode)
                     ))

 (nil . ((outline-minor-mode-cycle . t)
         (outline-minor-mode-prefix . [nil])

         (lexical-binding . t)
         (no-byte-compile . t)

         (mode . auto-save)

         (project-vc-merge-submodules . nil)

         (imenu-auto-rescan . t)
         (imenu-sort-function . imenu--sort-by-name)
         (eval . (ignore-error 'imenu-unavailable
                   (imenu-add-menubar-index)))

         (mode . which-function)
         (which-func-modes . t)

         (eval . (when-let ((buffer-file-name (buffer-file-name)))
                   (when (string-match-p "\\`\\(?:LICENSE\\|COPYING\\)\\(?:\\.[^.[blank]]+\\)?\\'"  ; ‘LICENSE’没有注释语法, 只能写在这里了.
                                         (file-name-nondirectory buffer-file-name))
                     (setq-local buffer-read-only t))))

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "[.:~/]*\\(?:shynur\\|谢骐\\)\\(?:[_.:/-]+[[:alnum:]_.:/*-]*\\)?"
                                     'underline)))

         (tab-width . 4)
         (indent-tabs-mode . nil)  ; 为什么不是“(mode . indent-tabs)”?  不知道, manual 中的示例如此.
         (delete-trailing-lines . t)
         (require-final-newline . t)
         (sentence-end-double-space . t)

         (before-save-hook . ((lambda ()
                                (save-excursion
                                  (funcall (if (bound-and-true-p shynur/.emacs.d:add-coding-at-propline?)
                                               #'add-file-local-variable-prop-line
                                             #'add-file-local-variable)
                                           'coding 'utf-8-unix)))
                              delete-trailing-whitespace
                              t))
         ))

 (prog-mode . ((mode . electric-quote-local)))

 (emacs-lisp-mode . ((eval . (imenu-add-menubar-index))

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)

                     (after-save-hook . ((lambda ()
                                           "自动编译 Emacs Lisp 文件."
                                           (let ((byte-compile-log-warning-function #'ignore))
                                             ;; 建议手动‘check-declare-file’一下.
                                             (byte-compile-file (buffer-file-name))))
                                         t))
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

 ("etc/yas-snippets/" . ((snippet-mode . ((require-final-newline . nil)
                                          (mode . whitespace-newline)

                                          (shynur/.emacs.d:add-coding-at-propline? t)))))

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
