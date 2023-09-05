;;; -*- lexical-binding: t; -*-

;;; Runtime Environment

(keymap-set special-event-map "<sigusr1>"
            (lambda ()
              "SIGUSR1 handler"
              (interactive)
              (message "Caught signal %S" last-input-event)))
(keymap-set special-event-map "<sigusr2>"
            (lambda ()
              "SIGUSR2 handler"
              (interactive)
              (message "Caught signal %S" last-input-event)))
;; 测试一下: (signal-process (emacs-pid) 'sigusr1)

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

(defmacro shynur/lambda-signed-as (function &rest body)
  "暂不支持 autoload 函数."
  (declare (indent 1))
  (let ((&shynur/lambda-signed-as:funtion (gensym "shynur/")))
    `(let* ((,&shynur/lambda-signed-as:funtion ,function)
            (arglist (help-function-arglist ,&shynur/lambda-signed-as:funtion)))
       (eval (list
              'lambda arglist
              ,(let ((first-form (cl-first body)))
                 (if (stringp first-form)
                     first-form
                   `(documentation ,&shynur/lambda-signed-as:funtion)))
              (interactive-form ,&shynur/lambda-signed-as:funtion)
              (apply #'list
                     'dlet `((shynur/lambda-signed-as:args (list ,@(cl-remove-if (lambda (symbol)
                                                                                  (pcase symbol
                                                                                    ('&optional t)
                                                                                    ('&rest     t))) arglist))))
                     ',body))
             lexical-binding))))

;; 顺序应当是不重要的.
(require 'shynur-elisp)    ; (find-file-other-window "./shynur-elisp.el")
(require 'shynur-tmp)      ; (find-file-other-window "./shynur-tmp.el")
(require 'shynur-general)  ; (find-file-other-window "./shynur-general.el")
(require 'shynur-org)      ; (find-file-other-window "./shynur-org.el")
(require 'shynur-tex)      ; (find-file-other-window "./shynur-tex.el")
(require 'shynur-abbrev)   ; (find-file-other-window "./shynur-abbrev.el")
(require 'shynur-server)   ; (find-file-other-window "./shynur-server.el")
(require 'shynur-cc)       ; (find-file-other-window "./shynur-cc.el")
(require 'shynur-kbd)      ; (find-file-other-window "./shynur-kbd.el")
(require 'shynur-sh)       ; (find-file-other-window "./shynur-sh.el")
(require 'shynur-game)     ; (find-file-other-window "./shynur-game.el")
(require 'shynur-edit)     ; (find-file-other-window "./shynur-edit.el")
(require 'shynur-profile)  ; (find-file-other-window "./shynur-profile.el")
(require 'shynur-startup)  ; (find-file-other-window "./shynur-startup.el")
(require 'shynur-ui)       ; (find-file-other-window "./shynur-ui.el")
(require 'shynur-lib)      ; (find-file-other-window "./shynur-lib.el")

;;; After Loading Init File

;; default
(setq inhibit-default-init nil)

;; abbrevs
;; 上一页中已经设置过了.

(provide 'shynur-init)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
