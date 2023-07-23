;;; -*- lexical-binding: t; -*-

;; 1. 设置环境变量:
;;   - EDITOR=/bin/emacsclientw                                                    \
;;              --server-file=~/.emacs.d/.appdata/server-auth-dir/server-name.txt  \
;;              --alternate-editor=""                                              \
;;              --create-frame
;;   - VISUAL=$EDITOR 可选的.
;;   - TEXEDIT=$EDITOR 可选的, 使 TeX 使用 Emacs.
;;
;; 2. 推荐的命令行参数 (not for client):
;;   --debug-init
;;   --module-assertions  # 检查 module 的健壮性.  (高耗时.)

(require 'shynur-init)  ; (find-file-other-window "./lisp/shynur-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; End:
