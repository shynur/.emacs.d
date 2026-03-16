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
  (add-hook 'kill-emacs-query-functions
            'custom-prompt-customize-unsaved-options))

(use-package emacs
  :config
  (setopt inhibit-startup-screen t)
  (setq inhibit-startup-echo-area-message "shynur")
  (setq inhibit-startup-echo-area-message "root")

  (setopt initial-major-mode 'markdown-mode
	  initial-scratch-message "")

  (setopt default-input-method "chinese-py")

  (setopt x-stretch-cursor t)

  (setopt echo-keystrokes 0.1)
  )

(use-package company
  :ensure t
  :defer t)

(use-package prog-mode
  :config
  (add-hook 'prog-mode-hook 'company-mode))

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

(use-package frame
  :config
  (blink-cursor-mode -1))

(use-package simple
  :config
  (column-number-mode)
  (line-number-mode -1)
  (size-indication-mode))

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
