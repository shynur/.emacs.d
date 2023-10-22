;;; 以正斜杠作为路径分隔符的 ‘explorer.exe’.  -*- lexical-binding: t; -*-
;;; 调用约定: runemacs.exe -Q --load explorer.elc Z:/Path/To/Folder

(make-frame-invisible nil "force")

(process-lines-ignore-status "explorer.exe"
                             (string-replace "/" "\\" (elt argv 0)))

(kill-emacs)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
