;;; -*- lexical-binding: t; -*-

;; 1. 设置环境变量:
;;   - EDITOR=/usr/bin/emacsclientw                                                \
;;              --server-file=~/.emacs.d/.appdata/server-auth-dir/server-name.txt  \
;;              --alternate-editor=""                                              \
;;              --create-frame
;;   - VISUAL=$EDITOR   # 可选的.
;;   - TEXEDIT=$EDITOR  # 可选的, 使 TeX 使用 Emacs.
;;   - EMACSLOADPATH=~/.emacs.d/site-lisp/:  # 如果电脑上只有一个用户, 且希望把
;;                                           # ‘site-lisp’和个人配置放在一起的话.
;;                                           # 命令行选项‘-L’处理的时间较晚, 并且不
;;                                           # 会加载‘subdirs.el’, 所以不能准确模拟
;;                                           # ‘/usr/local/share/emacs/site-lisp/’.
;;
;; 2. 推荐的命令行参数 (not for client):
;;   --debug-init
;;   --module-assertions  # 检查 module 的健壮性.  (高耗时.)

(require 'shynur-init)  ; (find-file-other-window "./lisp/shynur-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
