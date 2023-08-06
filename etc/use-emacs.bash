#! /usr/bin/env bash
# 每次登入账户时 source 该文件.  (IOW, 在 Bash 的 profile 文件中 source 该文件.)
# 你需要手动修改变量: EMACS_INSTALL_PREFIXDIR

# Tips:
#   1. systemctl --user enable emacs

# 假设: 安装目录 不带空格.
SHYNUR_EMACS_INSTALL_PREFIXDIR="$(emacs        \
                                   -Q --batch  \
                                   --eval "(princ (file-name-directory "\"`type -fPp emacs`\""))")"

SHYNUR_USER_EMACS_DIRECTORY="`${SHYNUR_EMACS_INSTALL_PREFIXDIR}emacs  \
                               -Q --batch                             \
                               --eval '(princ user-emacs-directory)'`"

export EDITOR="${SHYNUR_EMACS_INSTALL_PREFIXDIR}emacsclientw                                               \
                --server-file='`${SHYNUR_EMACS_INSTALL_PREFIXDIR}emacs                                     \
                                 -Q --batch                                                                \
                                 --load ${SHYNUR_USER_EMACS_DIRECTORY}etc/shynur-custom.el                 \
                                 --eval '(princ shynur/custom-appdata/)'`server-auth-dir/server-name.txt'  \
                --alternate-editor='${SHYNUR_EMACS_INSTALL_PREFIXDIR}emacs                                 \
                                     --daemon                                                              \
                                     --debug-init                                                          \
                                     --module-assertions'                                                  \
                --create-frame"
# --module-assertions: 检查 module 的健壮性 (高耗时).

# 如果电脑上只有一个用户, 且希望把‘site-lisp’和个人配置放在一起的话:
export EMACSLOADPATH="$SHYNUR_USER_EMACS_DIRECTORY"site-lisp/:
# 命令行选项‘-L’处理的时间较晚, 并且不会加载‘subdirs.el’,
# 所以不能准确模拟‘/usr/local/share/emacs/site-lisp/’.

export VISUAL="$EDITOR"
export TEXEDIT="$EDITOR"  # TeX 的默认编辑器.

alias emacs="$EDITOR"
alias vi='emacs '
alias vim='emacs '

# Local Variables:
# coding: utf-8-unix
# End:
