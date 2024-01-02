;;; -*- lexical-binding: t; -*-

;; See (info "(emacs) Package Installation")
;;
;;      Installed packages are automatically made available by Emacs
;;   in all subsequent sessions.  This happens at startup, before
;;   processing the init file but after processing the early init
;;   file.

(setopt package-quickstart nil  ; 每次启动时 re-computing 而不是 使用 precomputed 的文件.
        ;; 相当于在 加载“init.el” 前 执行‘package-initialize’.
        ;; 这其实是 默认行为.
        package-enable-at-startup t)

(shynur/custom:appdata/ package-user-dir /)

;; 设置 mirror 时会询问是否连接, 此时 Emacs 的 GUI 窗口甚至还没弹出来.
;; 干脆降低安全系数.
(setopt network-security-level 'low)
;; 1. 其它 ELPA 中的包会依赖“gnu”中的包.
;; 2. “Melpa”滚动升级, 收录的包的数量最大.
;; 3. “Stable-melpa”依据源码的 tag (Git) 升级, 数量比“melpa”少, 因为很多包作者根本不打 tag.
;; 4. “Org”仅仅为了‘org-plus-contrib’这一个包, Org 重度用户使用.
;; 5. “Gnu-devel”收录“gnu”中的包的开发中版本 (类似于“melpa”与“stable-melpa”的关系).
;; 6. “Nongnu-devel”收录“nongnu”中的包的开发中版本.
(setopt package-archives '(
                           ("gnu"    . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                           ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
                           ("melpa"  . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                           ))

(setopt package-archive-priorities '(;; “Gnu” 应该和 “melpa” 同优先级, 从而默认选取二者中较新的 package.
                                     ("gnu"    . 1)
                                     ("nongnu" . 0)
                                     ("melpa"  . 1))
        package-menu-hide-low-priority t)

(setopt package-check-signature nil)  ; 暂时不知道检查签名有什么用, 先关了再说.

(setopt package-selected-packages '(ivy
                                    sly
                                    embark
                                    swiper
                                    company
                                    helpful
                                    htmlize
                                    keycast
                                    neotree
                                    git-modes
                                    on-screen
                                    yaml-mode
                                    yasnippet
                                    drag-stuff
                                    marginalia
                                    powershell
                                    ascii-table
                                    textile-mode
                                    rainbow-mode
                                    all-the-icons
                                    doom-modeline
                                    markdown-mode
                                    page-break-lines
                                    company-quickhelp
                                    rainbow-delimiters
                                    highlight-parentheses  ; 动态彩虹括号.
                                    )
        package-load-list '(all))
;; 摘编自 <https://orgmode.org/elpa.html#installation>:
(ignore-errors  ; 电脑可能没联网.
  (package-upgrade-all)  ; 该函数能顺便 ‘package-refresh-contents’.
  (package-install-selected-packages t)
  ;; (package-autoremove)  ; 我记得这好像需要手动确认.
  )

(require 'shynur-elpa)  ; (find-file-other-window "../local-elpa/shynur-elpa.el")

(provide 'shynur-package)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
