;;; ~shynur/.emacs.d/.dir-locals.el

((auto-mode-alist . (;;有些设置是多余的,但出于教学/参考的目的,保留下来
                     ("~\\'" . (ignore t))
                     ("#[[:alnum:]]*\\'" . (ignore t))

                     ;;(bug#64415)
                     ("/[^/-][^/]*\\.el\\'" . emacs-lisp-mode)
                     ("/\\.dir-locals\\(-2\\)?\\.el\\'" . lisp-data-mode)

                     ("/[[:alnum:]]\\([[:alnum:]_]*[[:alnum:]]\\)?\\(\\(-[[:alnum:]]\\([[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.md\\'" . markdown-mode)
                     ("/[[:alnum:]]\\([[:alnum:]_]*[[:alnum:]]\\)?\\(\\(-[[:alnum:]]\\([[:alnum:]_]*[[:alnum:]]\\)?\\)+\\)?\\.org\\'" . org-mode)

                     ("/[^/-][^/]*\\.ya?ml\\'" . yaml-mode)
                     ("/\\.gitignore\\'" . gitignore-mode)
                     ("/\\(\\(\\(GNU\\)?m\\)\\|M\\)akefile\\'" . makefile-gmake-mode)))

 (nil . ((outline-minor-mode-cycle . [tab ?\S-\t])
         (outline-minor-mode-prefix . [nil])

         (sentence-end-double-space . t)

         (mode . auto-save)

         (imenu-auto-rescan . t)
         (imenu-sort-function . imenu--sort-by-name)

         (mode . which-function)
         (which-func-modes . (emacs-lisp-mode
                              markdown-mode
                              org-mode
                              makefile-gmake-mode))

         (eval . (global-set-key (kbd "C-c c") (lambda ()
                                                 "参考“GNUmakefile”中的“clean”项,进行适当的清理"
                                                 (interactive)
                                                 (let ((default-directory "~/.emacs.d/"))
                                                   (delete-file "README.html")
                                                   (delete-file "README.html~")
                                                   (delete-file "docs/Emacs-regexp.html") (delete-file "docs/Emacs-regexp.html~")
                                                   (delete-file "docs/Emacs-use_daemon.html") (delete-file "docs/Emacs-use_daemon.html~")))))

         (prettify-symbols-alist . (("lambda" . ?λ)))
         (mode . prettify-symbols)

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "~?\\(shynur\\|谢骐\\)[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                     'underline)))

         (delete-trailing-lines . t)
         (require-final-newline . t)
         (indent-tabs-mode . nil)
         (eval . (add-hook 'before-save-hook #'delete-trailing-whitespace))))

 (emacs-lisp-mode . ((eval . (imenu-add-menubar-index))

                     ;; outline head line 格式如下:
                     ;; .1      Lv-1
                     ;; .2.3    Lv-2
                     ;; .4.5.6  Lv-3
                     ;; .
                     (outline-regexp . "^[[:blank:]]*;;+[[:blank:]]+\\(\\(\\.[[:digit:]]+\\)+\\|\\.[[:blank:]]*$\\)\\([[:blank:]]*$\\|[[:blank:]]+\\)")
                     (outline-level . (lambda ()
                                        (let ((dot-amount 0))
                                          (seq-doseq (character (match-string-no-properties 1))
                                            (when (char-equal character ?.)
                                              (cl-incf dot-amount)))
                                          dot-amount)))
                     (mode . outline-minor)))

 (markdown-mode . ((eval . (imenu-add-menubar-index))))

 (org-mode . ((eval . (imenu-add-menubar-index))

              (org-descriptive-links . nil)))

 (makefile-gmake-mode . ((eval . (imenu-add-menubar-index))
                         (mode . indent-tabs)))

 (nil . ((subdirs . nil)

         (lexical-binding . t)
         (no-byte-compile . t)
         (no-native-compile . t)))

 ("docs/" . ((nil . ((lexical-binding . t)
                     (no-byte-compile . t)
                     (no-native-compile . t)))))

 ("shynur/" . ((nil . ((lexical-binding . t)
                       (no-byte-compile . t)
                       (no-native-compile . t))))))

;; Local Variables:
;; coding: utf-8-unix
;; End:
