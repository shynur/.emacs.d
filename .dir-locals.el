;;; ~shynur/.emacs.d/.dir-locals.el

((auto-mode-alist . (("/\\.emacs\\.d/\\(GNUmakefile\\|makefile\\|Makefile\\)\\'" . makefile-gmake-mode)
                     ("/\\.emacs\\.d/\\.dir-locals\\(-2\\)?\\.el\\'" . lisp-data-mode)
                     ("/\\.emacs\\.d/\\(shynur/\\)?[^-].*\\.el\\'" . emacs-lisp-mode)
                     ("/\\.emacs\\.d/\\(shynur/\\)?[^-].*\\.org\\'" . org-mode)
                     ("/\\.emacs\\.d/\\(shynur/\\)?\\.gitignore\\'" . gitignore-mode)
                     ("/\\.emacs\\.d/\\(shynur/\\)?[^-].*\\.ya?ml\\'" . yaml-mode)
                     ("/\\.emacs\\.d/\\(shynur/\\)?[[:alnum:]][[:alnum:]_]*[[:alnum:]]\\(-[[:alnum:]][[:alnum:]_]*[[:alnum:]]\\)+\\.md\\'" . markdown-mode)))

 (nil . ((subdirs . nil)

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "~?\\(shynur\\|谢骐\\)[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                     'underline)))

         (outline-minor-mode-cycle . [tab ?\S-\t])
         (outline-minor-mode-prefix . [nil])

         (sentence-end-double-space . t)

         (indent-tabs-mode . nil)
         (delete-trailing-lines . t)
         (require-final-newline . t)
         (eval . (add-hook 'before-save-hook #'delete-trailing-whitespace))))

 (emacs-lisp-mode . ((subdirs . nil)

                     ;;只对‘elisp-mode’有效,‘lisp-data-mode’复制时请排除该片段
                     (lexical-binding . t)
                     (no-byte-compile . t)
                     (no-native-compile . t)

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
                     (mode . outline-minor)

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)))

 (lisp-data-mode . ((subdirs . nil)

                    (outline-regexp . "^[[:blank:]]*;;+[[:blank:]]+\\(\\.\\|\\(\\.[[:digit:]]+\\)+\\)\\($\\|[[:blank:]]+\\)")
                    (outline-heading-end-regexp . "^[[:blank:]]*;;+[[:blank:]]+\\(\\.[[:blank:]]*$\\|\\(\\.[[:digit:]]\\)+\\($\\|[[:blank:]]+\\)\\)")
                    (outline-level . (lambda ()
                                       (let ((dot-amount 0))
                                         (seq-doseq (character (match-string-no-properties 1))
                                           (when (char-equal character ?.)
                                             (cl-incf dot-amount)))
                                         dot-amount)))
                    (mode . outline-minor)

                    (prettify-symbols-alist . (("lambda" . ?λ)))
                    (mode . prettify-symbols)))

 (makefile-gmake-mode . ((mode . indent-tabs)))

 ("./shynur/" . ((nil . ((eval . (let ((case-fold-search t))
                                   (highlight-phrase "~?\\(shynur\\|谢骐\\)[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                                     'underline)))

                         (auto-mode-alist . ())

                         (outline-minor-mode-cycle . [tab ?\S-\t])
                         (outline-minor-mode-prefix . [nil])

                         (sentence-end-double-space . t)

                         (indent-tabs-mode . nil)
                         (delete-trailing-lines . t)
                         (require-final-newline . t)
                         (eval . (add-hook 'before-save-hook #'delete-trailing-whitespace))))

                 (emacs-lisp-mode . ((lexical-binding . t)
                                     (no-byte-compile . t)
                                     (no-native-compile . t)

                                     (outline-regexp . "^[[:blank:]]*;;+[[:blank:]]+\\(\\(\\.[[:digit:]]+\\)+\\|\\.[[:blank:]]*$\\)\\([[:blank:]]*$\\|[[:blank:]]+\\)")
                                     (outline-level . (lambda ()
                                                        (let ((dot-amount 0))
                                                          (seq-doseq (character (match-string-no-properties 1))
                                                            (when (char-equal character ?.)
                                                              (cl-incf dot-amount)))
                                                          dot-amount)))
                                     (mode . outline)

                                     (prettify-symbols-alist . (("lambda" . ?λ)))
                                     (mode . prettify-symbols))))))

;; Local Variables:
;; coding: utf-8-unix
;; End:
;;; ~shynur/.emacs.d/.dir-locals.el ends here
