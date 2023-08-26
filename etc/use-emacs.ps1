#! pwsh

# 用途 同 ‘./use-emacs.bash’.
# Usage: use-emacs.ps1 PREFIXDIR.
#        ‘PREFIXDIR’ 表示 Emacs 安装目录, e.g., ‘D:/Progs/Emacs/’.

$SHYNUR_EMACS_PREFIXDIR_BIN = "$($args[0])/bin/"

$SHYNUR_EMACS_CONFIG_DIR = &            `
    "$SHYNUR_EMACS_PREFIXDIR_BIN/emacs" `
       '-Q' '--batch'                   `
       '--eval' '(princ user-emacs-directory)'

[System.Environment]::SetEnvironmentVariable(
    'EMACSLOADPATH', "$SHYNUR_EMACS_CONFIG_DIR/site-lisp/$(if ($IsWindows) {';'} else {':'})",
    [System.EnvironmentVariableTarget]::User
)

$EDITOR = "$SHYNUR_EMACS_PREFIXDIR_BIN/emacsclient$(if ($IsWindows) {'w'} else {''}) `
             --server-file=$(&                                      `
               $SHYNUR_EMACS_PREFIXDIR_BIN/emacs                    `
               -Q --batch                                           `
               --load $SHYNUR_EMACS_CONFIG_DIR/etc/shynur-custom.el `
               --eval '(princ (file-truename shynur/custom:appdata/))'
             )/server-auth-dir/server-name.txt                                       `
             --alternate-editor=                                                     `
             --create-frame" -replace "`n", " "
[System.Environment]::SetEnvironmentVariable(
    'EDITOR', $EDITOR,
    [System.EnvironmentVariableTarget]::User
)
[System.Environment]::SetEnvironmentVariable(
    'VISUAL', $EDITOR,
    [System.EnvironmentVariableTarget]::User
)
[System.Environment]::SetEnvironmentVariable(
    'TEXEDIT', $EDITOR,
    [System.EnvironmentVariableTarget]::User
)

function shynur-EmacsClient {
    Invoke-Expression "$env:EDITOR $args"
}
Set-Alias -Name emacs -Value shynur-EmacsClient
Set-Alias -Name vi  -Value emacs
Set-Alias -Name vim -Value emacs

# Local Variables:
# coding: utf-8-unix
# End:
