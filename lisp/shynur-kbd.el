;;; -*- lexical-binding: t; -*-

(let ((shynur/kbd-translation-modifier (lambda ()
                                         "重新解释键盘扫描码:
‘[’/‘]’解释为‘(’/‘)’, and vice versa."
                                         ;; 若从 daemon 启动, 则需要在 client 进程中执行.
                                         (keyboard-translate ?\[ ?\()
                                         (keyboard-translate ?\] ?\))
                                         (keyboard-translate ?\( ?\[)
                                         (keyboard-translate ?\) ?\]))))
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook
                ;; (为什么要用‘letrec’ -- 见 <https://emacs.stackexchange.com/a/77767/39388>.)
                (letrec ((shynur/kbd-translation-modifier--then-remove-itself (lambda ()
                                                                                (funcall shynur/kbd-translation-modifier)
                                                                                (remove-hook 'server-after-make-frame-hook
                                                                                             shynur/kbd-translation-modifier--then-remove-itself))))
                  shynur/kbd-translation-modifier--then-remove-itself))
    (funcall shynur/kbd-translation-modifier)))

;;; Keyboard Macro

(keymap-global-unset "C-x C-k RET")  ; ‘kmacro-edit-macro’.  该键易与 [C-x k RET] 混淆.

;;; MS-Windows:

(setq w32-alt-is-meta t
      w32-capslock-is-shiftlock nil)

(setq w32-enable-caps-lock nil  ; Type \\[CaplsLock] 产生符号‘capslock’, 而不是锁定大写.
      ;; Type \\[NumLock] 产生符号‘kp-numlock’, 而不是切换数字小键盘.
      w32-enable-num-lock nil)

(setq w32-apps-modifier 'hyper)

(setq w32-pass-alt-to-system nil)

(provide 'shynur-kbd)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
