;;; -*- lexical-binding: t; -*-

(add-hook 'window-setup-hook
          (let ((shynur--performance-impactful-variables `[
                                                           ;; 自上次 GC 以来分配超过该 字节数 则立刻执行 GC.
                                                           [gc-cons-threshold            ,most-positive-fixnum shynur--expected-value]
                                                           ;; 同上, 但是是以 heap 被分配的比例裁定.
                                                           ;; 若该值更小, 则服从 ‘gc-cons-threshold’.
                                                           [gc-cons-percentage           1.0                   shynur--expected-value]
                                                           [frame-inhibit-implied-resize t                     shynur--expected-value]
                                                           [inhibit-file-name-handlers   t                     shynur--expected-value]
                                                           [inhibit-menubar-update       t                     shynur--expected-value]
                                                           ;; ‘inhibit-message’ 必须为 t, 为了有时能正常向终端输出消息.
                                                           [inhibit-redisplay            t                     shynur--expected-value]
                                                           ]))
            (mapc (lambda (variable-new-expected)
                    (let ((shynur--variable-name  (aref variable-new-expected 0)))
                      (when (eq (aref variable-new-expected 2) 'shynur--expected-value)
                        (when (boundp shynur--variable-name)
                          (aset variable-new-expected 2 (default-toplevel-value shynur--variable-name))))
                      (set-default-toplevel-value shynur--variable-name (aref variable-new-expected 1)))) shynur--performance-impactful-variables)
            (lambda ()
              (make-thread (lambda ()
                             (sleep-for 1)
                             (require 'seq)
                             (seq-doseq (variable-new-expected shynur--performance-impactful-variables)
                               (set-default-toplevel-value (aref variable-new-expected 0) (aref variable-new-expected 2))))))))

(setq load-prefer-newer nil
      force-load-messages t)

(push (file-name-concat user-emacs-directory
                        "lisp/") load-path)

(require 'shynur-early-init)  ; (find-file-other-window "./lisp/shynur-early-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
