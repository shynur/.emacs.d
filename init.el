;; -*- lexical-binding: t; -*-

(use-package package
  :config
  (setopt package-archives
	  '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
            ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")	  
	    ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/"))))

(use-package cus-edit
  :config
  (setopt custom-file (locate-user-emacs-file "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))
  ;(add-hook 'kill-emacs-query-functions 'custom-prompt-customize-unsaved-options)  ; 连 xterm-mouse-mode 都要询问是否记住, 太啰嗦!
  )

(use-package page-break-lines
  :ensure t
  :config
  (global-page-break-lines-mode))

(use-package mwheel
  :config
  (push 0.25 mouse-wheel-scroll-amount)  ; 一次滚动 25% 屏幕
  )

(use-package font-lock
  :after faces
  :config
  (set-face-italic 'font-lock-keyword-face t))

(use-package modus-themes
  :defer t
  :config
  (setopt modus-themes-italic-constructs t))

(use-package treesit
  :defer t
  :config
  (setopt treesit-font-lock-level 4))

(use-package facemenu
  :config
  (facemenu-update))

(use-package menu-bar
  :defer t
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
  :config
  (setopt inhibit-startup-screen t)
  (eval '(setq inhibit-startup-echo-area-message "shynur"))
  (eval '(setq inhibit-startup-echo-area-message "root"))

  (setopt initial-major-mode 'markdown-mode
	  initial-scratch-message "")

  (setopt default-input-method "chinese-py")

  (setopt x-stretch-cursor t)

  (setopt echo-keystrokes 0.1))

(use-package company
  :ensure t
  :defer t)

(use-package prog-mode
  :defer t
  :config
  (add-hook 'prog-mode-hook 'company-mode))

(use-package delsel
  :config
  (delete-selection-mode))

(use-package tool-bar
  :if (display-graphic-p)
  :defer t
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

(use-package frame
  :config
  (blink-cursor-mode -1))

(use-package simple
  :config
  (column-number-mode)
  (line-number-mode -1)
  (size-indication-mode)

  (setopt blink-matching-paren-highlight-offscreen t)
  )

(use-package display-line-numbers
  :config
  (global-display-line-numbers-mode))

(use-package dockerfile-mode
  :ensure t
  :defer t)

(use-package csv-mode
  :ensure t
  :defer t)

(use-package git-modes
  :ensure t
  :defer t)

(use-package go-mode
  :ensure t
  :defer t)

(use-package json-mode
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :defer t)

(use-package nginx-mode
  :ensure t
  :defer t)

(use-package rainbow-mode
  :ensure t
  :defer t)

(use-package sed-mode
  :ensure t
  :defer t)

(use-package typescript-mode
  :ensure t
  :defer t)

(use-package web-mode
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :defer t)

(use-package cmake-mode
  :ensure t
  :defer t)
