;;; -*- lexical-binding: t; -*-

;; 1. 设置环境变量:
;;   - EDITOR=/bin/emacsclientw                                                 \
;;              --server-file=~/.emacs.d/.data/server-auth-dir/server-name.txt \
;;              --alternate-editor=""                                          \
;;              --create-frame
;;   - VISUAL=$EDITOR 可选的.
;;   - TEXEDIT=$EDITOR 可选的, 使 TeX 使用 Emacs.
;;
;; 2. 推荐的命令行参数:
;;   --no-splash
;;   --debug-init
;;   --no-blinking-cursor
;;   --vertical-scroll-bars

(require 'shynur-init)  ; (find-file-other-window "./lisp/shynur-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; End:
