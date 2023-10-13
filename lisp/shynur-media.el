;;; -*- lexical-binding: t; -*-

;;; 图片:

;; 居然没有 ‘image-mode-hook’, 简直逆天!  只能用下面这个作为 work-around 了.
(add-hook 'image-mode-new-window-functions
          (lambda (_)
            (display-line-numbers-mode -1)))

;;; 视频:


;;; PDF:


;;; 音频:


(provide 'shynur-media)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
