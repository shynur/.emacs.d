;;; -*- lexical-binding: t; -*-

(defun shynur/init-data/ (option type)
  "确保在“USER-EMACS-DIRECTORY/.data/”下有一个新路径, 其名为 OPTION, 类型为 TYPE; 将该绝对路径赋给 OPTION.
TYPE 的可能值为: \"\" 无后缀, \"/\" 目录, \".EXTENSION\" 文件类型.
返回值为该绝对路径."
  (let ((shynur/init-data/path (file-name-concat user-emacs-directory ".data/"
                                                 (concat (symbol-name option)
                                                         type))))
    (make-directory (file-name-directory shynur/init-data/path)
                    "DWIM")
    (set option shynur/init-data/path)))

(defvar shynur--tmp-count 0)
(defun shynur--intern&bind-tmp ()
  (let ((interned-symbol (intern (format "shynur--%d"
                                         (cl-incf shynur--tmp-count)))))
    (set interned-symbol nil)
    interned-symbol))

(defun shynur/message-format (format-string)
  #("在开头加上“Shynur: ”"
    6 13 (face (shadow italic)))
  (declare (pure t)
           (indent 1))
  (format #("Shynur: %s"
            0 7 (face (shadow italic)))
          format-string))

(defmacro shynur/buffer-eval-after-created (buffer-or-name &rest body)
  (declare (indent 1))
  (let ((&buffer-or-name (gensym "shynur/buffer-eval-after-created-")))
    `(progn
       (setq ,&buffer-or-name ,buffer-or-name)
       (make-thread (lambda ()
                      (while (not (get-buffer ,&buffer-or-name))
                        (thread-yield))
                      ,@body)))))

(add-hook 'post-gc-hook
          (lambda ()
            (message (shynur/message-format "%s")
                     (format-spec
                      #("%n GC (%ss total): %B VM, %mmin runtime"
                        7  9 (face bold)
                        26 28 (face bold))
                      `((?n . ,(format #("%d%s"
                                         0 2 (face bold))
                                       gcs-done
                                       (pcase (mod gcs-done 10)
                                         (1 "st")
                                         (2 "nd")
                                         (3 "rd")
                                         (_ "th"))))
                        (?m . ,(floor (time-to-seconds (time-since before-init-time)) 60))
                        (?s . ,(round gc-elapsed))
                        (?B . ,(cl-loop for memory = (memory-limit) then (/ memory 1024.0)
                                        for mem-unit across "KMGT"
                                        when (< memory 1024)
                                        return (format #("%.1f%c"
                                                         0 4 (face bold))
                                                       memory
                                                       mem-unit))))))))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message (shynur/message-format #("启动耗时[%.1f]s"
                                              5 9 (face bold)))
                     (time-to-seconds (time-since before-init-time)))))

;; 顺序应当是不重要的.
(require 'shynur-elisp)    ; (find-file-other-window "./shynur-elisp.el")
(require 'shynur-tmp)      ; (find-file-other-window "./shynur-tmp.el")
(require 'shynur-org)      ; (find-file-other-window "./shynur-org.el")
(require 'shynur-abbrev)   ; (find-file-other-window "./shynur-abbrev.el")
(require 'shynur-themes)   ; (find-file-other-window "./themes/shynur-themes.el")
(require 'shynur-server)   ; (find-file-other-window "./shynur-server.el")
(require 'shynur-cc)       ; (find-file-other-window "./shynur-cc.el")
(require 'shynur-profile)  ; (find-file-other-window "./shynur-profile.el")
(require 'shynur-startup)  ; (find-file-other-window "./shynur-startup.el")
(require 'shynur-lib)      ; (find-file-other-window "./shynur-lib.el")

(provide 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
