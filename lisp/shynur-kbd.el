;;; -*- lexical-binding: t; -*-

;;; Key Translation

(let* ((shynur/kbd:key-swapped-terminals ())
       (shynur/kbd:key-swapper (lambda (frame)
                                 (with-selected-frame frame
                                   (unless (memq (frame-terminal) shynur/kbd:key-swapped-terminals)
                                     (keyboard-translate ?\[ ?\()
                                     (keyboard-translate ?\] ?\))
                                     (keyboard-translate ?\( ?\[)
                                     (keyboard-translate ?\) ?\])
                                     (push (frame-terminal) shynur/kbd:key-swapped-terminals))))))
  (add-hook 'after-make-frame-functions
            shynur/kbd:key-swapper)
  (unless (daemonp)
    (funcall shynur/kbd:key-swapper (selected-frame))))

;; E.g., 如果 ‘C-a’ 有定义 且 ‘C-A’ 无, 则 使用 ‘C-a’.
(setq translate-upper-case-key-bindings t)  ; 最好别改它.

;; 使用 ‘read-from-minibuffer’, 这样依然能在读取过程中调用其它 command.
(setq read-char-choice-use-read-key nil)

;;; Keyboard Macro

(keymap-global-unset "C-x C-k RET")  ; ‘kmacro-edit-macro’.  该键易与 \\[C-x k RET] 混淆.

;;; Keystroke

(lossage-size 33554431)

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
