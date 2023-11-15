;;; -*- lexical-binding: t; -*-

 '(overline-margin 0
                   nil ()
                   "上划线的高度+宽度")
 '(mouse-highlight t
                   nil ()
                   "当鼠标位于clickable位置时,高亮此处的文本")

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
               "该 face 仅有 ‘:background’ 字段有效")
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
             ;; ;; 我把 ‘indent-guide’ 删了.
             ;; (setq indent-guide-recursive t
             ;;       indent-guide-char "\N{BOX DRAWINGS LIGHT VERTICAL}")
             '(indent-guide-face
               ((t . (:foreground "dark sea green"))))
             '(fill-column-indicator
               ((t . ( :inherit shadow
                       :height  unspecified  ; 使其跟随整体缩放.
                       :background "black"
                       :foreground "yellow")))))))

;;; Frame:

;; 默认位置 (显示器相关)
(add-to-list 'default-frame-alist '(left  . 301))
(add-to-list 'default-frame-alist '(width . 66))
(add-to-list 'default-frame-alist '(top    . 121))
(add-to-list 'default-frame-alist '(height . 26))

;; 将 frame 恢复到 默认 尺寸和位置.
(keymap-global-set "C-c z"
                   (lambda ()
                     (interactive)
                     (set-frame-parameter nil 'fullscreen nil)
                     (let-alist default-frame-alist
                       (set-frame-position nil .left .top)
                       (set-frame-size nil .width .height))))

;; 使 frame 根据 背景色的 亮暗, 让 face 自行选择对应的方案.
(setopt frame-background-mode nil)

(setopt frame-resize-pixelwise t)

;; 透明
(add-to-list 'default-frame-alist
             `(,(pcase system-type
                  ("TODO: Dunno how to test whether the platform supports this parameter." 'alpha-background)
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
                                                               ;; MS-Windows 上的 “最小化窗口” 似乎就只是把窗口挪到屏幕之外, 所以得先把它挪回来.
                                                               (make-frame-visible frame-to-be-deleted)
                                                               (dolist (parameter-value shynur/ui:frame-size&position)
                                                                 (setcdr parameter-value (frame-parameter frame-to-be-deleted (car parameter-value))))
                                                               (setq shynur/ui:frame-size&position-stored? t)
                                                               (remove-hook 'delete-frame-functions       shynur/ui:frame-size&position-setter)
                                                               ;; 当需要调用该 lambda 表达式时, 必然没有除此以外的其它frame了,
                                                               ;; 因此之后新建的 frame 必然是 server 弹出的, 所以此处无需使用‘after-make-frame-functions’.
                                                               (   add-hook 'server-after-make-frame-hook shynur/ui:frame-size&position-getter)))))
              shynur/ui:frame-size&position-getter)))
;; TODO: If there is an invisible frame ...

(setopt window-divider-default-places      'right-only  ; 横向 divider 可以用 mode line代替.
      window-divider-default-right-width 12)
(window-divider-mode)

;;; Frame Title:

(setq frame-title-format `(""
                           default-directory "\t"
                           "🧹x" (:eval (number-to-string gcs-done))
                           "~" (:eval (number-to-string (round gc-elapsed))) "s "
                           "💾" (:eval (prog1 'shynur/emacs:rss
                                         ,(put 'shynur/emacs:rss :test-times 0)
                                         ,(add-hook 'post-gc-hook
                                                    (lambda ()
                                                      (when (not (eq last-command 'pixel-scroll-precision))
                                                        (put 'shynur/emacs:rss :test-times -1))))
                                         (put 'shynur/emacs:rss :test-times (1+ (get 'shynur/emacs:rss :test-times)))
                                         ;; 每查询一定量的次数才更新, 从而减少 ‘process-attributes’ 的调用次数以提高性能.
                                         (when (zerop (mod (get 'shynur/emacs:rss :test-times) 50))
                                           (funcall ',(lambda ()
                                                        (eval-when-compile (require 'cl-lib))
                                                        ;; 将 ‘shynur/emacs:rss’ 设为形如 “823.1MiB” 这样的字符串.
                                                        (set 'shynur/emacs:rss (cl-loop for shynur--memory = (let ((default-directory temporary-file-directory))
                                                                                                               ;; 这里算的是实际物理内存, 若要算虚拟内存, 请用 ‘memory-limit’.
                                                                                                               (alist-get 'rss (process-attributes (emacs-pid)))) then (/ shynur--memory 1024.0)
                                                                                                               for shynur--memory-unit across "KMGTPEZ"
                                                                                                               when (< shynur--memory 1024) return (format "%.1f%ciB"
                                                                                                                                                           shynur--memory
                                                                                                                                                           shynur--memory-unit))))))))
                           "⏱️" (:eval (emacs-uptime "%h:%.2m")) " "
                           ;; 鼠标滚轮 也属于 key-sequences/input-events, 但在这里它 (特别是开启像素级滚动) 显然不合适.
                           ;; 将 CAR 上的 t 改为 nil 以关闭该功能.
                           (t ("" "🎹" (:eval (number-to-string num-input-keys)) "/" (:eval (number-to-string num-nonmacro-input-events)))))
      icon-title-format `((:eval (prog1 #1='#:icon-title  ; 相当于一次性的 frame local variable, 因为 每个 frame 的 icon-title 是不一样的.
                                   (set #1# (mapconcat ',(lambda (buffer)
                                                           "以 “[buffer1] [buffer2] ...” 的方式 (限定宽度) 不重复地 列出 frame 中正在显示的 buffer."
                                                           (with-current-buffer buffer
                                                             (format "[%.5s]"
                                                                     (buffer-name))))
                                                       (delete-dups (mapcar ',(lambda (window)
                                                                                (with-selected-window window
                                                                                  (current-buffer)))
                                                                            (window-list)))
                                                       "\s"))))))

;;; Menu Bar:

(keymap-global-unset "<menu-bar> <file> <close-tab>")
(keymap-global-unset "<menu-bar> <file> <delete-this-frame>")
(keymap-global-unset "<menu-bar> <file> <exit-emacs>")
(keymap-global-unset "<menu-bar> <file> <kill-buffer>")
(keymap-global-unset "<menu-bar> <file> <make-frame>")
(keymap-global-unset "<menu-bar> <file> <make-tab>")
(keymap-global-unset "<menu-bar> <file> <new-window-below>")
(keymap-global-unset "<menu-bar> <file> <new-window-on-right>")
(keymap-global-unset "<menu-bar> <file> <one-window>")
(keymap-global-unset "<menu-bar> <file> <open-file>")
(keymap-global-unset "<menu-bar> <file> <save-buffer>")

(keymap-global-unset "<menu-bar> <edit> <copy>")
(keymap-global-unset "<menu-bar> <edit> <cut>")
(keymap-global-unset "<menu-bar> <edit> <mark-whole-buffer>")
(keymap-global-unset "<menu-bar> <edit> <paste>")
(keymap-global-unset "<menu-bar> <edit> <undo-redo>")
(keymap-global-unset "<menu-bar> <edit> <undo>")

(keymap-global-unset "<menu-bar> <options> <cua-mode>")
(keymap-global-unset "<menu-bar> <options> <customize> <customize-saved>")
(keymap-global-unset "<menu-bar> <options> <save>")
(keymap-global-unset "<menu-bar> <options> <transient-mark-mode>")
(keymap-global-unset "<menu-bar> <options> <highlight-paren-mode>")

(keymap-global-unset "<menu-bar> <buffer> <select-named-buffer>")

(keymap-global-unset "<menu-bar> <tools> <browse-web>")
(keymap-global-unset "<menu-bar> <tools> <gnus>")

(keymap-global-unset "<menu-bar> <help-menu> <about-emacs>")
(keymap-global-unset "<menu-bar> <help-menu> <about-gnu-project>")
(keymap-global-unset "<menu-bar> <help-menu> <describe-copying>")
(keymap-global-unset "<menu-bar> <help-menu> <describe-no-warranty>")
(keymap-global-unset "<menu-bar> <help-menu> <emacs-manual>")
(keymap-global-unset "<menu-bar> <help-menu> <getting-new-versions>")
(keymap-global-unset "<menu-bar> <help-menu> <more-manuals> <order-emacs-manuals>")

;;; Tool Bar:

(setq tool-bar-style 'both)

(tool-bar-mode -1)

;;; Tab Line

(setq tab-line-close-button-show nil
      tab-line-new-button-show nil
      ;; 关闭 tab-line-name 之间默认的空格.
      tab-line-separator "")
;; Tab line 就是为了方便使用鼠标而存在的, 直接用鼠标点就行了.
(setopt tab-line-switch-cycling nil)
(setq-default tab-line-format `(:eval (mapcar ',(prog1 (lambda (buffer-tab-line-name)
                                                         (concat (if (get-buffer buffer-tab-line-name)
                                                                     (with-current-buffer buffer-tab-line-name
                                                                       (all-the-icons-icon-for-buffer))
                                                                   "") buffer-tab-line-name))
                                                  (require 'all-the-icons))
                                              (tab-line-format))))

(global-tab-line-mode)

;;; Window:

(setopt window-resize-pixelwise t)

(setopt window-min-height 4
        window-min-width  1)

(global-hl-line-mode)

;;; Text Area:

;; 除了当前选中的 window, 还 高亮 non-selected window 的 active region.
(setopt highlight-nonselected-windows t)

;; 渲染成对的单引号时, 尽可能使用 ‘curve’ 这种样式, 退而求此次地可以使用 `grave' 这种样式.
(setopt text-quoting-style nil)

;;; Fringe:

(set-fringe-mode '(0 . nil))  ; Right-only.

(setopt display-line-numbers-type t  ; 启用绝对行号.
        ;; 开启 relative/visual 行号时, 当前行仍然显示 absolute 行号.
        display-line-numbers-current-absolute t)
(setopt display-line-numbers-widen t  ; 无视 narrowing, 行号从 buffer 的起始点计算.
        ;; 动态改变为行号预留的列数.
        display-line-numbers-width nil
        ;; 行号占用的列数可以动态减少.
        display-line-numbers-grow-only nil)

(setopt line-number-display-limit nil  ; 当 buffer 的 size 太大时是否启用行号, 以节约性能.
        ;; 单行太长也会消耗性能用于计算行号, 因此,
        ;; 如果当前行附近的行的平均宽度大于该值, 则不计算行号.
        line-number-display-limit-width most-positive-fixnum)
;; 每 10 行就用 ‘line-number-major-tick’ 高亮一次行号.
(setopt display-line-numbers-major-tick 10)
(global-display-line-numbers-mode t)

;; 若开启, buffer 尾行之后的区域的右流苏区域会显示密集的刻度线.
(setopt indicate-empty-lines nil)
(setopt overflow-newline-into-fringe t)

;; 启用 word-wrap 时在换行处显示 down-arrow.
(setopt visual-line-fringe-indicators '(nil down-arrow))

;; 控制是否在 fringe 所在的区域上显示首尾指示符 (window 的四个边角区域).
(setopt indicate-buffer-boundaries nil)

;;; Scroll Bar:

(setopt scroll-bar-mode 'right)

;; 滚动条落至底部 (overscrolling) 时的行为.
(setopt scroll-bar-adjust-thumb-portion nil)

(setq-default scroll-bar-width 28)

;;; Mode Line:

;;; [[package:melpa][doom-modeline]]: [[package][all-the-icons]]
(setopt doom-modeline-minor-modes t)
;; 即使当前窗口宽度很小, 也尽量显示所有信息.
(setopt doom-modeline-window-width-limit nil)
;; 左侧 小竖条 (装饰品) 的 宽度.
(setopt doom-modeline-bar-width 3)
;; 尽可能地窄.
(setopt doom-modeline-height 1)
(doom-modeline-mode)

(size-indication-mode)  ; 在 mode line 上显示 buffer 大小.
(setq mode-line-column-line-number-mode-map ())  ; 使某些可点击文本不作出应答.

(line-number-mode -1)  ; Mode line 上不要显示行号, 因为 window 左边缘已经显示行号了.
;; 从 1 开始计数.
(setopt mode-line-position-column-format '(" C%C ")
        doom-modeline-column-zero-based nil)
(column-number-mode)



;; Face ‘mode-line-inactive’ for non-selected window’s mode line.
(setopt mode-line-in-non-selected-windows t)

;;; End of Line
(setopt eol-mnemonic-unix " LF "
        eol-mnemonic-mac  " CR "
        eol-mnemonic-dos  " CRLF "
        eol-mnemonic-undecided " ?EOL ")

;;; Display Time Mode
(require 'time)
(setopt display-time-day-and-date t
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
(setopt display-time-default-load-average 0  ; 显示过去 1min 的平均 CPU 荷载.
        ;; 当 CPU 荷载 >= 0 时, 显示 CPU 荷载.
        display-time-load-average-threshold 0)
(setopt display-time-interval 60)
(display-time-mode)
(advice-add 'display-time-next-load-average  :before-until ; 使可点击文本 (CPU 负荷) 不作出应答.
            (lambda ()
              (and (called-interactively-p 'any)
                   (when (listp last-command-event)
                     (eq (car last-command-event) 'mouse-2)))))

;;; Display Battery Mode
(setopt battery-mode-line-format "[%p%%] ")
(setopt battery-update-interval 300)  ; 秒钟.
(display-battery-mode)

;;; Minibuffer & Echo Area:

(setopt max-mini-window-height 0.3)

;; 由 输入 的 字符串 的 行数 决定如何 resize.
(setopt resize-mini-windows t)

;; Trim 首尾的空行.
(setopt resize-mini-frames #'fit-frame-to-buffer)

;;; Mouse:

(setq mouse-fine-grained-tracking nil)

(setopt display-hourglass t  ; When Emacs is busy, 将鼠标指针显示为 漏斗.
        ;; When Emacs is busy, 立刻将鼠标指针显示为漏斗.
        hourglass-delay 0)

;; 输入文本时不需要隐藏鼠标指针, 因为可以使用 ‘mouse-avoidance-mode’.
(setopt make-pointer-invisible nil)
(setopt mouse-avoidance-animation-delay 0.05)
(setopt mouse-avoidance-threshold  2  ; >=2
        mouse-avoidance-nudge-var  1  ; >=1
        mouse-avoidance-nudge-dist 2)
(mouse-avoidance-mode 'animate)

;;; Cursor:

(setopt cursor-type 'box
        ;; 在 non-selected window 中也 展示 cursor,
        ;; 但是 是 镂空的.
        cursor-in-non-selected-windows t)
(setopt x-stretch-cursor t)  ; 在 TAB 字符上拉长 cursor.

(blink-cursor-mode -1)
;; 以下设置无效, 因为‘blink-cursor-mode’关掉了.
(setopt blink-cursor-delay  0  ; Cursor 静止一段时间之后开始闪烁.
        blink-cursor-blinks 0  ; 闪烁次数.
        blink-cursor-interval 0.5
        ;; 映射: ‘cursor-type’ -> 光标黯淡时的造型.
        blink-cursor-alist '((box  . nil)
                             (bar  . box)
                             (hbar . bar)))

;; TUI 下, 尽可能地 使 cursor 外形或特征 更加显著.
(setopt visible-cursor t)

;;; 果冻光标
;; GNU/Linux
(setq holo-layer-python-command shynur/custom:python-path)
(setq holo-layer-enable-cursor-animation t
      holo-layer-cursor-alpha 140
      holo-layer-cursor-animation-duration 170
      holo-layer-cursor-animation-interval 30
      holo-layer-cursor-animation-type "jelly")
(with-eval-after-load 'holo-layer
  ;; 重复调用是安全的.
  (holo-layer-enable))
(when (eq system-type 'gnu/linux)
  (require 'holo-layer nil t))
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

(setopt double-click-fuzz 3  ; 双击时, 两次 button-down 之间 允许 的 位移/像素.
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
(setopt next-screen-context-lines 5)

;; 无法再 scroll 时 就 停住, 而不是继续移动至 buffer 首/尾.
(setopt scroll-error-top-bottom nil)

(setopt scroll-margin 1
        ;; ‘scroll-margin’的上界.
        maximum-scroll-margin 0.5)

(setq scroll-conservatively most-positive-fixnum
      ;; Minibuffer 永远 一行一行地 automatically scroll.
      scroll-minibuffer-conservatively t)

;; Scroll 时 通过 高亮 即将 滚走/来 的 篇幅 以 提示 滚动方向.
;; (仅在翻阅 ‘*Completions*’ buffer 的候选词时启用.)
(setopt on-screen-inverse-flag t
        on-screen-highlight-method 'shadow
        on-screen-delay 0.4)
(add-hook 'completion-list-mode-hook #'on-screen-mode)

;; 若非 nil, 则 scroll 时 (e.g., ‘C-v’) 保持 point 在屏幕上的位置 (有点像打字机), 但这样会扯坏 region.
(setopt scroll-preserve-screen-position nil)

;;; Horizontal
(setopt hscroll-margin 5
        hscroll-step 1)

;;; Tooltip:
(require 'tooltip)

(require 'let-alist)
(let-alist tooltip-frame-parameters
  "让 compiler 闭嘴.")

(setopt tooltip-delay       0
        tooltip-short-delay 0
        tooltip-hide-delay  most-positive-fixnum)

(tooltip-mode)

;;; Dialog Box:

(setopt use-dialog-box t
        use-file-dialog t)

;; 在 GTK+ 的 file-chooser-dialog 中显示隐藏文件.
(setq x-gtk-show-hidden-files t)

;;; Sound:

(when (fboundp 'set-message-beep)
  (set-message-beep nil))  ; 调节 beep 的声音种类.

;;; Render:

(setopt no-redraw-on-reenter t)

;;; Icon:

;; 响铃可视化 (在 MS-Windows 上表现为 任务栏图标闪烁).
(setopt visible-bell t)

(provide 'shynur-ui)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
