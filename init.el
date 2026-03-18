;;; UI
(blink-cursor-mode -1)
(push `(,(pcase system-type
	       (windows-nt 'alpha)
           (gnu/linux 'alpha-background)
           (_ 'alpha)) . 80) default-frame-alist)
(push '(fullscreen . maximized) default-frame-alist)
(setq frame-title-format `(""
                           default-directory "\t"
                           "🧹x" (:eval (number-to-string gcs-done))
                           "~" (:eval (number-to-string (round gc-elapsed))) "s "
                           "💾" (:eval (prog1 'init/emacs:rss-memory
                                         ,(put 'init/emacs:rss-memory :test-times 0)
                                         ,(add-hook 'post-gc-hook (lambda ()
                                                                    (put 'init/emacs:rss-memory :test-times -1)))
                                         (when (zerop (mod (put 'init/emacs:rss-memory :test-times (1+ (get 'init/emacs:rss-memory :test-times)))
                                                           50))
                                           (set 'init/emacs:rss-memory (cl-loop for init/emacs:rss-memory = (let ((default-directory temporary-file-directory))
                                                                                                              (alist-get 'rss (process-attributes (emacs-pid))))
                                                                                then (/ init/emacs:rss-memory 1024.0)
                                                                                for init/emacs:rss-memory-unit across "KMGTPEZ"
                                                                                when (< init/emacs:rss-memory 1024) return (format "%.1f%c"
                                                                                                                                   init/emacs:rss-memory
                                                                                                                                   init/emacs:rss-memory-unit)))))) "iB "
                           "⏱️" (:eval (emacs-uptime "%h:%.2m")) " "
                           (pixel-scroll-precision-mode
                            nil
                            ("🎹" (:eval (number-to-string num-input-keys)) "/" (:eval (number-to-string num-nonmacro-input-events))))))

;;; Keyboard
(let ((init/kbd:key-swapper (let ((init/kbd:key-swapped-terminals ()))
			                  (lambda (frame)
				                (let ((current-term (frame-terminal)))
				                  (unless (memq current-term init/kbd:key-swapped-terminals)
				                    (with-selected-frame frame
                                      (keyboard-translate ?\[ ?\()
                                      (keyboard-translate ?\] ?\))
                                      (keyboard-translate ?\( ?\[)
                                      (keyboard-translate ?\) ?\])
                                      (push current-term init/kbd:key-swapped-terminals))))))))
  (add-hook 'after-make-frame-functions init/kbd:key-swapper)
  (unless (daemonp)
    (funcall init/kbd:key-swapper (selected-frame))))

;;; Writing
(setopt indent-tabs-mode nil
   	    tab-width 4)
(setopt tab-always-indent t)
(delete-selection-mode)
(global-page-break-lines-mode)
(setopt x-stretch-cursor t)

;;; Coding
(add-hook 'prog-mode-hook #'company-mode)
(add-hook 'ielm-mode-hook #'company-mode)
;; Lisp
(add-hook 'lisp-data-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook #'rainbow-delimiters-mode)
;; LSP
(setopt eglot-confirm-server-initiated-edits nil)
(seq-doseq (LSPable-mode-hook [go-mode-hook rust-mode-hook])
  (add-hook LSPable-mode-hook (lambda ()
                                (yas-minor-mode)
                                (make-thread (lambda ()
                                               (sleep-for 0.1)
                                               (execute-kbd-macro (kbd "M-x eglot <return>")))))))

;;; `*Completions*' List Buffer
(add-hook 'completion-list-mode-hook (lambda ()
                                       (setq-local truncate-lines t)))
(marginalia-mode)

;;; Interavtive
(repeat-mode)

;; Local Variables:
;; no-byte-compile: nil
;; no-native-compile: nil
;; indent-tabs-mode: nil
;; require-final-newline: t
;; delete-trailing-lines: t
;; End:
