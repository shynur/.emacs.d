;;; -*- lexical-binding: t; -*-

(setq yas-snippet-dirs `(,(file-name-concat user-emacs-directory
                                            "etc/yas-snippets/")))

(require 'yasnippet)
(yas-reload-all)

(provide 'shynur-yas)

;; Local Variables:
;; coding: utf-8-unix
;; End:
