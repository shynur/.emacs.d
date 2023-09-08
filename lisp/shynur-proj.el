;;; -*- lexical-binding: t; -*-

(shynur/custom:appdata/ project-list-file el)
(setq project-switch-commands #'project-find-file)  ; “C-x p p”选中项目后 立刻执行指定的 command.

(provide 'shynur-proj)

;; Local Variables:
;; coding: utf-8-unix
;; End:
