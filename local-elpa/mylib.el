;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; 一些日常使用的函数.

(defun shynur:open-file-with (file &optional prog)
  (interactive "G")
  (let ((programs `(
                    ("edge.exe"     "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
                    ("emacs-Q"  "runemacs.exe" "-Q")
                    ("explorer.exe" "runemacs.exe" "-Q" "--basic-display" "--iconic"
                     "--load" ,(let ((tmp-file-path (file-name-concat temporary-file-directory #1="shynur-mylib-open-file-with-explorer.el")))
                                 (with-temp-file (file-name-concat temporary-file-directory #1#)
                                   (insert "
(make-frame-invisible nil \"force\")
(process-lines-ignore-status \"explorer.exe\" (string-replace \"/\" \"\\\\\" (elt argv 0)))
(kill-emacs)  ; 不要换成“--kill”参数, 否则会先读取当前目录的 local variables 再退出."))
                                 tmp-file-path))
                    ("notepad.exe"  "notepad.exe")
                    ("term"     "runemacs.exe" "-Q" "--basic-display" "--iconic"
                     "--batch" "--eval" "(shell-command \"start \\\"C:/Program Files/WindowsApps/Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe/WindowsTerminal.exe\\\"\")")
                    ("typora"   "D:/Progs/Typora/Typora.exe")
                    ("runemacs.exe" "runemacs.exe")
                    ("word.exe" "runemacs.exe" "-Q" "--basic-display" "--iconic"
                     "--load" ,(let ((tmp-file-path (file-name-concat temporary-file-directory #2="shynur-mylib-open-file-with-MSword.el")))
                                 (with-temp-file (file-name-concat temporary-file-directory #2#)
                                   (insert "
(make-frame-invisible nil \"force\")
(process-lines-ignore-status \"C:/Program Files/Microsoft Office/root/Office16/WINWORD.EXE\" (string-replace \"/\" \"\\\\\" (elt argv 0)))
(kill-emacs)  ; 不要换成“--kill”参数, 否则会先读取当前目录的 local variables 再退出."))
                                 tmp-file-path))
                    )))
    (apply #'start-process
           "进程名 (瞎取一个)" nil
           `(,@(cdr (assoc-string (or prog
                                      (completing-read "用哪款软件打开?  "
                                                       (mapcar #'cl-first programs)))
                                  programs))
             ,(encode-coding-string file 'chinese-gb18030)))))

(defun shynur:reverse-characters (beginning end)
  "将选中的区域的所有字符倒序排列"
  (declare (pure   nil)
           (indent nil)
           (interactive-only nil)
           (side-effect-free nil)
           (completion (lambda (_symbol current-buffer)
                         "read-only的缓冲区肯定编辑不了"
                         (with-current-buffer current-buffer
                           (not buffer-read-only)))))
  (interactive "r")
  (insert (nreverse (delete-and-extract-region beginning end))))

(defun shynur:propertize-as (beginning end same-as-where)
  "将选中区域的字符串的property设置得和指定的point所指处的一样"
  (declare (interactive-only t)
           (side-effect-free nil)
           (completion (lambda (_symbol current-buffer)
                         "read-only的缓冲区肯定改不了字符的property"
                         (with-current-buffer current-buffer
                           (not buffer-read-only)))))
  (interactive "r\nnSet region’s properties same as the character at point: ")
  (set-text-properties beginning end
                       (text-properties-at same-as-where)))

(defun shynur:desemi (bor eor)
  (interactive "*r")
  (let ((this-buffer (current-buffer)))
    (with-temp-buffer
      (insert-buffer-substring-no-properties this-buffer
                                             bor eor)
      (with-current-buffer this-buffer
        (delete-region bor eor))

      (goto-char 1)
      (while (re-search-forward "，\\|、" nil t)
        (replace-match ", " nil nil))

      (goto-char 1)
      (while (re-search-forward "。" nil t)
        (replace-match ".  " nil nil))

      (goto-char 1)
      (while (re-search-forward "？" nil t)
        (replace-match "?  " nil nil))

      (goto-char 1)
      (while (re-search-forward "：" nil t)
        (replace-match ": " nil nil))

      (goto-char 1)
      (while (re-search-forward "；" nil t)
        (replace-match "; " nil nil))

      (goto-char 1)
      (while (re-search-forward "（\\(.*?\\)）" nil t)
        (replace-match " (\\1) " nil nil))

      (goto-char 1)
      (while (re-search-forward "[[:blank:]]*\\([[:digit:]]+\\)[[:blank:]]*" nil t)
        (replace-match " \\1" nil nil))

      (goto-char 1)
      (while (re-search-forward "[[:blank:]]*\\([[:alpha:]-.]+\\)[[:blank:]]*" nil t)
        (replace-match " \\1" nil nil))

      (let ((tmp-buffer (current-buffer)))
        (with-current-buffer this-buffer
          (insert-buffer-substring-no-properties tmp-buffer))))))

(defun shynur:school-week (from-date)
  "Usage:
  ‘(shynur:school-week \"\")’,
  ‘(shynur:school-week \"日\")’,
  ‘(shynur:school-week \"月 日\")’,
  或 ‘(shynur:school-week \"年 月 日\")’."
  (interactive "M")
  (setq from-date (mapcar #'string-to-number (split-string from-date)))  ; “()”, “(日)”, “(月, 日)”, 或 “(年 月 日)”.
  (let (message-log-max)
    (apply #'message
           #("开学第%d周,还剩%d周😅"
             3 5 (face (bold
                        (:foreground "green")))
             9 11 (face (bold
                         (:foreground "red"))))
           (let ((开学第一天 "Mon, Sep 11, 2023")
                 (学期总周数 18))
             `(,#1=(1+ (/ (- (date-to-day (calendar-date-string (let ((month-day-year (calendar-current-date)))
                                                                  (pcase (length from-date)
                                                                    (1 (setf (cl-second month-day-year) (cl-first  from-date)))
                                                                    (2 (setf (cl-first  month-day-year) (cl-first  from-date)
                                                                             (cl-second month-day-year) (cl-second from-date)))
                                                                    (3 (setf (cl-third  month-day-year) (cl-first  from-date)
                                                                             (cl-first  month-day-year) (cl-second from-date)
                                                                             (cl-second month-day-year) (cl-third  from-date))))
                                                                  month-day-year)))
                             (date-to-day 开学第一天))
                          7))
                   ,(- 学期总周数 #1#))))))

(defun shynur:transient-notify (&rest args)
  (pcase system-type
    ('windows-nt
     (advice-add 'w32-notification-notify :before
                 (let* ((balloon-emitting-frame (let (before-make-frame-hook
                                                      window-system-default-frame-alist initial-frame-alist default-frame-alist
                                                      after-make-frame-functions server-after-make-frame-hook)
                                                  (make-frame-on-display (symbol-name initial-window-system)
                                                                         '((visibility . nil)))))
                        (balloon (with-selected-frame balloon-emitting-frame
                                   (apply #'w32-notification-notify
                                          args)))
                        (balloon-lock (make-mutex))
                        (message-closer (lambda ()
                                          (with-selected-frame balloon-emitting-frame
                                            (w32-notification-close balloon)
                                            (setq balloon "closed")
                                            (let (delete-frame-functions
                                                  after-delete-frame-functions)
                                              (delete-frame))))))
                   (run-with-idle-timer (max idle-update-delay 10) nil
                                        (lambda ()
                                          (with-mutex balloon-lock
                                            (unless (stringp balloon)
                                              (funcall message-closer)))))
                   (lambda (&rest _)
                     (advice-remove 'w32-notification-notify "message-closer")
                     (with-mutex balloon-lock
                       (unless (stringp balloon)
                         (funcall message-closer))))) '((name . "message-closer"))))
    (_
     (require 'notifications)
     (apply #'notifications-notify
            :transient t
            args))))  ;; title body

(provide 'mylib)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
