;;; -*- lexical-binding: t; -*-

;; 真的需要换绑吗?  虽说在 MS-Windows 上有 “Alt+Tab” 平替.
;; (keymap-global-set "C-z" #'shell)

;;; ‘eshell’:

(shynur/custom:appdata/ eshell-directory-name /)
(shynur/custom:appdata/ eshell-history-file-name txt)
(shynur/custom:appdata/ eshell-last-dir-ring-file-name txt)

(add-hook 'eshell-mode-hook
          (lambda ()
            "‘eshell’ 中 ‘company-mode’ 卡得一批."
            (company-mode -1)))

;;; ‘shell’:


;; (add-hook 'shell-mode-hook
;;           (lambda ()
;;             "设置编解码"
;;             (set-buffer-process-coding-system ...)))

(when (and (eq system-type 'windows-nt)
           (executable-find "pwsh.exe"))
  (add-hook 'shell-mode-hook
            (lambda ()
              (when (not (file-remote-p default-directory))
                (execute-kbd-macro "set EMACS_INVOKED_PWSH=true   pwsh.exe ")))))

(add-hook 'shell-mode-hook
          (lambda ()
            "‘eshell’中‘company-mode’卡得一批."
            (company-mode -1)))

(provide 'shynur-sh)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
