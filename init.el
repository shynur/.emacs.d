;;; -*- lexical-binding: t; -*-

;; 1. 设置环境变量:
;;   - EDITOR=bin/emacsclientw --server-file=~/.emacs.d/.data/server-name.txt --alternate-editor="" --create-frame
;;   - VISUAL=$EDITOR 可选的
;;   - TEXEDIT=$EDITOR 可选的, 使 TeX 使用 Emacs
;;
;; 2. 通用命令行参数:
;;   --no-splash
;;   --debug-init
;;   --no-blinking-cursor
;;   --vertical-scroll-bars

(require 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
