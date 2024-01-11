;;; -*- lexical-binding: t; -*-

;;; 外语学习:

;; 显示单词释义.)
(setq holo-layer-python-command shynur/custom:python-path)
(with-eval-after-load 'holo-layer
  (setq holo-layer-enable-place-info t)
  ;; 重复调用是安全的.
  (holo-layer-enable))
(when (eq system-type 'gnu/linux)
  (require 'holo-layer nil t))

;;; 家庭作业:

(with-eval-after-load 'filesets
  (push `("家庭作业"
          . ((:tree "d:/Desktop/schoolwork/" "")
             (:tree-max-level ,most-positive-fixnum))) filesets-data)
  (filesets-rebuild-this-submenu "家庭作业"))

(push '我的学习 menu-bar-final-items)
(global-set-key [menu-bar 我的学习] `("我的学习"
                                      . ,(make-sparse-keymap "我的学习")))

(global-set-key [menu-bar 我的学习 编辑‘shynur-stu.el’] `("编辑‘shynur-stu.el’"
                                                            . ,(lambda ()
                                                                 (interactive)
                                                                 (find-file "~/.emacs.d/lisp/shynur-stu.el")
                                                                 (widen)
                                                                 (goto-char (point-min))
                                                                 (search-forward (regexp-quote "(push '我的学习 menu-bar-final-items)"))
                                                                 (recenter-top-bottom 0))))

(global-set-key [menu-bar 我的学习 计算机网络] `("计算机网络"
                                                 . ,(make-sparse-keymap "计算机网络")))
(global-set-key [menu-bar 我的学习 计算机网络 微课堂] `("微课堂"
                                                        . ,(lambda ()
                                                             (interactive)
                                                             (start-process "学习 计算机网络" nil "C:/Program Files/bilibili/哔哩哔哩.exe")
                                                             (w32-notification-close (w32-notification-notify :title "看到了 EP25" :body " "))
                                                             (delete-frame))))
(global-set-key [menu-bar 我的学习 计算机网络 《网络是怎样连接的》] `("《网络是怎样连接的》"
                                                                      . ,(lambda ()
                                                                           (interactive)
                                                                           (browse-url-default-browser "file://localhost/D:/Desktop/ToRead/HowNetworksWork.pdf")
                                                                           (w32-notification-close (w32-notification-notify :title "读到了 6.3.3" :body " "))
                                                                           (delete-frame))))

(global-set-key [menu-bar 我的学习 计算机组成与设计] `("计算机组成与设计"
                                                       . ,(lambda ()
                                                            (interactive)
                                                            (start-process "学习 计算机组成与设计" nil "C:/Program Files/bilibili/哔哩哔哩.exe")
                                                            (w32-notification-close (w32-notification-notify :title "看到了 [22] 5:18" :body " "))
                                                            (delete-frame))))

(global-set-key [menu-bar 我的学习 CAD] `("CAD"
                                          . ,(make-sparse-keymap "CAD")))
(global-set-key [menu-bar 我的学习 CAD SolidWorks] `("SolidWorks"
                                                     . ,(lambda ()
                                                          (interactive)
                                                          (start-process "运行虚拟机 win-CAD" nil "D:/Progs/VirtualBox/VirtualBoxVM.exe" "--startvm" "win-CAD")
                                                          (start-process "学习 SOLIDWORKS" nil "C:/Program Files/bilibili/哔哩哔哩.exe")
                                                          (w32-notification-close (w32-notification-notify :title "看到了 第七课 8:45" :body " ")))))
(global-set-key [menu-bar 我的学习 CAD AutoCAD\ VBA] `("AutoCAD VBA"
                                                       . ,(lambda ()
                                                            (interactive)
                                                            (start-process "学习 AutoCAD" nil "C:/Program Files/bilibili/哔哩哔哩.exe")
                                                            (shynur:open-file-with "D:/Desktop/SchoolWork/CAD/Autocad VBA初级教程/Autocad VBA初级教程(2020修订版).docx" "word")
                                                            (w32-notification-close (w32-notification-notify :title "看到了 第5课" :body " ")))))

(provide 'shynur-stu)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: t
;; End:
