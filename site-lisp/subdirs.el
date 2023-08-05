;;; -*- lexical-binding: t -*-

;;; Commentary:
;;
;; In ‘load-path’, after this directory should come certain of its
;; subdirectories.  Here we specify them:

(normal-top-level-add-to-load-path '("copilot.el/"
                                     "lsp-bridge/"
                                     ))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: t  ; 该文件按名查找.
;; End:
