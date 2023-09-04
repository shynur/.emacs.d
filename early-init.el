;;; -*- lexical-binding: t; -*-

(setq load-prefer-newer nil
      force-load-messages t)

(push (file-name-concat user-emacs-directory
                        "lisp/") load-path)

(let (;; 自上次 GC 以来分配超过该 字节数 则立刻执行 GC.
      (gc-cons-threshold most-positive-fixnum)
      ;; 同上, 但是是以 heap 被分配的比例裁定.
      ;; 若该值更小, 则服从‘gc-cons-threshold’.
      (gc-cons-percentage 0.9999999999999999)
      (frame-inhibit-implied-resize t)
      (inhibit-file-name-handlers t)
      (inhibit-menubar-update t)
      (inhibit-message t)
      (inhibit-redisplay t))
  ;; (find-file-other-window "./lisp/shynur-early-init.el")
  (require 'shynur-early-init))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
