;;; -*- lexical-binding: t; -*-

;;; 与 宿主 OS 交互

;;; Process:

(setq read-process-output-max (min (pcase system-type
                                     ('gnu/linux
                                      (string-to-number  (shell-command-to-string "cat /proc/sys/fs/pipe-max-size")))
                                     (_
                                      most-positive-fixnum)) (* 1024 1024))
      process-adaptive-read-buffering "急切读取"

      w32-pipe-buffer-size read-process-output-max
      w32-pipe-read-delay 0)

;;; File System:

(setq w32-get-true-file-attributes 'local)

;; 打开达到该字节数的大文件时询问相关事宜;
;; 重点在于可以借此开启 literally 读取模式, 这会关闭一些昂贵的功能以提高访问速度.
(setq large-file-warning-threshold (* 1024 1024))

(provide 'shynur-host)

;; Local Variables:
;; coding: utf-8-unix
;; End:
