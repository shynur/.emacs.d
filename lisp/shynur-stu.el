;;; -*- lexical-binding: t; -*-

;;; 外语学习:

;; 显示单词释义.
(setq holo-layer-python-command shynur/custom:python-path)
(with-eval-after-load 'holo-layer
  (setq holo-layer-enable-place-info t)
  ;; 重复调用是安全的.
  (holo-layer-enable))
(when (eq system-type 'gnu/linux)
  (require 'holo-layer nil t))

;;; 家庭作业:

;; ‘C-x r j s’ 跳转至作业文件夹.
(set-register ?s '(file . "d:/Desktop/schoolwork/"))

;;; CheatSheets:

(set-register ?o '(file . "d:/Desktop/.emacs.d/docs/Org-quickstart.org"))

(provide 'shynur-stu)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
