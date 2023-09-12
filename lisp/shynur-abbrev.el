;;; -*- lexical-binding: t; -*-

(setq abbrev-file-name (file-name-concat user-emacs-directory
                                         "etc/abbrev_defs.el")
      save-abbrevs "ask")

(setq only-global-abbrevs nil)

(provide 'shynur-abbrev)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
