;;; -*- lexical-binding: t -*-

;;; Commentary:
;;
;; In ‘load-path’, after this directory should come certain of its
;; subdirectories.  Here we specify them:

(let ((default-directory (file-name-concat user-emacs-directory
                                           "shynur-elpa/")))
  (normal-top-level-add-to-load-path '(
                                       "holo-layer"
                                       )))

(provide 'shynur-elpa)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
