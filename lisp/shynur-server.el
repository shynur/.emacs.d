;;; -*- lexical-binding: t; -*-

;; MS-Windows 上, server file (见 emacsclient 的命令行参数 “--server-file”) 一般放在该目录下.
(shynur/custom-appdata/ server-auth-dir /)

(shynur/custom-appdata/ server-socket-dir /)

;; Server 的名字, 也被用来命名 server file (见 emacsclient 的命令行参数 “--server-file”).
(shynur/custom-appdata/ server-name nil nil
  "server-name.txt")

;; 启动时不要提示 完成编辑 之后要告知 emacsclient 正常/出错 退出.
(setq server-client-instructions nil)

(provide 'shynur-server)

;; Local Variables:
;; coding: utf-8-unix
;; End:
