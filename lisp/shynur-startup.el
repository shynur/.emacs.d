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
;; |  |  |  |  |  |  |  |  (/ |  |  |  |  |  |
;; |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
\n"
                                0 671 ( face           #1=(:foreground "VioletRed1")
                                        font-lock-face #1#)))

(setq inhibit-startup-screen t
      initial-buffer-choice  user-emacs-directory)

;; 启动 Emacs 时 (通过 命令行参数) 一次性访问多个 (>2) 文件时, 不额外显示 Buffer Menu.
(setq inhibit-startup-buffer-menu t)

;; 只有设为自己在 OS 中的 username, 才能屏蔽启动时 echo area 的“For information about GNU Emacs and the GNU system, type C-h C-a.”
(setq inhibit-startup-echo-area-message user-login-name)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message (shynur/message-format #("启动耗时 %.1fs"
                                              5 9 (face bold)))
                     (time-to-seconds (time-since before-init-time)))))

(provide 'shynur-startup)

;; Local Variables:
;; coding: utf-8-unix
;; End:
