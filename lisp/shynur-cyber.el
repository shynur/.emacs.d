;;; -*- lexical-binding: t; -*-

;;; Environment:

(shynur/custom:appdata/ nsm-settings-file data)  ; 记录已知的安全 connection.

;;; Information:

(when (eq system-type 'windows-nt)
  (with-eval-after-load 'net-utils
    (eval-when-compile
      (require 'net-utils))
    (when (string= netstat-program "netstat")
      (setopt netstat-program-options '("-a" "-n" "-o")))))

;;; E-Mail:

(keymap-global-unset "C-x m")    ; ‘compose-mail’
(keymap-global-unset "C-x 4 m")  ; ‘compose-mail’
(keymap-global-unset "C-x 5 m")  ; ‘compose-mail’
(keymap-global-unset "C-x 5 m")  ; ‘compose-mail-other-frame’

(provide 'shynur-cyber)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
