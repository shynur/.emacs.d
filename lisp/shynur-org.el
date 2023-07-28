;;; -*- lexical-binding: t; -*-

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key [f9] "\N{ZERO WIDTH SPACE}")))

(add-hook 'org-mode-hook
          #'org-num-mode)

;; [[package:melpa][org-superstar]]
(add-hook 'org-mode-hook
          #'org-superstar-mode)

(setq org-link-descriptive nil)  ; 展开link.

(setq org-support-shift-select t)



(add-hook 'org-mode-hook
          (lambda ()
            "有续行"
            (toggle-truncate-lines 0)))

(provide 'shynur-org)

;; Local Variables:
;; coding: utf-8-unix
;; End:
