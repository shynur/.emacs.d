;;; -*- lexical-binding: t; -*-

(keymap-global-set "C-z" #'shell)

;;; ‘eshell’:

(shynur/custom:appdata/ eshell-directory-name /)
(shynur/custom:appdata/ eshell-history-file-name txt)
(shynur/custom:appdata/ eshell-last-dir-ring-file-name txt)

(add-hook 'eshell-mode-hook
          (lambda ()
            "‘eshell’中‘company-mode’卡得一批."
            (company-mode -1)))

;;; ‘shell’:

(setq shell-file-name (pcase system-type
                        ('windows-nt
                         (if-let ((--pwsh-path (executable-find "pwsh")))
                             --pwsh-path
                           shell-file-name))
                        (_
                         shell-file-name)))

(add-hook 'shell-mode-hook
          (lambda ()
            "设置编解码."
            (set-buffer-process-coding-system shynur/custom:shell-coding
                                              shynur/custom:shell-coding)))

(add-hook 'shell-mode-hook
          (lambda ()
            "‘eshell’中‘company-mode’卡得一批."
            (company-mode -1)))

(provide 'shynur-sh)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
