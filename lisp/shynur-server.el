;;; -*- lexical-binding: t; -*-

(setq server-log t)
(setq server-msg-size (* 1024 1024))

;; MS-Windows 只能用 TCP, 所以稍微委屈一下 GNU/Linux 啦.
(setopt server-use-tcp t)
(when (and (string= shynur/custom:truename "谢骐")
           (string= (system-name) "ASUS-TX2"))
  (setopt server-host "localhost"
          ;; 随机分配 端口号 给 TCP 使用.
          server-port nil))
;; MS-Windows 上, server file (见 emacsclient 的命令行参数 “--server-file”) 一般放在该目录下.
(chmod (shynur/custom:appdata/ server-auth-dir /)
       ;; Emacs 强制要求的 安全性:
       #o700 'nofollow)
;; Server 的名字, 也被用来命名 server file (见 emacsclient 的命令行参数 “--server-file”).
(shynur/custom:appdata/ server-name nil nil
  "server-name.txt")

;; 似乎是启用 UDS 协议时的设置, 但我用 TCP, 所以不用深究了.
(shynur/custom:appdata/ server-socket-dir /)

;; 启动时不要提示 完成编辑 之后要告知 emacsclient 正常/出错 退出.
(setopt server-client-instructions nil)

(provide 'shynur-server)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
