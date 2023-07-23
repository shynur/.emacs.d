;;; -*- lexical-binding: t; -*-

(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.36789)

(setq package-quickstart nil  ; 每次启动时 re-computing 而不是 使用 precomputed 的文件.
      ;; 相当于在 加载“init.el” 前 执行‘package-initialize’.
      package-enable-at-startup t)

(provide 'shynur-early-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
