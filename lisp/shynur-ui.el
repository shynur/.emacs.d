;;; -*- lexical-binding: t; -*-

;;; Theme:

(require 'shynur-themes)   ; (find-file-other-window "./themes/shynur-themes.el")
(enable-theme 'modus-vivendi)

;;; Face (其实应该放到 theme 中去):

(add-hook 'emacs-startup-hook  ; 在调用 ‘frame-notice-user-settings’ 前运行.
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
             ;; (我把 ‘indent-guide’ 删了.)
             ;; (setq indent-guide-recursive t
             ;;       indent-guide-char "\N{BOX DRAWINGS LIGHT VERTICAL}")
             '(indent-guide-face
               ((t . (:foreground "dark sea green"))))
             '(fill-column-indicator
               ((t . ( :background "black"
                       :foreground "yellow")))))))

;;; Frame:

;; 使 frame 根据 背景色的 亮暗, 让 face 自行选择对应的方案.
(setq frame-background-mode nil)

(setq frame-resize-pixelwise t)

;; 透明
(add-to-list 'default-frame-alist
             `(,(pcase system-type
                  ("I don’t know how to test whether the platform supports this parameter!" 'alpha-background)
                  (_ 'alpha))
               . 75))

;; 当最后一个 frame 关闭时, 存入它的 位置/尺寸;
;; 当桌面上没有 frame 时, 下一个打开的 frame 将使用那个被存入的 位置/尺寸.
;; +-----------------------------------------+
;; |‘stored?’ => nil.  Daemon is initialized.|
;; |‘getter’ is in ‘server-*-make-*-hook’.   |
;; +---------------------+-------------------+
;;                       |
;;  No frame on desktop. | Let’s _make_ one.
;;                       V                          Because ‘stored?’ is t, the frame to make will
;; +------------------------------------------+     use the parameters of the last frame which is deleted
;; |Run ‘getter’ in ‘server-*-make-*-hook’:   |<-------------------------------------------+
;; |‘getter’ itself is removed from the hook; |     when Emacs runs ‘server-*-make-*-hook’.|
;; |‘setter’ is in ‘delete-*-functions’.      |                                            |
;; +------------------------------------------+                                            |
;;  Let’s _make_ more frames.                                                              |
;;  Either ‘getter’ or ‘setter’ won’t run.                                                 |
;;           |                                                                             |
;;           | Let’s _delete_ one frame.                          No frame on desktop now. | Let’s _make_ one.
;;           V                                                                             |
;; +-------------------------------------+                             +-------------------+-----------------+
;; |Run ‘setter’ in ‘delete-*-functions’:| Let’s _delete_ the last one |Run ‘setter’ in ‘delete-*-functions’:|
;; |nothing will happend because the     +---------------------------->|frame parameters will be stored;     |
;; |frame to be deleted is not the only  |     frame on the desktop.   |now ‘stored?’ => t; ‘setter’ itself  |
;; |one frame on the desktop.            |                             |is removed from the hook; ‘getter’ is|
;; ++------------------------------------+                             |in ‘server-*-make-*-hook’            |
;;  |                                   ^                              +-------------------------------------+
;;  |Let’s _delete_ frames until there’s|
;;  +-----------------------------------+
;;   only one frame left on the desktop.
(add-hook 'server-after-make-frame-hook
          (let ((shynur/ui:frame-size&position `(,(cons 'top 0) ,(cons 'left 0) ,(cons 'width 0) ,(cons 'height 0)
                                                 ;; ‘fullscreen’放最后, 以覆盖‘width’&‘height’.
                                                 ,(cons 'fullscreen nil)))
                shynur/ui:frame-size&position-stored?)
            (letrec ((shynur/ui:frame-size&position-getter (lambda ()
                                                             (when shynur/ui:frame-size&position-stored?
                                                               (dolist (parameter-value shynur/ui:frame-size&position)
                                                                 (set-frame-parameter nil (car parameter-value) (cdr parameter-value))))
                                                             (remove-hook 'server-after-make-frame-hook shynur/ui:frame-size&position-getter)
                                                             (   add-hook 'delete-frame-functions       shynur/ui:frame-size&position-setter)))
                     (shynur/ui:frame-size&position-setter (lambda (frame-to-be-deleted)
                                                             (when (length= (frames-on-display-list) 1)
                                                               (dolist (parameter-value shynur/ui:frame-size&position)
                                                                 (setcdr parameter-value (frame-parameter frame-to-be-deleted (car parameter-value))))
                                                               (setq shynur/ui:frame-size&position-stored? t)
                                                               (remove-hook 'delete-frame-functions       shynur/ui:frame-size&position-setter)
                                                               ;; 当需要调用该 lambda 表达式时, 必然没有除此以外的其它frame了,
                                                               ;; 因此之后新建的 frame 必然是 server 弹出的, 所以此处无需使用‘after-make-frame-functions’.
                                                               (   add-hook 'server-after-make-frame-hook shynur/ui:frame-size&position-getter)))))
              shynur/ui:frame-size&position-getter)))

;; 必须先设置 window divider 的参数!
(setq window-divider-default-places      'right-only  ; 横向 divider 可以用 mode line代替.
      window-divider-default-right-width 12)
(window-divider-mode)

;;; Frame Title:

(setq frame-title-format (prog1 '("" default-directory "  " shynur/ui:frame-title)
                           (defvar shynur/ui:frame-title "21st GC (4s total): 742.3M VM, 3:20 runtime, 455/546 key/event"
                             "执行 垃圾回收 的 次数 (它们总共花费 4 秒): (截至这一次 垃圾回收 时) 估算 Emacs 虚拟内存的占用, 小时:分钟 运行时间, number of key-sequences/input-events processed")
                           (let ((shynur/ui:frame-title-updater (lambda ()
                                                                  (setq shynur/ui:frame-title (format-spec "%N GC (%ts total): %M VM, %T runtime, %k key/event"
                                                                                                           `((?N . ,(format "%d%s"
                                                                                                                            gcs-done
                                                                                                                            (pcase (mod gcs-done 10)
                                                                                                                              (1 "st")
                                                                                                                              (2 "nd")
                                                                                                                              (3 "rd")
                                                                                                                              (_ "th"))))
                                                                                                             (?t . ,(round gc-elapsed))
                                                                                                             (?M . ,(progn
                                                                                                                      (eval-when-compile
                                                                                                                        (require 'cl-lib))
                                                                                                                      (cl-loop for shynur--memory = (memory-limit) then (/ shynur--memory 1024.0)
                                                                                                                               for shynur--memory-unit across "KMGT"  ; 可能占用 1 TiB 内存吗?
                                                                                                                               when (< shynur--memory 1024)
                                                                                                                               return (format "%.1f%c"
                                                                                                                                              shynur--memory
                                                                                                                                              shynur--memory-unit))))
                                                                                                             (?T . ,(emacs-uptime "%h:%.2m"))
                                                                                                             ;; 鼠标滚轮 也属于 key-sequences/input-events,
                                                                                                             ;; 但在这里它 (特别是开启像素级滚动) 显然不合适 :(
                                                                                                             (?k . ,(format "%d/%d"
                                                                                                                            num-input-keys
                                                                                                                            num-nonmacro-input-events))))))))
                             (funcall shynur/ui:frame-title-updater)
                             (add-hook 'post-gc-hook
                                       shynur/ui:frame-title-updater)))
      icon-title-format (progn
                          (defvar shynur/ui:icon-title nil)
                          `(:eval (prog1 'shynur/ui:icon-title
                                    (setq shynur/ui:icon-title (mapconcat ,(lambda (buffer)
                                                                             "以 “[buffer1] [buffer2] ... [buffer3]” 的方式 不重复地 列出 frame 中的 window 显示的 buffer."
                                                                             (with-current-buffer buffer
                                                                               (format "[%s]"
                                                                                       (buffer-name)))) (delete-dups (mapcar (lambda (window)
                                                                                                                               (with-selected-window window
                                                                                                                                 (current-buffer))) (window-list)))
                                                                                       "\s"))))))

;;; Menu Bar:

(keymap-global-unset "<menu-bar> <file> <open-file>")
(keymap-global-unset "<menu-bar> <file> <kill-buffer>")
(keymap-global-unset "<menu-bar> <file> <make-tab>")
(keymap-global-unset "<menu-bar> <file> <close-tab>")
(keymap-global-unset "<menu-bar> <file> <exit-emacs>")
(keymap-global-unset "<menu-bar> <file> <delete-this-frame>")
(keymap-global-unset "<menu-bar> <file> <make-frame>")
(keymap-global-unset "<menu-bar> <file> <new-window-below>")
(keymap-global-unset "<menu-bar> <file> <new-window-on-right>")
(keymap-global-unset "<menu-bar> <file> <one-window>")
(keymap-global-unset "<menu-bar> <file> <save-buffer>")

(keymap-global-unset "<menu-bar> <edit> <undo>")
(keymap-global-unset "<menu-bar> <edit> <undo-redo>")
(keymap-global-unset "<menu-bar> <edit> <cut>")
(keymap-global-unset "<menu-bar> <edit> <copy>")
(keymap-global-unset "<menu-bar> <edit> <paste>")
(keymap-global-unset "<menu-bar> <edit> <mark-whole-buffer>")

(keymap-global-unset "<menu-bar> <options> <cua-mode>")
(keymap-global-unset "<menu-bar> <options> <save>")
(keymap-global-unset "<menu-bar> <options> <customize> <customize-saved>")

(keymap-global-unset "<menu-bar> <buffer> <select-named-buffer>")

(keymap-global-unset "<menu-bar> <tools> <gnus>")

(keymap-global-unset "<menu-bar> <help-menu> <emacs-manual>")
(keymap-global-unset "<menu-bar> <help-menu> <getting-new-versions>")
(keymap-global-unset "<menu-bar> <help-menu> <describe-copying>")
(keymap-global-unset "<menu-bar> <help-menu> <describe-no-warranty>")
(keymap-global-unset "<menu-bar> <help-menu> <about-emacs>")
(keymap-global-unset "<menu-bar> <help-menu> <about-gnu-project>")

;;; Tool Bar:

(setq tool-bar-style 'both)

(tool-bar-mode -1)

;;; Tab Line

(setq tab-line-close-button-show nil
      tab-line-new-button-show nil
      ;; 关闭 tab-line-name 之间默认的空格.
      tab-line-separator "")
;; Tab line 就是为了方便使用鼠标而存在的, 直接用鼠标点就行了.
(setq tab-line-switch-cycling nil)

(global-tab-line-mode)

;;; Window:

(setq window-resize-pixelwise t)

(setq window-min-height 4
      window-min-width  1)

(global-hl-line-mode)

;;; Text Area:

;; 除了当前选中的 window, 还 高亮 non-selected window 的 active region.
(setq highlight-nonselected-windows t)

;;; Fringe:

(setq fringe-mode '(0 . nil))  ; Right-only.

(setq display-line-numbers-type t  ; 启用绝对行号.
      ;; 开启 relative/visual 行号时, 当前行仍然显示 absolute 行号.
      display-line-numbers-current-absolute t)
(setq-default display-line-numbers-widen t)  ; 无视 narrowing, 行号从 buffer 的起始点计算.
(setq-default display-line-numbers-width nil)  ; 动态改变为行号预留的列数.
(setq display-line-numbers-grow-only nil)      ; 行号占用的列数可以动态减少.

(setq line-number-display-limit nil  ; 当 buffer 的 size 太大时是否启用行号, 以节约性能.
      ;; 单行太长也会消耗性能用于计算行号, 因此,
      ;; 如果当前行附近的行的平均宽度大于该值, 则不计算行号.
      line-number-display-limit-width most-positive-fixnum)
;; 每 10 行就用 ‘line-number-major-tick’ 高亮一次行号.
(setq display-line-numbers-major-tick 10)
(global-display-line-numbers-mode t)

;; 若开启, buffer 尾行之后的区域的右流苏区域会显示密集的刻度线.
(setq-default indicate-empty-lines nil)
(setq overflow-newline-into-fringe t)

;;; Scroll Bar:

(setq scroll-bar-mode 'right)

;; 滚动条落至底部 (overscrolling) 时的行为.
(setq scroll-bar-adjust-thumb-portion nil)

(setq-default scroll-bar-width 28)

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

(column-number-mode)
;; 从 1 开始计数.
(setq mode-line-position-column-format '(" " "C%C" " "))

;; Face ‘mode-line-inactive’ for non-selected window’s mode line.
(setq mode-line-in-non-selected-windows t)

;;; End of Line
(setq eol-mnemonic-unix " LF "
      eol-mnemonic-mac  " CR "
      eol-mnemonic-dos  " CRLF "
      eol-mnemonic-undecided " ?EOL ")

;;; Display Time Mode
(require 'time)
(setq display-time-day-and-date t
      display-time-24hr-format nil)
(setq display-time-mail-icon (find-image '(
                                           (:type xpm :file "shynur-letter.xpm" :ascent center)
                                           (:type pbm :file "letter.pbm" :ascent center)
                                           ))
      ;; 使用由 ‘display-time-mail-icon’ 指定的 icon, 如果确实找到了这样的 icon 的话;
      ;; 否则 使用 Unicode 图标.
      display-time-use-mail-icon display-time-mail-icon

      ;; 是否检查以及如何检查邮箱, 采用默认策略 (i.e., 系统决定).
      display-time-mail-file nil
      ;; 该目录下的所有非空文件都被当成新送达的邮件.
      display-time-mail-directory nil)
(setq display-time-default-load-average 0  ; 显示过去 1min 的平均 CPU 荷载.
      ;; 当 CPU 荷载 >= 0 时, 显示 CPU 荷载.
      display-time-load-average-threshold 0)
(setq display-time-interval 60)
(display-time-mode)

;;; Display Battery Mode
(setq battery-mode-line-format "[%p%%] ")
(setq battery-update-interval 300)  ; 秒钟.
(display-battery-mode)

;;; Minibuffer & Echo Area:

(setq max-mini-window-height 0.3)

;; 由 输入 的 字符串 的 行数 决定如何 resize.
(setq resize-mini-windows t)

;; Trim 首尾的空行.
(setq resize-mini-frames #'fit-frame-to-buffer)

;;; Mouse:

(setq mouse-fine-grained-tracking nil)

;;; Cursor:

(setq-default cursor-type 'box
              ;; 在 non-selected window 中也 展示 cursor,
              ;; 但是 是 镂空的.
              cursor-in-non-selected-windows t)
(setq x-stretch-cursor t)  ; 在 TAB 字符上拉长 cursor.

(blink-cursor-mode -1)
;; 以下设置无效, 因为‘blink-cursor-mode’关掉了.
(setq blink-cursor-delay  0  ; Cursor 静止一段时间之后开始闪烁.
      blink-cursor-blinks 0  ; 闪烁次数.
      blink-cursor-interval 0.5
      ;; 映射: ‘cursor-type’ -> 光标黯淡时的造型.
      blink-cursor-alist '((box  . nil)
                           (bar  . box)
                           (hbar . bar)))

;; TUI 下, 尽可能地 使 cursor 外形或特征 更加显著.
(setq visible-cursor t)

;;; 果冻光标
;; GNU/Linux
(setq holo-layer-python-command shynur/custom:python-path)
(setq holo-layer-enable-cursor-animation t
      holo-layer-cursor-alpha 140
      holo-layer-cursor-animation-duration 170
      holo-layer-cursor-animation-interval 30
      holo-layer-cursor-animation-type "jelly")
(require 'holo-layer nil t)
(with-eval-after-load 'holo-layer
  (when (eq system-type 'gnu/linux)
    (holo-layer-enable)))
;; MS-Windows
(with-eval-after-load 'pop-select
  (let (shynur--cursor-animation?)

    (add-hook 'window-scroll-functions
              (lambda (_window _position)
                (setq shynur--cursor-animation? nil)))
    (advice-add (prog1 'pixel-scroll-precision
                  (require 'pixel-scroll)) :after
                (lambda (&rest _)
                  (setq shynur--cursor-animation? nil)))

    (advice-add (prog1 'recenter-top-bottom
                  (require 'window)) :after
                (lambda (&rest _)
                  (setq shynur--cursor-animation? t)))

    (add-hook 'post-command-hook
              (let ((shynur--cursor-color     "Cursor Color")
                    (shynur--background-color "Default Background Color")
                    (shynur--cursor-animation-color-R 0)
                    (shynur--cursor-animation-color-G 0)
                    (shynur--cursor-animation-color-B 0))
                (lambda ()
                  (unless (and (eq shynur--cursor-color     (face-background  'cursor))
                               (eq shynur--background-color (face-background 'default)))
                    (setq shynur--cursor-color     (face-background  'cursor)
                          shynur--background-color (face-background 'default))
                    (let ((shynur--cursor-animation-color-RGB (cl-mapcar (let* ((ratio 0.5)
                                                                                (1-ratio (- 1 ratio)))
                                                                           (lambda (cursor-color default-color)
                                                                             "按照 ratio:(1-ratio) 的比例混合光标颜色和背景色."
                                                                             (floor (* (+ (*   ratio  cursor-color)
                                                                                          (* 1-ratio default-color))
                                                                                       255.99999999999997))))
                                                                         (color-name-to-rgb shynur--cursor-color)
                                                                         (color-name-to-rgb shynur--background-color))))
                      (setq shynur--cursor-animation-color-R (cl-first  shynur--cursor-animation-color-RGB)
                            shynur--cursor-animation-color-G (cl-second shynur--cursor-animation-color-RGB)
                            shynur--cursor-animation-color-B (cl-third  shynur--cursor-animation-color-RGB))))
                  (if-let ((window-absolute-pixel-position (when shynur--cursor-animation?
                                                             (window-absolute-pixel-position)))
                           (line-pixel-height (line-pixel-height)))
                      (ignore-error 'error  ; 错误信息: Specified window is not displaying the current buffer
                        (pop-select/beacon-animation
                         (car window-absolute-pixel-position) (if header-line-format
                                                                  (- (cdr window-absolute-pixel-position)
                                                                     line-pixel-height)
                                                                (cdr window-absolute-pixel-position))
                         (if (eq cursor-type 'bar)
                             1
                           (if-let ((glyph (let ((point (point)))
                                             (when (< point (point-max))
                                               (aref (font-get-glyphs (font-at point)
                                                                      point (1+ point)) 0)))))
                               (aref glyph 4)
                             (window-font-width))) line-pixel-height
                         180 100
                         shynur--cursor-animation-color-R shynur--cursor-animation-color-G shynur--cursor-animation-color-B
                         ;; 排除大约是单个半角字符的距离:
                         24))
                    (setq shynur--cursor-animation? t)))))))
(when (and (eq system-type 'windows-nt)
           (or (display-graphic-p)
               (daemonp)))
  (require 'pop-select "pop_select.dll" t))

(setq cursor-in-echo-area nil)

;;; Click:

(setq double-click-fuzz 3  ; 双击时, 两次 button-down 之间 允许 的 位移/像素.
      double-click-time 400)

;;; Scroll:

(setq jit-lock-defer-time 0.3  ; Scroll 之后 延迟 fontify.
      ;; Scroll 时, 假定滚过的文本有 default face, 从而避免 fontify 它们.  当那些滚过的文本的 size 不一致时, 可能导致终点位置有偏差.
      fast-but-imprecise-scrolling t
      redisplay-skip-fontification-on-input t
      ;; TUI 下, recenter 时不 redraw frame, 可能造成屏幕有少许显示错误.  所以 此处仅考虑 TTY.
      recenter-redisplay 'tty)

(pixel-scroll-precision-mode)
(when (and (string= shynur/custom:truename "谢骐")
           (string= shynur/custom:os "MS-Windows 11"))
  (run-at-time nil 2000
               (lambda ()
                 "重启 ‘SmoothScroll’."
                 ;; P.S. 我的 ‘SmoothScroll’ 配置:
                 ;;
                 ;;          Step size [px] _500_
                 ;;     Animation time [ms] _400_
                 ;; Acceleration delta [ms] _999_
                 ;;   Acceleration max  [x] __1__
                 ;; Tail to head ratio  [x] __3__
                 ;;
                 ;; [V] Enable for all apps by default
                 ;; [V] Animation easing
                 (start-process "Restart SmoothScroll" nil
                                "pwsh"
                                "-File" (expand-file-name (file-name-concat user-emacs-directory
                                                                            "etc/restart-SmoothScroll.ps1"))))))
(add-hook 'post-command-hook
          (let ((shynur--gc-cons-percentage gc-cons-percentage)
                (shynur--gc-cons-threshold  gc-cons-threshold ))
            (lambda ()
              (if (eq this-command 'pixel-scroll-precision)
                  (unless (eq last-command 'pixel-scroll-precision)
                    (setq shynur--gc-cons-percentage gc-cons-percentage
                          shynur--gc-cons-threshold  gc-cons-threshold
                          gc-cons-percentage 1.0
                          gc-cons-threshold  most-positive-fixnum))
                (when (eq last-command 'pixel-scroll-precision)
                  (setq gc-cons-percentage shynur--gc-cons-percentage
                        gc-cons-threshold  shynur--gc-cons-threshold))))))

;; Scroll 以使 window 底端的 N 行呈现到顶端.
(setq next-screen-context-lines 5)

;; 无法再 scroll 时 就 停住, 而不是继续移动至 buffer 首/尾.
(setq scroll-error-top-bottom nil)

(setq scroll-margin 1
      ;; ‘scroll-margin’的上界.
      maximum-scroll-margin 0.5)

(setq scroll-conservatively most-positive-fixnum
      ;; Minibuffer 永远 一行一行地 automatically scroll.
      scroll-minibuffer-conservatively t)

;; Scroll 时 通过 高亮 即将 滚走/来 的 篇幅 以 提示 滚动方向.
;; (这个包被我删了.)
(setq on-screen-inverse-flag t
      on-screen-highlight-method 'shadow
      on-screen-delay 0.4)

;;; Horizontal
(setq hscroll-margin 5
      hscroll-step 1)

;;; Tooltip:

;; (setq tooltip-frame-parameters ...) 还没想好要设置什么.

(setq tooltip-delay       0
      tooltip-short-delay 0
      tooltip-hide-delay  most-positive-fixnum)

(tooltip-mode)

;;; Dialog Box:

(setq use-dialog-box t
      use-file-dialog t)

;; 在 GTK+ 的 file-chooser-dialog 中显示隐藏文件.
(setq x-gtk-show-hidden-files t)

;;; Sound:

(when (fboundp 'set-message-beep)
  (set-message-beep nil))  ; 调节 beep 的声音种类.

;;; Render:

(setq no-redraw-on-reenter t)

(provide 'shynur-ui)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
