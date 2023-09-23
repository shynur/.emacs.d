;;; -*- lexical-binding: t; -*-

;;; Environment:

(shynur/custom:appdata/ nsm-settings-file data)  ; 记录已知的安全 connection.

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
