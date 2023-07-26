;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; 1. 存储确认项, e.g., 新手第一次使用‘narrow-to-region’时, Emacs 会请求确认.
;; 2. 存储安全项, e.g., ‘safe-local-variable-values’.

(with-eval-after-load 'files
  (setq safe-local-variable-values `(,@safe-local-variable-values
                                     . ,(let ((shynur--safe-local-variable-values (list)))
                                          (named-let get-vars ((dir-locals (mapcan (lambda (file-path)
                                                                                     (when (file-exists-p file-path)
                                                                                       (with-temp-buffer
                                                                                         (insert-file-contents file-path)
                                                                                         (read (current-buffer))))) `[,@(mapcar (lambda (_dir-loc)
                                                                                                                                  "囊括诸如‘~/.emacs.d/’下的‘.dir-locals.el’文件."
                                                                                                                                  (file-name-concat user-emacs-directory
                                                                                                                                                    _dir-loc)) [".dir-locals.el"
                                                                                                                                                                ".dir-locals-2.el"])
                                                                                                                      ])))
                                            (dolist (mode-vars dir-locals)
                                              (let ((vars (cdr mode-vars)))
                                                (if (stringp (car mode-vars))
                                                    (get-vars vars)
                                                  (dolist (var-pair vars)
                                                    (push var-pair shynur--safe-local-variable-values))))))
                                          shynur--safe-local-variable-values))))


(put 'narrow-to-region 'disabled nil)

(provide 'shynur-misc)

;; Local Variables:
;; coding: utf-8-unix
;; End:
