;;; -*- lexical-binding: t; -*-

;; See (info "(emacs) Custom Themes")
;;
;;      Setting or saving Custom themes actually works by customizing
;;   ‘custom-enabled-themes’.  Its value is a list of Custom theme
;;   names (as Lisp symbols, e.g., ‘tango’).
;;
;;      If settings from two different themes overlap, the theme occurring
;;   earlier in ‘custom-enabled-themes’ takes precedence.
;;
;;      You can enable a specific Custom theme by typing [M-x ‘load-theme’].
;;   This prompts for a theme name, _loads_ the theme from the theme file,
;;   and _enables_ it.  If a theme file has been loaded before, you can
;;   enable the theme without loading its file by typing [M-x ‘enable-theme’].
;;   To disable a Custom theme, type [M-x ‘disable-theme’].

(setq custom-theme-directory (file-name-concat user-emacs-directory
                                               "lisp/themes/")
      ;; 难不成我还有空去看未知主题的源码, 分析它安全不安全??
      custom-safe-themes t)

(require-theme 'modus-vivendi-theme)

(provide 'shynur-themes)

;; Local Variables:
;; coding: utf-8-unix
;; End:
