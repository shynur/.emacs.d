;;; -*- lexical-binding: t; -*-

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

(defmacro shynur/save-cursor-relative-position-in-window (&rest body)
  "保持 cursor 在当前 window 中的相对位置.
像‘progn’一样执行 BODY."
  (declare (indent 0))
  (let ((&shynur--distance-from-window-top-to-point (gensym "shynur/")))
    `(let ((,&shynur--distance-from-window-top-to-point (- (line-number-at-pos nil t)
                                                           (save-excursion
                                                             (move-to-window-line 0)
                                                             (line-number-at-pos nil t)))))
       (prog1 (with-selected-window (selected-window)
                ,@body)
         (redisplay)
         (scroll-up-line (- (- (line-number-at-pos nil t)
                               (save-excursion
                                 (move-to-window-line 0)
                                 (line-number-at-pos nil t)))
                            ,&shynur--distance-from-window-top-to-point))))))

(defmacro shynur/prog1-let (varlist &rest body)
  "(shynur/prog1-let (...
                   (sym val))
  ...)                  ^^^ will be returned"
  (declare (indent 1))
  (let ((last-var (let ((last (car (last varlist))))
                    (if (atom last)
                        last
                      (car last)))))
    `(let ,varlist
       (prog1 ,last-var
         ,@body))))

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

;; 顺序应当是不重要的.
(require 'shynur-elisp)    ; (find-file-other-window "./shynur-elisp.el")
(require 'shynur-tmp)      ; (find-file-other-window "./shynur-tmp.el")
(require 'shynur-org)      ; (find-file-other-window "./shynur-org.el")
(require 'shynur-abbrev)   ; (find-file-other-window "./shynur-abbrev.el")
(require 'shynur-server)   ; (find-file-other-window "./shynur-server.el")
(require 'shynur-cc)       ; (find-file-other-window "./shynur-cc.el")
(require 'shynur-kbd)      ; (find-file-other-window "./shynur-kbd.el")
(require 'shynur-sh)       ; (find-file-other-window "./shynur-sh.el")
(require 'shynur-yas)      ; (find-file-other-window "./shynur-yas.el")
(require 'shynur-profile)  ; (find-file-other-window "./shynur-profile.el")
(require 'shynur-startup)  ; (find-file-other-window "./shynur-startup.el")
(require 'shynur-ui)       ; (find-file-other-window "./shynur-ui.el")
(require 'shynur-lib)      ; (find-file-other-window "./shynur-lib.el")

(provide 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; End:
