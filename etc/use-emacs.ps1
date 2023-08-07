#! pwsh

function shynur-Emacsclientw {
    D:/Progs/emacs/bin/emacsclientw.exe                                      `
      --server-file=d:/Documents/Apps/emacs/server-auth-dir/server-name.txt  `
      --alternate-editor=""                                                  `
      --create-frame                                                         `
      $args
}
Set-Alias -Name emacs -Value shynur-Emacsclientw

# Local Variables:
# coding: utf-8-unix
# End:
