;;; ~shynur/.emacs.d/shynur/org.el  -*- lexical-binding: t; -*-

(setq-default org-link-descriptive nil) ;展开link.

(setq-default org-support-shift-select t)

(add-hook 'org-mode-hook (lambda ()
                           "有续行"
                           (toggle-truncate-lines 0)))

(provide 'shynur/org)

;; Local Variables:
;; coding: utf-8-unix
;; End:
