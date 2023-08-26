#! /usr/bin/env bash

# 在‘~/.bash_login’中 source 本文件, 初始化 Emacs 使用环境 以及 Emacs 快捷方式.
# Usage: use-emacs.bash [PREFIXDIR].
#        ‘PREFIXDIR’ 是 Emacs 的安装路径, 通常为 ‘/usr/local/’ (MS-Windows 上类似于 ‘D:/Progs/Emacs/’);
#        假设该路径 不含空白 字符.

if [ -n "$1" ]; then
    SHYNUR_EMACS_PREFIXDIR_BIN="$1"/bin/
else
    SHYNUR_EMACS_PREFIXDIR_BIN="$(emacs        \
                                    -Q --batch \
                                    --eval "(princ (file-name-directory "\"`type -fPp emacs`\""))")"
fi

SHYNUR_EMACS_CONFIG_DIR="`${SHYNUR_EMACS_PREFIXDIR_BIN}/emacs \
                            -Q --batch                        \
                            --eval '(princ user-emacs-directory)'`"

# 如果电脑上只有一个用户, 且希望把‘site-lisp’和个人配置放在一起的话:
export EMACSLOADPATH="$SHYNUR_EMACS_CONFIG_DIR"/site-lisp/:
# 命令行选项‘-L’处理的时间较晚, 并且不会加载‘subdirs.el’,
# 所以不能准确模拟‘PREFIXDIR/share/emacs/site-lisp/’.

# TODO: 设置 login 自启.
# # 启动 Emacs 后台进程.
# '${SHYNUR_EMACS_PREFIXDIR_BIN}/emacs' \
#   --daemon                            \
#   --debug-init                        \
#   --module-assertions
# # --module-assertions: 检查 module 的健壮性 (高耗时).


export EDITOR="${SHYNUR_EMACS_PREFIXDIR_BIN}/emacsclient                                                                     \
                 --server-file='`${SHYNUR_EMACS_PREFIXDIR_BIN}/emacs                                                         \
                                   -Q --batch                                                                                \
                                   --load ${SHYNUR_EMACS_CONFIG_DIR}/etc/shynur-custom.el                                    \
                                   --eval '(princ (file-truename shynur/custom:appdata/))'/`server-auth-dir/server-name.txt' \
                 --alternate-editor=                                                                                         \
                 --create-frame"
export VISUAL="$EDITOR"
export TEXEDIT="$EDITOR"  # TeX 的默认编辑器.

# 这些语句放在这里是无效的; 复制粘贴到 ‘~/.bashrc’ 使其生效.
alias emacs="$EDITOR"
alias vi='emacs '
alias vim='emacs '

# Local Variables:
# coding: utf-8-unix
# End:
