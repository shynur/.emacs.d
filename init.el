;; -*- lexical-binding: t; -*-

(use-package use-package
  :custom
  (use-package-always-defer t))

(use-package package
  :custom
  (package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
		      ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
		      ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/"))))

(use-package cus-edit
  :custom
  (custom-file (locate-user-emacs-file "custom.el"))
  :config
  (when (file-exists-p custom-file)
    (load custom-file))
  ;;(add-hook 'kill-emacs-query-functions 'custom-prompt-customize-unsaved-options)  ; 连 xterm-mouse-mode 都要询问是否记住, 太啰嗦!
  )

(use-package diff-mode
  :mode "/.git/COMMIT_EDITMSG\\'")

(use-package term/xterm
  :custom
  (xterm-set-window-title t))

(use-package page-break-lines
  :ensure t
  :config
  (global-page-break-lines-mode))

(use-package mwheel
  :config
  (push .25 mouse-wheel-scroll-amount)  ; 一次滚动 25% 屏幕
  )

(use-package font-lock
  :after faces
  :config
  (set-face-italic 'font-lock-keyword-face t))

(use-package modus-themes
  :custom
  (modus-themes-italic-constructs t))

(use-package custom
  :config
  (when (display-graphic-p)
    (setopt custom-enabled-themes '(modus-vivendi))))

(use-package treesit
  :custom
  (treesit-font-lock-level 4))

(use-package facemenu
  :config
  (facemenu-update))

(use-package menu-bar
  :config
  (keymap-global-unset "<menu-bar> <file> <new-file>")
  (keymap-global-unset "<menu-bar> <file> <open-file>")
  (keymap-global-unset "<menu-bar> <file> <dired>")
  (keymap-global-unset "<menu-bar> <file> <kill-buffer>")
  (keymap-global-unset "<menu-bar> <file> <save-buffer>")
  (keymap-global-unset "<menu-bar> <file> <write-file>")
  (keymap-global-unset "<menu-bar> <file> <new-window-below>")
  (keymap-global-unset "<menu-bar> <file> <exit-emacs>")
  (keymap-global-unset "<menu-bar> <file> <new-window-on-right>")
  (keymap-global-unset "<menu-bar> <edit> <undo>")
  (keymap-global-unset "<menu-bar> <edit> <cut>")
  (keymap-global-unset "<menu-bar> <edit> <copy>")
  (keymap-global-unset "<menu-bar> <edit> <paste>")
  (keymap-global-unset "<menu-bar> <edit> <clear>")
  (keymap-global-unset "<menu-bar> <edit> <mark-whole-buffer>")
  (keymap-global-unset "<menu-bar> <edit> <i-search> <isearch-forward>")
  (keymap-global-unset "<menu-bar> <edit> <i-search> <isearch-backward>")
  (keymap-global-unset "<menu-bar> <edit> <replace> <query-replace>")
  (keymap-global-unset "<menu-bar> <edit> <replace> <query-replace-regexp>")
  (keymap-global-unset "<menu-bar> <edit> <goto> <go-to-line>")
  (keymap-global-unset "<menu-bar> <edit> <goto> <beg-of-buf>")
  (keymap-global-unset "<menu-bar> <edit> <goto> <end-of-buf>")
  (keymap-global-unset "<menu-bar> <edit> <execute-extended-command>")
  (keymap-global-unset "<menu-bar> <options> <cua-mode>")
  (keymap-global-unset "<menu-bar> <options> <mule> <toggle-input-method>")
  (keymap-global-unset "<menu-bar> <options> <showhide> <size-indication-mode>")
  (keymap-global-unset "<menu-bar> <options> <showhide> <line-number-mode>")
  (keymap-global-unset "<menu-bar> <options> <showhide> <column-number-mode>")
  (keymap-global-unset "<menu-bar> <buffer> <next-buffer>")
  (keymap-global-unset "<menu-bar> <buffer> <previous-buffer>")
  (keymap-global-unset "<menu-bar> <buffer> <select-named-buffer>")
  (keymap-global-unset "<menu-bar> <tools> <shell-commands> <shell>")
  (keymap-global-unset "<menu-bar> <tools> <gnus>")
  (keymap-global-unset "<menu-bar> <tools> <rmail>")
  (keymap-global-unset "<menu-bar> <tools> <compose-mail>")
  (keymap-global-unset "<menu-bar> <tools> <browse-web>")
  (keymap-global-unset "<menu-bar> <tools> <calendar>")
  (keymap-global-unset "<menu-bar> <help-menu> <emacs-tutorial>")
  (keymap-global-unset "<menu-bar> <help-menu> <emacs-tutorial-language-specific>")
  (keymap-global-unset "<menu-bar> <help-menu> <emacs-news>")
  (keymap-global-unset "<menu-bar> <help-menu> <emacs-manual-bug>")
  (keymap-global-unset "<menu-bar> <help-menu> <send-emacs-bug-report>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe> <describe-mode>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe> <describe-key-1>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe> <describe-function>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe> <describe-variable>")
  (keymap-global-unset "<menu-bar> <help-menu> <emacs-manual>")
  (keymap-global-unset "<menu-bar> <help-menu> <more-manuals> <other-manuals>")
  (keymap-global-unset "<menu-bar> <help-menu> <more-manuals> <man>")
  (keymap-global-unset "<menu-bar> <help-menu> <more-manuals> <order-emacs-manuals>")
  (keymap-global-unset "<menu-bar> <help-menu> <getting-new-versions>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe-copying>")
  (keymap-global-unset "<menu-bar> <help-menu> <describe-no-warranty>")
  (keymap-global-unset "<menu-bar> <help-menu> <about-emacs>")
  (keymap-global-unset "<menu-bar> <help-menu> <about-gnu-project>"))

(use-package emacs
  :custom
  (inhibit-startup-screen t)
  (initial-major-mode 'markdown-mode)
  (initial-scratch-message "")

  (default-input-method "chinese-py")

  (x-stretch-cursor t)

  (echo-keystrokes 0.1)

  (tab-always-indent t)

  :config
  (eval '(setq inhibit-startup-echo-area-message "shynur"))
  (eval '(setq inhibit-startup-echo-area-message "root"))

  (prefer-coding-system 'utf-8-unix)

  (when (daemonp)
    (add-hook 'window-setup-hook
	      (lambda ()
		(apply
		 'make-process
                 :name "Emacs Daemon 启动时用来显示通知的临时载体"
                 :command `(,(file-name-concat invocation-directory "emacs")
                            "-Q" "--basic-display" "--iconic"
                            "-eval" ,(prin1-to-string
				      '(let ((--title "《 Emacs 已在后台启动 》")
					     (--body  "守护进程将会常驻后台哦～\n\\t\\t         Good Luck!"))
					 (pcase system-type
					   ('windows-nt
					    (w32-notification-notify
					     :title --title
					     :body  --body
					     :level 'info))
					   (_
					    (require 'notifications)
                                            (notifications-notify
					     :title --title
					     :body  --body
					     :transient t)))))
                            "-eval" "(sleep-for 0.1)"
                            "-funcall" "kill-emacs")
                 :noquery t
		 `(,@(when (and (eq system-type 'windows-nt)
				(seq-some (lambda (tz)
					    (string= (format-time-string "%Z") tz))
					  ["中国标准时间" "CST"]))
		       '(:coding 'chinese-gbk)))))))

  (when (and (eq system-type 'windows-nt)
	     (seq-some (lambda (tz)
		         (string= (format-time-string "%Z") tz))
		       ["中国标准时间" "CST"]))
    (setq file-name-coding-system 'chinese-gb18030))

  (setq frame-title-format `(""
                             default-directory "\t"
                             "🧹x" (:eval (number-to-string gcs-done)) "~" (:eval (number-to-string (round gc-elapsed))) "s\s"
                             "💾" (:eval ,(prog1 '#1=#:rss
					    (set '#1# 0)
                                            (add-hook 'post-gc-hook
						      (lambda ()
							(set '#1# (cl-loop for #2=#:rss = (let ((default-directory temporary-file-directory))
											    (alist-get 'rss (process-attributes (emacs-pid))))
                                                                           then (/ #2# 1024.0)
                                                                           for #3=#:ram-unit across "KMGTPEZ"
                                                                           when (< #2# 1024)
									   return (format "%.1f%ciB"
                                                                                          #2# #3#))))))) "\s"
                             "⏱️" (:eval (emacs-uptime "%h:%.2m:%.2s")) "\s"
                             (pixel-scroll-precision-mode
                              nil
                              ("🎹" (:eval (number-to-string num-input-keys)) "/" (:eval (number-to-string num-nonmacro-input-events))))))

  (setq icon-title-format '((:eval (mapconcat (lambda (buffer)
						(with-current-buffer buffer
						  (format "[%.4s]" (buffer-name))))
					      (delete-dups (mapcar (lambda (window)
								     (with-selected-window window
								       (current-buffer))) (window-list)))
					      "\s"))))
  )

(use-package help-mode
  :config
  (add-hook 'help-mode-hook (lambda ()
			      (display-line-numbers-mode -1))))

(use-package cc-mode
  :custom
  (c-tab-always-indent t)
  (add-hook 'c-mode-common-hook (lambda ()
                                  (c-toggle-comment-style -1))))

(use-package keymap
  :config
  (let ((#1=#:key-swapper (let ((#2=#:terminals-swapped ()))
			    (lambda (frame)
			      (unless (seq-contains ["/dev/tty"] (terminal-name))
				(unless (memq (frame-terminal) #2#)
				  (with-selected-frame frame
                                    (key-translate "[" "(")
                                    (key-translate "]" ")")
                                    (key-translate "(" "[")
                                    (key-translate ")" "]")
                                    (push (frame-terminal) #2#))))))))
    (add-hook 'after-make-frame-functions #1#)
    (unless (daemonp)
      (funcall #1# (selected-frame)))))

(use-package isearch
  :config
  (keymap-global-unset "C-r")
  (keymap-global-unset "C-M-r"))

(use-package swiper
  :ensure t)

(use-package ivy
  :ensure t
  :bind
  ("C-s" . (lambda ()
             (interactive)
             (dlet ((ivy-count-format "%d/%d ")
                   (ivy-height 6))
               (ivy-mode)
               (unwind-protect
                   (swiper)
                 (ivy-mode -1)))))
  :config
  (add-hook 'minibuffer-setup-hook (lambda ()
                                     "令 ivy 的 minibuffer 拥有自适应高度."
                                     (add-hook 'post-command-hook
					       (lambda ()
                                                 (when (bound-and-true-p ivy-mode)
                                                   (shrink-window (1+ ivy-height))))
                                               nil "buffer local")))
  :custom
  (ivy-on-del-error-function #'ignore))

(use-package rainbow-delimiters
  :ensure t)

(use-package company
  :ensure t)

(use-package ielm
  :config
  (add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'ielm-mode-hook 'company-mode))

(use-package prog-mode
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'prog-mode-hook (lambda ()
                              (unless (derived-mode-p 'lisp-data-mode 'scheme-mode)
				(electric-pair-local-mode))))
  (add-hook 'prog-mode-hook (lambda ()
                              (setq-local require-final-newline t)
                              (add-hook 'before-save-hook
					#'delete-trailing-whitespace
					nil "buffer local")))
  (add-hook 'prog-mode-hook 'company-mode))

(use-package text-mode
  :config
  (add-hook 'text-mode-hook (lambda ()
                              (setq-local require-final-newline t)
                              (add-hook 'before-save-hook
					#'delete-trailing-whitespace
					nil "buffer local"))))

(use-package delsel
  :config
  (delete-selection-mode))

(use-package tool-bar
  :if (display-graphic-p)
  :config
  (tool-bar-mode -1))

(use-package repeat
  :config
  (repeat-mode))

(use-package savehist
  :config
  (savehist-mode))

(use-package recentf
  :config
  (recentf-mode))

(use-package saveplace
  :config
  (save-place-mode))

(use-package fringe
  :custom
  (fringe-mode '(0 . nil)))

(use-package frame
  :config
  (modify-all-frames-parameters '((alpha . (80 . 55))
				  (height . 25)
				  (width . 80)
				  (top . 25)
				  (left . 1)))

  (blink-cursor-mode -1))

(use-package simple
  :config
  (column-number-mode)
  (line-number-mode -1)
  (size-indication-mode)
  :custom
  (indent-tabs-mode nil)
  (blink-matching-paren-highlight-offscreen t))

(use-package display-line-numbers
  :config
  (global-display-line-numbers-mode))

(use-package dockerfile-mode
  :ensure t)

(use-package csv-mode
  :ensure t)

(use-package git-modes
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package nginx-mode
  :ensure t)

(use-package rainbow-mode
  :ensure t)

(use-package sed-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package cmake-mode
  :ensure t)
