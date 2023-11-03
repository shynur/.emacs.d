;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; 一些日常使用的函数.

(defun shynur:open-file-with (file)
  (interactive "G")
  (let ((programs `(
                    ("edge"     "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
                    ("emacs-Q"  "emacs.exe" "-Q")
                    ("explorer" "runemacs.exe" "-Q" "--load" ,(expand-file-name (file-name-concat user-emacs-directory
                                                                                                  "scripts/explorer.elc")))
                    ("notepad"  "notepad.exe")
                    ("typora"   "D:/Progs/Typora/Typora.exe")
                    ("runemacs" "runemacs.exe")
                    )))
    (apply #'start-process
           "进程名 (瞎取一个)" nil
           `(,@(cdr (assoc-string (completing-read "用哪款软件打开?  "
                                                  (mapcar #'cl-first programs))
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

(defun shynur:school-week ()
  (interactive)
  (let (message-log-max)
    (apply #'message
           #("开学第%d周,还剩%d周😅"
             3 5 (face (bold
                        (:foreground "green")))
             9 11 (face (bold
                         (:foreground "red"))))
           (let ((开学第一天 "Mon, Sep 11, 2023")
                 (学期总周数 18))
             `(,#1=(1+ (/ (- (date-to-day (calendar-date-string (calendar-current-date)))
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
                   (run-with-idle-timer 10 nil
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
