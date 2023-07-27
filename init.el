;;; -*- lexical-binding: t; -*-

;; 1. 设置环境变量:
;;   - EDITOR=/bin/emacsclientw                                                 \
;;              --server-file=~/.emacs.d/.data/server-auth-dir/server-name.txt  \
;;              --alternate-editor=""                                           \
;;              --create-frame
;;   - VISUAL=$EDITOR 可选的.
;;   - TEXEDIT=$EDITOR 可选的, 使 TeX 使用 Emacs.
;;
;; 2. 推荐的命令行参数 (for daemon):
;;   --debug-init
;;   -L ~/site-lisp/  # 单独管理‘PREFIXDIR/share/emacs/site-lisp/’有点麻烦,
;;                    # 所以将其放到‘user-emacs-directory’中, 因此需要另外
;;                    # 添加到‘load-path’(而且必须从命令行参数中添加).

(require 'shynur-init)  ; (find-file-other-window "./lisp/shynur-init.el")

;; Local Variables:
;; coding: utf-8-unix
;; End:
