;;; -*- lexical-binding: t; -*-

;;; Snippet

(setq yas-snippet-dirs `(,(file-name-concat user-emacs-directory
                                            "etc/yas-snippets/")))

(require 'yasnippet)
(yas-reload-all)

;;; Delimiter

(setq blink-matching-paren-highlight-offscreen t)

(provide 'shynur-edit)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
