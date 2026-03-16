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
            #'custom-prompt-customize-unsaved-options))

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
