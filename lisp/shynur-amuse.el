;;; -*- lexical-binding: t; -*-

;;; Hanoi:

(setq hanoi-use-faces nil)  ; 不要使用彩色动画, 因为看起来很鬼畜.

;;; 贪吃蛇:

(setq snake-score-file (expand-file-name (file-name-concat user-emacs-directory
                                                           "var/snake-scores.txt")))

;;; 俄罗斯方块:

(setq tetris-score-file (expand-file-name (file-name-concat user-emacs-directory
                                                            "var/tetris-scores.txt")))

;;; 生命游戏:

(setopt life-step-time 0.2)

(provide 'shynur-amuse)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
