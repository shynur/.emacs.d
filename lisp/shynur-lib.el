;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; 一些日常使用的函数.

(defun shynur/reverse-characters (beginning end)
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

(defun shynur/propertize-as (beginning end same-as-where)
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


(provide 'shynur-lib)

;; Local Variables:
;; coding: utf-8-unix
;; End:
