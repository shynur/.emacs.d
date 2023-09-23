;;; -*- lexical-binding: t; -*-

(shynur/custom:appdata/ project-list-file el)
(setq project-switch-commands #'project-find-file)  ; “C-x p p”选中项目后 立刻执行指定的 command.

(setq enable-local-variables t  ; 尽量不询问, 但提供记忆功能 (但因 ‘custom-file’ 被修改了, 故无效).
      enable-dir-local-variables t
      ;; 远程时 不 向上寻找 “.dir-locals.el” 以应用 directory local 变量.
      enable-remote-dir-locals nil)

(setq safe-local-variable-values (let ((shynur--safe-local-variable-values ()))
                                   (named-let get-vars ((dir-locals (mapcan (lambda (file-path)
                                                                              (when (file-exists-p file-path)
                                                                                (with-temp-buffer
                                                                                  (insert-file-contents file-path)
                                                                                  (read (current-buffer))))) `[,@(mapcar (lambda (dir-loc)
                                                                                                                           "囊括诸如‘~/.emacs.d/’下的‘.dir-locals.el’文件."
                                                                                                                           (file-name-concat user-emacs-directory
                                                                                                                                             dir-loc)) [".dir-locals.el"
                                                                                                                                                        ".dir-locals-2.el"])
                                                                                                               "d:/Desktop/CheatSheets/.dir-locals.el"
                                                                                                               ])))
                                     (dolist (mode-vars dir-locals)
                                       (let ((vars (cdr mode-vars)))
                                         (if (stringp (car mode-vars))
                                             (get-vars vars)
                                           (dolist (var-pair vars)
                                             (push var-pair shynur--safe-local-variable-values))))))
                                   shynur--safe-local-variable-values))

(provide 'shynur-proj)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
