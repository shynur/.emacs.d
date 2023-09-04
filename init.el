;;; -*- lexical-binding: t; -*-

;; 参见 ‘early-init.el’ 中的设置.
(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.9999999999999999)
      (frame-inhibit-implied-resize t)
      (inhibit-file-name-handlers t)
      (inhibit-menubar-update t)
      (inhibit-message t)
      (inhibit-redisplay t))
  ;; (find-file-other-window "./lisp/shynur-init.el")
  (require 'shynur-init))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
