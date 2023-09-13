;;; -*- lexical-binding: t; -*-

(setq initial-scratch-message #(";;     *
;;      May the Code be with You!
;;     .                                 .
;;                               *
;;          /\\/|_      __/\\\\
;;         /    -\\    /-   ~\\  .              \\='
;;         \\    = Y =T_ =   /
;;          )==*(\\=`     \\=`) ~ \\
;;         /     \\     /     \\
;;         |     |     ) ~   (
;;        /       \\   /     ~ \\
;;        \\       /   \\~     ~/
;; _/\\_/\\_/\\__  _/_/\\_/\\__~__/_/\\_/\\_/\\_/\\_/\\_
;; |  |  |  | ) ) |  |  | ((  |  |  |  |  |  |
;; |  |  |  |( (  |  |  |  \\\\ |  |  |  |  |  |
;; |  |  |  | )_) |  |  |  |))|  |  |  |  |  |
;; |  |  |  |  |  |  |  |  (/ |  jgs/shynur  |
;; |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
\n"  ; originally created by Joan G. Stark
                                0 671 ( face           #1=(:foreground "VioletRed1")
                                        font-lock-face #1#))  ; 它会先被 ‘substitute-command-keys’ 处理.
      initial-major-mode 'lisp-interaction-mode)

(setq inhibit-startup-screen t
      initial-buffer-choice  user-emacs-directory)

;; 启动 Emacs 时 (通过 命令行参数) 一次性访问多个 (>2) 文件时, 不额外显示 Buffer Menu.
(setq inhibit-startup-buffer-menu t)

;; 只有设为自己在 OS 中的 username, 才能屏蔽启动时 echo area 的 “For information about GNU Emacs and the GNU system, type C-h C-a.”
(put 'inhibit-startup-echo-area-message  ; 需要如此 hack.
     'saved-value `(,(setq inhibit-startup-echo-area-message user-login-name)))

(add-hook 'post-command-hook
          (letrec ((shynur/startup:indicator (lambda ()
                                               (remove-hook 'post-command-hook shynur/startup:indicator)
                                               (let ((emacs-init-time (time-to-seconds (time-since before-init-time))))
                                                 (message #("Shynur: 启动耗时 %.2fs"
                                                            13 17 (face bold))
                                                          emacs-init-time)
                                                 (when (daemonp)
                                                   ;; 发出通知: Emacs 后台进程启动了.
                                                   (let ((shynur/startup:balloon-title "Emacs Daemon Launched")
                                                         (shynur/startup:balloon-body (format "Emacs 已经在后台启动了\n耗时 %.2f 秒"
                                                                                              emacs-init-time)))
                                                     (pcase system-type
                                                       ('windows-nt
                                                        (advice-add 'w32-notification-notify :before
                                                                    (let* ((shynur/startup:balloon-emitting-frame (let (before-make-frame-hook
                                                                                                                        window-system-default-frame-alist initial-frame-alist default-frame-alist
                                                                                                                        after-make-frame-functions server-after-make-frame-hook)
                                                                                                                    (make-frame-on-display (symbol-name initial-window-system)
                                                                                                                                           '((visibility . nil)))))
                                                                           (shynur/startup:balloon (with-selected-frame shynur/startup:balloon-emitting-frame
                                                                                                     (w32-notification-notify
                                                                                                      :level 'info
                                                                                                      :title shynur/startup:balloon-title
                                                                                                      :body shynur/startup:balloon-body)))
                                                                           (shynur/startup:message-closer (lambda ()
                                                                                                            "关闭 ‘shynur/startup:balloon’ 后, 顺便将其设为字符串 “closed”."
                                                                                                            (with-selected-frame shynur/startup:balloon-emitting-frame
                                                                                                              (w32-notification-close (prog1 shynur/startup:balloon
                                                                                                                                        (setq shynur/startup:balloon "closed")))
                                                                                                              (let (delete-frame-functions
                                                                                                                    after-delete-frame-functions)
                                                                                                                (delete-frame))))))
                                                                      (run-with-idle-timer 10 nil
                                                                                           (lambda ()
                                                                                             (unless (stringp shynur/startup:balloon)
                                                                                               (funcall shynur/startup:message-closer))))
                                                                      (lambda (&rest _)
                                                                        (advice-remove 'w32-notification-notify "shynur/startup:message-closer")
                                                                        (unless (stringp shynur/startup:balloon)
                                                                          (funcall shynur/startup:message-closer)))) '((name . "shynur/startup:message-closer"))))
                                                       (_
                                                        (require 'notifications)
                                                        (notifications-notify
                                                         :title shynur/startup:balloon-title
                                                         :body shynur/startup:balloon-body
                                                         :transient t)))))))))
            shynur/startup:indicator)
          100)

(provide 'shynur-startup)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
