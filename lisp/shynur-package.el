;;; -*- lexical-binding: t; -*-

;; See (info "(emacs) Package Installation")
;;
;;      Installed packages are automatically made available by Emacs
;;   in all subsequent sessions.  This happens at startup, before
;;   processing the init file but after processing the early init
;;   file.

(setq package-quickstart nil  ; 每次启动时 re-computing 而不是 使用 precomputed 的文件.
      ;; 相当于在 加载“init.el” 前 执行‘package-initialize’.
      package-enable-at-startup t)

;; 1. 其它 ELPA 中的包会依赖“gnu”中的包.
;; 2. “Melpa”滚动升级, 收录的包的数量最大.
;; 3. “Stable-melpa”依据源码的 tag (Git) 升级, 数量比“melpa”少, 因为很多包作者根本不打 tag.
;; 4. “Org”仅仅为了‘org-plus-contrib’这一个包, Org 重度用户使用.
;; 5. “Gnu-devel”收录“gnu”中的包的开发中版本 (类似于“melpa”与“stable-melpa”的关系).
;; 6. “Nongnu-devel”收录“nongnu”中的包的开发中版本.
(setq package-archives '(("gnu"    . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("nongnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/")
                         ("melpa"  . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")))

(setq package-archive-priorities '(;; “Gnu”应该和“melpa”同优先级, 从而默认选取二者中较新的 package.
                                   ("gnu"    . 1)
                                   ("nongnu" . 0)
                                   ("melpa"  . 1))
      package-menu-hide-low-priority t)

(setq package-check-signature nil)  ; 暂时不知道检查签名有什么用,先关了再说.

(setq package-selected-packages '(ivy
                                  sly
                                  dimmer
                                  swiper
                                  company
                                  helpful
                                  neotree
                                  transwin
                                  git-modes
                                  highlight
                                  on-screen
                                  which-key
                                  yaml-mode
                                  drag-stuff
                                  marginalia
                                  ascii-table
                                  doom-themes
                                  use-package
                                  indent-guide
                                  rainbow-mode
                                  all-the-icons
                                  doom-modeline
                                  markdown-mode
                                  page-break-lines
                                  company-quickhelp
                                  rainbow-delimiters
                                  highlight-parentheses))
;; 摘编自 <https://orgmode.org/elpa.html#installation>:
(ignore-errors  ; 电脑可能断网了.
  (package-refresh-contents))
(setq package-load-list '(all))
(dolist (feature package-selected-packages)
  (unless (package-installed-p feature)
    (ignore-errors  ; 电脑可能断网了.
      (package-install feature))))

(provide 'shynur-package)

;; Local Variables:
;; coding: utf-8-unix
;; End:
