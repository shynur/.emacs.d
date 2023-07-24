;;; -*- lexical-binding: t; -*-

;; MS-Windows 上, server file (见 emacsclient 的命令行参数 “--server-file”) 一般放在该目录下.
(shynur/init-data/ 'server-auth-dir "/")

(shynur/init-data/ 'server-socket-dir "/")

;; Server 的名字, 也被用来命名 server file (见 emacsclient 的命令行参数 “--server-file”).
(setq server-name "server-name.txt")

;; 启动时不要提示 完成编辑 之后要告知 emacsclient 正常/出错 退出.
(setq server-client-instructions nil)

(provide 'shynur-server)

;; Local Variables:
;; coding: utf-8-unix
;; End:
