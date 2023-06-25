;;; ~shynur/.emacs.d/.dir-locals.el

((nil . (;;只对当前一级目录下的文件生效
         (subdirs . nil)

         (eval . (let ((case-fold-search t))
                   (highlight-phrase "[~]shynur[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                     'underline)))

         (eval . (indent-tabs-mode -1))
         (delete-trailing-lines . t)
         (require-final-newline . t)
         (eval . (add-hook 'before-save-hook #'delete-trailing-whitespace))))

 (emacs-lisp-mode . (;;只对当前一级目录下的文件生效
                     (subdirs . nil)

                     (lexical-binding . t)

                     (no-byte-compile . t)
                     (no-native-compile . t)

                     (prettify-symbols-alist . (("lambda" . ?λ)))
                     (mode . prettify-symbols)))

 ("./shynur/" . (;;;将上述两份配置应用于该目录及其子目录

                 (nil . ((eval . (let ((case-fold-search t))
                                   (highlight-phrase "[~]shynur[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                                     'underline)))

                         (eval . (indent-tabs-mode -1))
                         (delete-trailing-lines . t)
                         (require-final-newline . t)
                         (eval . (add-hook 'before-save-hook #'delete-trailing-whitespace))))

                 (emacs-lisp-mode . ((lexical-binding . t)

                                     (no-byte-compile . t)
                                     (no-native-compile . t)

                                     (prettify-symbols-alist . (("lambda" . ?λ)))
                                     (mode . prettify-symbols))))))

;; Local Variables:
;; coding: utf-8-unix
;; End:
;;; ~shynur/.emacs.d/.dir-locals.el ends here
