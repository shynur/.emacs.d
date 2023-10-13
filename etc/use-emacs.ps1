#! pwsh

# 用途 同 ‘./use-emacs.bash’.
# Usage: use-emacs.ps1 PREFIXDIR.
#        ‘PREFIXDIR’ 表示 Emacs 安装目录, e.g., ‘D:/Progs/Emacs/’.

$SHYNUR_EMACS_PREFIXDIR_BIN = "$($args[0])/bin/"

$SHYNUR_EMACS_CONFIG_DIR = &            `
    "$SHYNUR_EMACS_PREFIXDIR_BIN/emacs" `
       '-Q' '--batch'                   `
       '--eval' '(princ (expand-file-name user-emacs-directory))'

$env:EMACSLOADPATH = "$SHYNUR_EMACS_CONFIG_DIR/site-lisp/$(if ($IsWindows) {';'} else {':'})"
[System.Environment]::SetEnvironmentVariable(
    'EMACSLOADPATH', $env:EMACSLOADPATH,
    [System.EnvironmentVariableTarget]::User
)  # TODO: 这句耗时很多, 应改为: 若不等, 则调用 SetEnvironmentVariable.

$env:EDITOR = "$SHYNUR_EMACS_PREFIXDIR_BIN/emacsclient$(if ($IsWindows) {'w'} else {''}) `
                 --server-file=$(&                                      `
                   $SHYNUR_EMACS_PREFIXDIR_BIN/emacs                    `
                   -Q --batch                                           `
                   --load $SHYNUR_EMACS_CONFIG_DIR/etc/shynur-custom.el `
                   --eval '(princ (expand-file-name shynur/custom:appdata/))'
                 )/server-auth-dir/server-name.txt                                       `
                 --alternate-editor=                                                     `
                   --create-frame" -replace "`n", " "

# TODO: 下面这段耗时很多, 应改为: 若不等, 则调用 SetEnvironmentVariable.
[System.Environment]::SetEnvironmentVariable(
    'EDITOR', $env:EDITOR,
    [System.EnvironmentVariableTarget]::User
)
[System.Environment]::SetEnvironmentVariable(
    'VISUAL', $env:EDITOR,
    [System.EnvironmentVariableTarget]::User
); $env:VISUAL = $env:EDITOR
[System.Environment]::SetEnvironmentVariable(
    'TEXEDIT', $env:EDITOR,
    [System.EnvironmentVariableTarget]::User
); $env:TEXEDIT = $env:EDITOR

function shynur-EmacsClient {
    Invoke-Expression "$env:EDITOR $args"
    # 由于本人才疏学浅, 对 PowerShell 没有研究,
    # 这个函数目前只能像这样传参: shynur-EmacsClient '"--eval" "(某个函数调用)"'
    # TODO: 使其能像这样传参:     shynur-EmacsClient   --eval  '(某个函数调用)'
}
Set-Alias -Name emacs -Value shynur-EmacsClient
Set-Alias -Name vi    -Value emacs
Set-Alias -Name vim   -Value emacs

# Local Variables:
# coding: utf-8-unix
# End:
