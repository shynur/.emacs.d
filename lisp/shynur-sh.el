;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; For ‘sh-mode’, ‘eshell’, and ‘shell’.

;;; Feature: ‘eshell’

(shynur/custom-appdata/ eshell-directory-name /)
(shynur/custom-appdata/ eshell-history-file-name txt)
(shynur/custom-appdata/ eshell-last-dir-ring-file-name txt)

(add-hook 'eshell-mode-hook
          (lambda ()
            "‘eshell’中‘company-mode’卡得一批."
            (company-mode -1)))

;;; Feature: ‘shell’

(add-hook 'shell-mode-hook
          (lambda ()
            "设置编解码."
            (set-buffer-process-coding-system shynur/custom-shell-coding
                                              shynur/custom-shell-coding)))

(add-hook 'shell-mode-hook
          (lambda ()
            "设置 PowerShell."
            (when (or (string= shynur/custom-os "MS-Windows 10")
                      (string= shynur/custom-os "MS-Windows 11"))
              (make-thread (lambda ()
                             (let ((attempts 100000))
                               (while (and (natnump attempts)
                                           (length> "Microsoft Windows" (buffer-size)))
                                 (thread-yield)
                                 (cl-decf attempts)))
                             (when (save-excursion
                                     (re-search-backward "Microsoft Windows"))
                               (execute-kbd-macro [?p ?o ?w ?e ?r ?s ?h ?e ?l ?l ?\C-m])))))))

(add-hook 'shell-mode-hook
          (lambda ()
            "‘eshell’中‘company-mode’卡得一批."
            (company-mode -1)))

(provide 'shynur-sh)

;; Local Variables:
;; coding: utf-8-unix
;; End:
