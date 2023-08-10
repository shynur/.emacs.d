;;; -*- lexical-binding: t; -*-

;;; Snippet: ‘yasnippet’

(setq yas-snippet-dirs `(,(file-name-concat user-emacs-directory
                                            "etc/yas-snippets/")))
(require 'yasnippet)
(yas-reload-all)

(keymap-set yas-minor-mode-map "TAB"
            nil)
(keymap-set yas-minor-mode-map "<tab>"
            yas-maybe-expand)

;;; Delimiter

(setq blink-matching-paren-highlight-offscreen t)

(provide 'shynur-edit)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
