;;; -*- lexical-binding: t; -*-

;;; Theme:

(require 'shynur-themes)   ; (find-file-other-window "./themes/shynur-themes.el")

(enable-theme 'modus-vivendi)

;;; Face (其实应该放到 theme 中去):

;; (为什么要用‘letrec’ -- 见 <https://emacs.stackexchange.com/a/77767/39388>.)
(letrec ((shynur--custom-set-faces
          (lambda ()
            ;; 摘编自 Centaur Emacs, 用于解决 字体 问题.
            (let* ((font       "Maple Mono SC NF-12:slant:weight=medium:width=normal:spacing")
                   (attributes (font-face-attributes font)                                   )
                   (family     (plist-get attributes :family)                                ))
              ;; Default font.
              (apply #'set-face-attribute
                     'default nil
                     attributes)
              ;; For all Unicode characters.
              (set-fontset-font t 'symbol
                                (font-spec :family "Segoe UI Symbol")
                                nil 'prepend)
              ;; Emoji 🥰.
              (set-fontset-font t 'emoji
                                (font-spec :family "Segoe UI Emoji")
                                nil 'prepend)
              ;; For Chinese characters.
              (set-fontset-font t '(#x4e00 . #x9fff)
                                (font-spec :family family)))
            (custom-set-faces
             '(cursor
               ((t . (:background "chartreuse")))
               nil
               "该face仅有‘:background’字段有效")
             '(tooltip
               ((t . ( :height     100
                       :background "dark slate gray"))))
             '(line-number
               ((t . ( :slant  italic
                       :weight light))))
             `(line-number-major-tick
               ((t . ( :foreground ,(face-attribute 'line-number :foreground)
                       :background ,(face-attribute 'line-number :background)
                       :slant      italic
                       :underline  t
                       :weight     light)))
               nil
               "指定倍数的行号;除此以外,还有‘line-number-minor-tick’实现相同的功能,但其优先级更低")
             '(line-number-current-line
               ((t . ( :slant  normal
                       :weight black))))
             '(window-divider
               ((t . (:foreground "SlateBlue4"))))
             '(indent-guide-face
               ((t . (:foreground "dark sea green"))))
             '(fill-column-indicator
               ((t . ( :background "black"
                       :foreground "yellow")))))
            (remove-hook 'server-after-make-frame-hook
                         shynur--custom-set-faces))))
  (add-hook 'server-after-make-frame-hook
            shynur--custom-set-faces))

;;; Frame:

;; 使 frame 根据 背景色的 亮暗, 让 face 自行选择对应的方案.
(setq frame-background-mode nil)

(tool-bar-mode -1)

(setq frame-resize-pixelwise t)

(with-eval-after-load 'frame
  (require 'transwin)
  (add-hook 'after-make-frame-functions
            (lambda (frame-to-be-made)
              (let ((inhibit-message t))
                (with-selected-frame frame-to-be-made
                  (transwin-ask 80))))))

;; 当最后一个 frame 关闭时, 存入它的 位置/尺寸;
;; 当桌面上没有 frame 时, 下一个打开的 frame 将使用那个被存入的 位置/尺寸.
(let ((shynur--size&position `(,(cons 'top 0) ,(cons 'left 0)
                               ,(cons 'width 0) ,(cons 'height 0)
                               ;; ‘fullscreen’放最后, 以覆盖‘width’&‘height’的设置.
                               ,(cons 'fullscreen nil)))
      shynur--size&position-stored?)
  (letrec ((shynur--size&position-getter (lambda ()
                                           (when shynur--size&position-stored?
                                             (dolist (parameter-value shynur--size&position)
                                               (set-frame-parameter nil (car parameter-value) (cdr parameter-value))))
                                           (remove-hook 'server-after-make-frame-hook shynur--size&position-getter)
                                           (   add-hook 'delete-frame-functions       shynur--size&position-setter)))
           (shynur--size&position-setter (lambda (frame-to-be-deleted)
                                           (when (length= (frames-on-display-list) 1)
                                             (dolist (parameter-value shynur--size&position)
                                               (setcdr parameter-value (frame-parameter frame-to-be-deleted (car parameter-value))))
                                             (setq shynur--size&position-stored? t)
                                             (remove-hook 'delete-frame-functions       shynur--size&position-setter)
                                             ;; 当需要调用该 lambda 表达式时, 必然没有除此以外的其它frame了,
                                             ;; 因此之后新建的 frame 必然是 server 弹出的, 所以此处无需使用‘after-make-frame-functions’.
                                             (   add-hook 'server-after-make-frame-hook shynur--size&position-getter)))))
    (add-hook 'server-after-make-frame-hook shynur--size&position-getter)))

;; 必须先设置 window divider 的参数!
(setq window-divider-default-places      'right-only  ; 横向 divider 可以用 mode line代替.
      window-divider-default-right-width 12)
(window-divider-mode)

;;; Window:

(setq window-resize-pixelwise t)

;;; [[package:melpa][dimmer]]
(dimmer-mode)

(setq window-min-height 4
      window-min-width  1)

;;; Mode Line:

;;; [[package:melpa][doom-modeline]]: [[package][all-the-icons]]
(setq doom-modeline-minor-modes t)
;; 即使当前窗口宽度很小, 也尽量显示所有信息.
(setq doom-modeline-window-width-limit nil)
;; 左侧 小竖条 (装饰品) 的 宽度.
(setq doom-modeline-bar-width 3)
;; 尽可能地窄.
(setq doom-modeline-height 1)
(doom-modeline-mode)

;; Face ‘mode-line-inactive’ for non-selected window’s mode line.
(setq mode-line-in-non-selected-windows t)

;;; Minibuffer & Echo Area:

(setq max-mini-window-height 0.3)

;; 由 输入 的 字符串 的 行数 决定如何 resize.
(setq resize-mini-windows t)

;; Trim 首尾的空行.
(setq resize-mini-frames #'fit-frame-to-buffer)

;;; Cursor:

(blink-cursor-mode -1)
;; 以下设置无效, 因为‘blink-cursor-mode’关掉了.
(setq blink-cursor-delay  0  ; Cursor 静止一段时间之后开始闪烁.
      blink-cursor-blinks 0  ; 闪烁次数
      blink-cursor-interval 0.5
      ;; 映射: ‘cursor-type’->光标黯淡时的造型.
      blink-cursor-alist '((box  . nil)
                           (bar  . box)
                           (hbar . bar)))

;; TUI下, 尽可能地 使 cursor 外形或特征 更加显著.
(setq visible-cursor t)

(setq cursor-type 'box
      ;; 在 non-selected window 中也 展示 cursor,
      ;; 但是 是 镂空的.
      cursor-in-non-selected-windows t)

;;; Scroll:

(pixel-scroll-precision-mode)

;; Scroll 以使 window 底端的 N 行呈现到顶端.
(setq next-screen-context-lines 5)

;; 无法再 scroll 时 就 停住, 而不是继续移动至 buffer 首/尾.
(setq scroll-error-top-bottom nil)

(setq scroll-margin 1
      ;; ‘scroll-margin’的上界.
      maximum-scroll-margin 0.5)

(setq-default scroll-bar-width 28)

(setq scroll-conservatively most-positive-fixnum
      ;; Minibuffer 永远 一行一行地 automatically scroll.
      scroll-minibuffer-conservatively t)

;;; Tooltip:

(with-eval-after-load 'tooltip
  ;; 暂时没啥好设置的.
  (setq tooltip-frame-parameters tooltip-frame-parameters))

(setq tooltip-delay       0
      tooltip-short-delay 0
      tooltip-hide-delay  most-positive-fixnum)

(tooltip-mode)

(provide 'shynur-ui)

;; Local Variables:
;; coding: utf-8-unix
;; End:
