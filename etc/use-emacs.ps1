#! pwsh

# 用途 同 ‘./use-emacs.bash’.
# Usage: use-emacs.ps1 PREFIXDIR.
#        ‘PREFIXDIR’ 表示 Emacs 安装目录, e.g., ‘D:/Progs/Emacs/’.

function shynur-Emacsclientw {
    # TODO: 根据参数使用正确的 emacsclientw.exe 路径; 使用正确的 server file.
    D:/Progs/emacs/bin/emacsclientw.exe                                     `
      --server-file=d:/Documents/Apps/emacs/server-auth-dir/server-name.txt `
      --alternate-editor=""                                                 `
      --create-frame                                                        `
      $args
}
Set-Alias -Name emacs -Value shynur-Emacsclientw

# Local Variables:
# coding: utf-8-unix
# End:
