;;; ~shynur/.emacs.d/init.el --- Part of Shynur's .emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Xie Qi <one.last.kiss@outlook.com>
;;
;;

;;; Commentary:

;; 1. 设置环境变量:
;;     - EDITOR=bin/emacsclientw
;;     - VISUAL=$EDITOR
;;     - ALTERNATE_EDITOR=bin/runemacs
;;
;; 2. 通用命令行参数:
;;     --no-splash
;;     --debug-init
;;     --no-blinking-cursor
;;     --vertical-scroll-bars

;;; Code:

(custom-set-variables
 '(post-gc-hook (append post-gc-hook
                        (list
                         (lambda ()
                           (make-thread (lambda ()
                                          (sleep-for 3)
                                          (shynur/message
                                           "%s"
                                           (format-spec
                                            #("%n GC (%ss total): %B VM, %mmin runtime"
                                              7  9 (face bold)
                                              26 28 (face bold))
                                            `((?n . ,(format #("%d%s"
                                                               0 2 (face bold))
                                                             gcs-done
                                                             (pcase (mod gcs-done 10)
                                                               (1 "st")
                                                               (2 "nd")
                                                               (3 "rd")
                                                               (_ "th"))))
                                              (?m . ,shynur/emacs-running-minutes)
                                              (?s . ,(round gc-elapsed))
                                              (?B . ,(cl-loop for memory = (memory-limit) then (/ memory 1024.0)
                                                              for mem-unit across "KMGT"
                                                              when (< memory 1024)
                                                              return (format #("%.1f%c"
                                                                               0 4 (face bold))
                                                                             memory
                                                                             mem-unit))))))))))))
 '(load-path (remq nil load-path))
 '(package-archive-priorities '(("gnu"    . 0)
                                ("nongnu" . 0)
                                ("melpa"  . 0))
                              1 (package)
                              "暂时不需要修改,因为根据`package-menu-hide-low-priority',默认选取最新的包")
 '(package-menu-hide-low-priority t
                                  2 (package))
 '(package-archives '(("gnu"    . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                      ("nongnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/")
                      ("melpa"  . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/"))
                    3 (package)
                    "[1]其它'ELPA'中的包会依赖gnu中的包[2]'nongnu'是官方维护的[3]'MELPA'滚动升级,收录的包的数量最大[4]stable-melpa依据源码的Tag(Git)升级,数量比'MELPA'少,因为很多包作者根本不打Tag[5]Org仅仅为了org-plus-contrib这一个包,Org重度用户使用[6]gnu-devel收录GNU中的包的开发中版本,一般不必启用(类似于'MELPA'与stable-melpa的关系)[7]nongnu-devel收录'nongnu'中的包的开发中版本,一般不必启用")
 '(package-selected-packages (progn
                               ;;摘编自'https://orgmode.org/elpa.html'
                               (let (message-log-max)
                                 (ignore-errors
                                   '(package-refresh-contents)))
                               (mapc (lambda (package-symbol)
                                       (unless (package-installed-p package-symbol)
                                         (package-install package-symbol))
                                       package-symbol)
                                     '(ivy
                                       sly
                                       dimmer
                                       swiper
                                       company
                                       helpful
                                       neotree
                                       transwin
                                       on-screen
                                       drag-stuff
                                       ascii-table
                                       doom-themes
                                       use-package
                                       rainbow-mode
                                       all-the-icons
                                       doom-modeline
                                       markdown-mode
                                       restart-emacs
                                       page-break-lines
                                       company-quickhelp
                                       rainbow-delimiters
                                       highlight-parentheses)))
                             4 (package))
 '(print-quoted t
                nil ()
                "打印成 'foo 而非 (quote foo)")
 '(print-escape-newlines t)
 '(print-escape-control-characters nil
                                   nil ()
                                   "打印成 ^C 而非 \3 , \n 和 \f 不受影响")
 '(print-length nil
                nil ()
                "当打印的列表元素数>该值时,超出部分用省略号表示")
 '(eval-expression-print-length nil)
 '(print-level nil)
 '(eval-expression-print-level nil)
 '(print-circle t
                nil ()
                "打印成#N=(#N#)而非(#level)")
 '(print-gensym t)
 '(print-integers-as-characters nil)
 '(major-mode 'text-mode)
 '(custom-unlispify-remove-prefixes nil
                                    nil (cus-edit)
                                    "无视`defgroup'中的`:prefix'关键字")
 '(highlight-nonselected-windows t
                                 nil ()
                                 "除了当前选中的'window',还'高亮'非选中的'window'的'active-region'")
 '(transient-history-file (shynur/pathname-ensure-parent-directory-exist
                           (concat
                            shynur/etc/
                            "transient-history-file.el"))
                          nil (transient))
 '(transient-levels-file (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "transient-levels-file.el"))
                         nil (transient))
 '(transient-values-file (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "transient-values-file.el"))
                         nil (transient))
 '(case-replace t
                nil (replace)
                "文本替换时,大小写敏感")
 '(garbage-collection-messages t
                               nil ()
                               "GC时在 echo area 显示信息,但不会并入到'*Messages*'中")
 '(completion-styles '(basic partial-completion initials)
                     nil (minibuffer)
                     "minibuffer的补全风格(从`completion-styles-alist'中选取)")
 '(completions-format 'horizontal
                      nil (minibuffer)
                      "minibuffer补全候选词在help窗口中排列的方式:尽可能的水平")
 '(column-number-mode t
                      nil (simple)
                      "mode line 显示列数")
 '(debug-on-error nil
                  nil ()
                  "没有对应的'handler'时进入debugger;debugger直接在error所在的环境中运行,所以很方便;但是有些'package'没有使用'user-error',所以若此变量开启,会时常进入debugger,非常麻烦,所以暂时来说,应该关掉")
 '(column-number-indicator-zero-based nil
                                      nil ()
                                      "obsolete")
 '(completion-auto-help t
                        nil (minibuffer)
                        "一次TAB以显示help列表")
 '(completions-detailed t
                        nil (minibuffer)
                        "在'minibuffer'中对符号进行'补全'时,在符号所在的那一行显示符号的类型和'docstring'的第一行")
 '(truncate-lines nil
                  nil ()
                  "溢出的行尾转向下一个screen-line")
 '(truncate-partial-width-windows nil
                                  nil ()
                                  "当window的宽度小于指定值的时候,自动开启`truncate-lines'")
 '(auto-hscroll-mode 'current-line
                     nil ()
                     "如果允许`truncate-lines',则自动触发'hscroll'时仅作用于当前行")
 '(calendar-week-start-day 1
                           nil (calendar)
                           "'日历'中以星期一作为一周的开始")
 '(auth-sources (mapcar (lambda (filename-string)
                          (shynur/pathname-ensure-parent-directory-exist
                           (concat
                            shynur/etc/
                            (substring filename-string 2)))) auth-sources)
                nil (auth-source)
                "'远程登陆'的认证信息(包含明文密码)的存储位置")
 '(coding-system-for-write 'utf-8-unix
                           nil ()
                           "该customization中的NEW被Emacs设置为t")
 '(meta-prefix-char meta-prefix-char)
 '(completion-cycle-threshold nil
                              nil (minibuffer)
                              "minibuffer补全时,按TAB会轮换候选词")
 '(current-language-environment (cond
                                 ((eq system-type 'windows-nt)
                                  "UTF-8")
                                 (t
                                  "UTF-8"))
                                nil ()
                                "如果设置为Chinese-GB18030,则`shell'能兼容Windows,且键入[C-h t]之后就会默认使用中文版的TUTORIAL.cn但更好的方式是使用`help-with-tutorial-spec-language'")
 '(completion-category-overrides completion-category-overrides
                                 nil (minibuffer)
                                 "minibuffer在不同场景下的补全风格(从`completion-styles-alist'中选取)")
 '(kill-ring-max most-positive-fixnum
                 nil (simple))
 '(delete-trailing-lines t
                         nil (simple)
                         "执行`delete-trailing-whitespace'时,还删除首尾的多余的空行")
 '(show-trailing-whitespace nil
                            nil ()
                            "不高亮行尾的whitespace")
 '(indicate-empty-lines nil
                        nil ()
                        "若开启,'buffer'尾行之后的区域的右流苏区域会显示密集的刻度线")
 '(global-whitespace-mode nil
                          nil (whitespace))
 '(transient-mark-mode t
                       nil ()
                       "高亮'region'")
 '(mark-even-if-inactive nil)
 '(mark-ring-max mark-ring-max
                 nil (simple)
                 "太大的话就不能轮回访问了")
 '(global-mark-ring-max most-positive-fixnum
                        nil (simple)
                        "`global-mark-ring'只会在离开某个'buffer'时,记住那个'buffer'最后设置的'mark',这相当于将'buffer'作为节点的路径;因此,可以设置为较大的值")
 '(cua-mode nil)
 '(completion-ignored-extensions ())
 '(custom-enabled-themes '(modus-vivendi)
                         nil (custom)
                         "深色背景")
 '(custom-file (shynur/pathname-ensure-parent-directory-exist
                (concat
                 shynur/etc/
                 ".custom-file.el"))
               nil (cus-edit)
               "修改Emacs导出'customization'的位置,以防Emacs搅乱这个文件的'custom-set-variables'形式和'custom-set-faces'形式")
 '(doom-modeline-mode t
                      nil (doom-modeline all-the-icons))
 '(display-time-day-and-date t
                             nil (time)
                             "使`display-time-mode'显示'日期'")
 '(display-time-24hr-format nil
                            nil (time)
                            "关闭24h制")
 '(display-time-default-load-average 0
                                     nil (time)
                                     "使`display-time-mode'显示过去1min的平均'CPU荷载'")
 '(display-time-use-mail-icon display-time-mail-icon
                              nil (time)
                              "GUI下的Mail图标")
 '(display-time-mail-file nil
                          nil (time)
                          "是否检查以及如何检查邮箱,采用默认策略(i.e.,系统相关)")
 '(display-time-mail-directory nil
                               nil (time)
                               "该目录下的所有非空文件都被当成新送达的邮件")
 '(display-time-hook (append display-time-hook
                             (list
                              (lambda ()
                                (let ((inhibit-message t))
                                  (progn
                                    (require 'transwin)
                                    (transwin-dec)
                                    (transwin-ask 77))))
                              (lambda ()
                                (cl-incf shynur/emacs-running-minutes))))
                     nil (time)
                     "`display-time-mode'每次更新'时间'时调用(也即,每`display-time-interval'秒一次)")
 '(display-time-interval 60
                         nil (time)
                         "决定`display-time-mode'显示'时间'的更新频率")
 '(display-time-load-average-threshold 0
                                       nil (time)
                                       "使`display-time-mode'在'CPU荷载'>=0时,显示'CPU荷载'")
 '(battery-mode-line-format "[%p%%] "
                            nil (battery))
 '(battery-update-interval battery-update-interval
                           nil (battery))
 '(mode-line-in-non-selected-windows t
                                     nil ()
                                     "未被选中的窗口使用`mode-line-inactive'作为mode-line的face")
 '(eol-mnemonic-dos  "(CRLF)")
 '(eol-mnemonic-mac  "(CR)")
 '(eol-mnemonic-unix "(LF)")
 '(eol-mnemonic-undecided "(?EOL)")
 '(register-separator ?+
                      nil (register)
                      "用`append-to-register'将文本并入已经存储了文本的'register'中时,可以插入分隔符.分隔符存储在该变量所指定的'register'中.(须在调用`set-register'前,设置该变量)")
 '(delete-selection-mode t
                         nil (delsel)
                         "选中文本后输入字符,会先删除刚刚选择的文本,再插入输入的字符")
 '(enable-recursive-minibuffers t)
 '(eshell-directory-name (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "eshell-directory-name/"))
                         nil (esh-mode))
 '(eshell-history-file-name (shynur/pathname-ensure-parent-directory-exist
                             (concat
                              shynur/etc/
                              "eshell-history-file-name.txt"))
                            nil (em-hist))
 '(eshell-last-dir-ring-file-name (shynur/pathname-ensure-parent-directory-exist
                                   (concat
                                    shynur/etc/
                                    "eshell-last-dir-ring-file-name.txt"))
                                  nil (em-dirs))
 '(eww-bookmarks-directory (shynur/pathname-ensure-parent-directory-exist
                            (concat
                             shynur/etc/
                             "eww-bookmarks-directory/"))
                           nil (eww))
 '(extended-command-suggest-shorter t
                                    nil (simple)
                                    "通过不完整的函数名调用command时,在 echo area 中提示这个command的全名")
 '(desktop-restore-frames nil
                          nil (desktop)
                          "保存'desktop'时,将'frame'和'window'的参数排除在外")
 '(desktop-save-mode nil
                     nil (desktop))
 '(desktop-path (list
                 (shynur/pathname-ensure-parent-directory-exist
                  (concat
                   shynur/etc/
                   "desktop-path/")))
                nil (desktop)
                "查找被保存的'desktop'的位置所在的目录")
 '(desktop-base-file-name "desktop-base-file-name.el"
                          nil (desktop)
                          "和`desktop-path'组合使用")
 '(desktop-base-lock-name "desktop-base-lock-name.el"
                          nil (desktop))
 '(savehist-file (shynur/pathname-ensure-parent-directory-exist
                  (concat
                   shynur/etc/
                   "savehist-file.el"))
                 nil (savehist)
                 "必须在打开`savehist-mode'之前设置此变量,否则`savehist-mode'将找不到该文件")
 '(savehist-mode t
                 nil (savehist)
                 "保存minibuffer的历史记录")
 '(savehist-autosave-interval nil
                              nil (savehist)
                              "每多少秒保存一次minibuffer的历史记录")
 '(desktop-restore-eager t
                         nil (desktop)
                         "不使用懒惰策略去恢复'desktop'")
 '(desktop-load-locked-desktop nil
                               nil (desktop)
                               "Emacs运行时会创建一个locked'dekstop'文件,如果Emacs崩溃了再启动,将忽略这个文件")
 '(desktop-auto-save-timeout nil
                             nil (desktop)
                             "取消功能:在idle时自动保存'desktop'")
 '(file-name-shadow-mode t
                         nil (rfn-eshadow)
                         "`find-file'时,若输入绝对路径,则调暗默认值的前景")
 '(fringe-mode '(0 . nil)
               nil (fringe)
               "right-only")
 '(overflow-newline-into-fringe t
                                nil (fringe))
 '(global-display-line-numbers-mode t
                                    nil (display-line-numbers)
                                    "启用行首行号")
 '(display-line-numbers-type t
                             nil (display-line-numbers)
                             "启用绝对行号")
 '(display-line-numbers t
                        nil (display-line-numbers)
                        "启用绝对行号")
 '(display-line-numbers-widen t
                              nil ()
                              "无视narrowing,行号从buffer的起始点计算")
 '(display-line-numbers-width nil
                              nil ()
                              "动态改变为行号预留的列数")
 '(display-line-numbers-grow-only nil
                                  nil (display-line-numbers)
                                  "行号占用的列数可以动态减少")
 '(display-line-numbers-current-absolute t
                                         nil ()
                                         "开启relative/visual行号时,当前行仍然显示absolute行号")
 '(line-number-display-limit nil
                             nil ()
                             "当buffer的size太大时是否启用行号,以节约性能")
 '(line-number-display-limit-width most-positive-fixnum
                                   nil ()
                                   "单行太长也会消耗性能用于计算行号,因此,如果当前行附近的行的平均宽度大于该值,则不计算行号")
 '(display-line-numbers-major-tick 10
                                   nil ()
                                   "每10行就用`line-number-major-tick'高亮一次行号")
 '(global-font-lock-mode t
                         nil (font-core)
                         "全局'语法高亮'")
 '(neo-show-hidden-files t
                         nil (neotree))
 '(auto-compression-mode (pcase system-type
                           ('windows-nt
                            nil)
                           (_
                            t))
                         nil (jka-compr))
 '(c-mode-common-hook (append c-mode-common-hook
                              (list
                               (lambda ()
                                 ;;见<https://www.gnu.org/software/emacs/manual/html_node/efaq/Indenting-switch-statements.html>
                                 (c-set-offset 'case-label '+))
                               ;;只保留当前编译环境下,生效的ifdef从句
                               #'hide-ifdef-mode))
                      nil (cc-mode))
 '(neotree-mode-hook (append neotree-mode-hook
                             (list
                              (lambda ()
                                ;;关闭'neotree'的行号
                                (display-line-numbers-mode -1))))
                     nil (neotree))
 '(global-hl-line-mode t
                       nil (hl-line)
                       "'高亮'当前行")
 '(goto-line-history-local t
                           nil (simple)
                           "调用``M-g g''或``M-g M-g''(`goto-line')时,每个buffer使用自己的goto-line历史记录,而不是使用全局的")
 '(help-enable-symbol-autoload t
                               nil (help-fns)
                               "如果一个autoloaded符号的autoload形式没有提供'docstring',那就加载包含它的定义的文件,以查看它是否有'docstring'")
 '(history-delete-duplicates t
                             nil ()
                             "去重minibuffer历史记录列表")
 '(history-length t
                  nil ()
                  "使minibuffer历史记录的长度没有上限")
 '(horizontal-scroll-bar-mode nil
                              nil (scroll-bar)
                              "不显示横向'滚动条'")
 '(tab-width 4)
 '(global-tab-line-mode t
                        nil (tab-line))
 '(tab-line-close-button-show nil
                              nil (tab-line))
 '(tab-line-new-button-show nil
                            nil (tab-line))
 '(tab-line-switch-cycling nil
                           nil (tab-line)
                           "'tab-line'就是为了方便使用鼠标而存在的,直接用鼠标点就行了")
 '(tab-line-separator ""
                      nil (tab-line)
                      "关闭'tab-line-name'之间默认的空格")
 '(indent-tabs-mode nil
                    nil ()
                    "制表符尽量用空格代替.(不过,诸如'Bash'脚本之类的文件编写还是需要tab字符的)")
 '(context-menu-mode t
                     nil (mouse)
                     "在空白处右击显示菜单")
 '(kill-whole-line nil
                   nil (simple)
                   "`C-k'不删除换行符")
 '(echo-keystrokes 0.001
                   nil ()
                   "若快捷键未完整击入,则等待该时长后在echo-area显示已经击入的键")
 '(visible-bell t
                nil ()
                "响铃可视化.在Windows上表现为,任务栏图标闪烁")
 '(inhibit-startup-screen t
                          nil ()
                          "取消原本的 startup screen")
 '(initial-scratch-message (progn
                             (defface shynur/face-sly-mrepl-output-face
                               '((((class color)
                                   (background dark))
                                  (:foreground "VioletRed1"))
                                 (((class color)
                                   (background light))
                                  (:foreground "steel blue"))
                                 (t
                                  (:bold t :italic t))) "")
                             (shynur/buffer-eval-after-created "*scratch*"
                               (while (/= (buffer-size) (length initial-scratch-message))
                                 (sleep-for 1))
                               (highlight-regexp (format-message (shynur/string-text->regexp initial-scratch-message))
                                                 'shynur/face-sly-mrepl-output-face))
                             #(";;     *
;;      May the Code be with You!
;;     .                                 .
;;                               *
;;          /\\/|_      __/\\\\
;;         /    -\\    /-   ~\\  .              '
;;         \\    = Y =T_ =   /
;;          )==*(`     `) ~ \\
;;         /     \\     /     \\
;;         |     |     ) ~   (
;;        /       \\   /     ~ \\
;;        \\       /   \\~     ~/
;; _/\\_/\\_/\\__  _/_/\\_/\\__~__/_/\\_/\\_/\\_/\\_/\\_
;; |  |  |  | ) ) |  |  | ((  |  |  |  |  |  |
;; |  |  |  |( (  |  |  |  \\\\ |  |  |  |  |  |
;; |  |  |  | )_) |  |  |  |))|  |  |  |  |  |
;; |  |  |  |  |  |  |  |  (/ |  |  |  |  |  |
;; |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

"
                               0 665 ()))
                           nil ()
                           "'*scratch*'的初始内容")
 '(overwrite-mode nil)
 '(insert-default-directory t
                            nil (minibuffer)
                            "`find-file'时,给出默认目录")
 '(integer-width (* 8 16)
                 nil ()
                 "'bignum'的位宽")
 '(line-move-visual t
                    nil (simple)
                    "按照 screen line 上下移动")
 '(line-number-mode nil
                    nil (simple)
                    "mode-line不显示行号")
 '(max-mini-window-height max-mini-window-height
                          nil ()
                          "minubuffer最大高度:占比(float)/绝对高度(int)")
 '(message-log-max t
                   nil ()
                   "对于'*Messages*'的最大行数,不做限制")
 '(minibuffer-depth-indicate-mode t
                                  nil (mb-depth)
                                  "显示'minibuffer'的深度(e.g.,“[2] Describe function: ”).(文档说仅当`enable-recursive-minibuffers'非nil时,该变量有效,但是实际上试验结果是:都有效)")
 '(minibuffer-eldef-shorten-default t
                                    nil (minibuf-eldef)
                                    "将minibuffer的prompt的默认值提示字符串改成[default-arg]的形式,以节约屏幕面积.(生效的前提是打开`minibuffer-electric-default-mode',然而,这个模式下,输入任何字符后,就会隐藏默认值(改变prompt的长度),光标会瞬间向前移动,所以拒绝使用它,那么这个变量是'无效'变量)")
 '(minibuffer-follows-selected-frame t
                                     nil ()
                                     "切换frame时,minibuffer跟着跳转(但仍然在原来的那个frame中生效)")
 '(read-circle t
               nil ()
               "允许(字面上)读取循环结构")
 '(max-lisp-eval-depth max-lisp-eval-depth)
 '(max-specpdl-size max-specpdl-size
                    nil ()
                    "似乎在emacs-29中被废弃了")
 '(shr-offer-extend-specpdl t
                            nil (shr)
                            "'HTML'可能会有很深的嵌套,因此需要更多的'PDL'.该变量决定自动增长PDL的大小")
 '(shift-select-mode t
                     nil (simple)
                     "按住'shift'时移动光标,以选中文本")
 '(read-buffer-completion-ignore-case t
                                      nil ()
                                      "对buffer名字进行补全时,忽略大小写")
 '(read-extended-command-predicate read-extended-command-predicate
                                   nil (simple)
                                   "在minibuffer中,补全command时,决定要保留哪些候选词.默认不进行筛选")
 '(read-file-name-completion-ignore-case read-file-name-completion-ignore-case
                                         nil (minibuffer)
                                         "对文件路径进行补全时,是否忽略大小写(系统相关的)")
 '(read-quoted-char-radix 16
                          nil (simple)
                          "`C-q'后接16进制")
 '(resize-mini-windows t
                       nil ()
                       "minibuffer可以变宽变窄,由输入的字符串的行数决定")
 '(inhibit-startup-echo-area-message user-login-name
                                     nil ()
                                     "只有将该变量设置为自己在OS中的'username',才能屏蔽'startup'时 echo area 的“For information about GNU Emacs and the GNU system, type C-h C-a.”")
 '(save-place-file (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "save-place-file.el"))
                   nil (saveplace))
 '(save-place-mode t
                   nil (saveplace)
                   "在'session'之间保存访问文件时的浏览位置")
 '(scroll-bar-mode 'right
                   nil (scroll-bar)
                   "'滚动条'置于window右侧")
 '(kill-read-only-ok nil
                     nil (simple)
                     "'kill'只读的文本时,'beep'且显示'error消息'")
 '(kill-transform-function (lambda (string)
                             (and (not (string-blank-p string))
                                  string))
                           nil (simple)
                           "将它应用到被'kill'的文本上,并将其返回值加入到`kill-ring'中;若返回nil则不加入.(该例选自'<https://www.gnu.org/software/emacs/manual/html_node/emacs/Kill-Options.html>')")
 '(kill-do-not-save-duplicates t
                               nil (simple)
                               "'kill'重复的文本时,不将其加入到`kill-ring'中(具体行为受`equal-including-properties'影响)")
 '(show-paren-mode t
                   nil (paren)
                   "括号前后匹配时,高亮显示")
 '(show-paren-delay 0.125
                    nil (paren)
                    "延迟0.125s时间之后,高亮成对的括号")
 '(size-indication-mode t
                        nil (simple)
                        "mode-line显示buffer大小(k=10^3,M=10^6,...)")
 '(split-string-default-separators split-string-default-separators
                                   nil ()
                                   "`split-string'分隔字符串时默认参考的分隔位点为[ \\t\\n\\r]+")
 '(hscroll-margin 5)
 '(hscroll-step 1)
 '(suggest-key-bindings most-positive-fixnum
                        nil (simple)
                        "_1_通过函数名调用command时,在minibuffer中提示这个command可能绑定的快捷键;_2_决定`extended-command-suggest-shorter'的显示持续时间;_3_将前面这两个提示信息持续显示5秒;_4_使command候选词列表中,各函数名的后面显示该函数绑定的快捷键")
 '(temporary-file-directory (shynur/pathname-ensure-parent-directory-exist
                             (concat
                              shynur/etc/
                              "temporary-file-directory/"))
                            nil ()
                            "'临时文件'的放置目录(隐私文件放在“/tmp/”目录是不妥的)")
 '(text-quoting-style nil
                      nil ()
                      "渲染成对的'单引号'时,尽可能使用“‘curve’”这种样式,退而求此次地可以使用“`grave'”这种样式")
 '(track-eol nil
             nil (simple)
             "上下移动时,不紧贴行尾")
 '(apropos-do-all nil
                  nil (apropos)
                  "有些'apropos'命令,在提供'prefix'参数时,会扩大查找范围.如果该变量为t,则即使不提供'prefix'参数,'apropos'命令也仍然会扩大查找范围")
 '(on-screen-global-mode t
                         nil (on-screen)
                         "在'滚卷'时提示_刚刚的/接下来新增的_visible区域,以防止在'滚卷'时迷失方向")
 '(on-screen-inverse-flag t
                          nil (on-screen)
                          "令`on-screen-global-mode'提示刚刚的visible区域")
 '(on-screen-highlight-method (nth 1 '(fringe shadow line narrow-line))
                              nil (on-screen)
                              "决定`on-screen-global-mode'如何提示")
 '(fast-but-imprecise-scrolling t
                                nil ()
                                "'scroll'时假定滚过的文本有'default''face',从而避免'fontify'它们.当那些滚过的文本的size不一致时,可能导致终点位置有偏差")
 '(jit-lock-defer-time 0.3
                       nil (jit-lock)
                       "'scroll'之后延迟多久再'fontify'文本")
 '(redisplay-skip-fontification-on-input t)
 '(recenter-redisplay recenter-redisplay
                      nil ()
                      "如果'recenter'时不`redraw'整个'frame',则可能造成TUI屏幕有少许显示错误.使用默认值即可")
 '(global-hi-lock-mode nil
                       nil (hi-lock))
 '(hi-lock-auto-select-face t
                            nil (hi-lock)
                            "每次`highlight-regexp'自动选择且尽量使用不同的'face'")
 '(hi-lock-file-patterns-policy 'always
                                nil (hi-lock)
                                "`hi-lock-mode'下可使用`hi-lock-write-interactive-patterns'将当时的高亮配置以注释的形式写下来,以供以后访问时用`hi-lock-find-patterns'再次应用它们.将该变量置为t,则打开`hi-lock-mode'时自动抽取并应用它们")
 '(apropos-sort-by-scores 'verbose
                          nil (apropos))
 '(apropos-documentation-sort-by-scores 'verbose
                                        nil (apropos))
 '(uniquify-buffer-name-style 'forward
                              nil (uniquify)
                              "当buffer对应的文件名相同时,在buffer名字之前补全文件的路径,使buffer的名字互异(行为上的细节受`uniquify-strip-common-suffix'影响)")
 '(uniquify-strip-common-suffix t
                                nil (uniquify)
                                "当`uniquify-buffer-name-style'的设置涉及补全文件路径时,保留显示路径名之间相同的部分")
 '(url-cache-directory (shynur/pathname-ensure-parent-directory-exist
                        (concat
                         shynur/etc/
                         "url-cache-directory/"))
                       nil (url-cache))
 '(url-cookie-file (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "url-cookie-file"))
                   nil (url-cookie))
 '(user-full-name "谢骐")
 '(user-mail-address "one.last.kiss@outlook.com"
                     nil ()
                     "用户的网络'邮箱'")
 '(blink-cursor-mode nil
                     nil (frame)
                     "取消'光标'闪烁")
 '(blink-cursor-delay 0
                      nil (frame)
                      "'光标'开始闪烁的时间点")
 '(blink-cursor-blinks 0
                       nil (frame)
                       "如果打开`blink-cursor-mode'的话,停止输入后cursor会闪烁一定次数,然后静止")
 '(blink-cursor-alist '((box  . nil)
                        (bar  . box)
                        (hbar . bar))
                      nil ()
                      "当设置`cursor-type'时,将会根据此alist设置光标黯淡时的type")
 '(blink-cursor-interval 0.5
                         nil (frame)
                         "'光标'闪烁的时间间隔")
 '(visible-cursor t
                  nil ()
                  "在TUI下,如果有可能的话,使'cursor'外形或特征更加显著(通常是blinking)")
 '(what-cursor-show-names t
                          nil (simple)
                          "使``C-x =''(`what-cursor-position')顺便显示字符的Unicode名字")
 '(cursor-type 'box
               nil ()
               "GUI下的cursor的静态图标")
 '(x-stretch-cursor t
                    nil ()
                    "在tab字符上拉长显示cursor")
 '(cursor-in-non-selected-windows t
                                  nil ()
                                  "未选择的window中的cursor显示为静态镂空框")
 '(global-visual-line-mode nil
                           nil (simple)
                           "关闭word-wrap")
 '(visual-line-fringe-indicators '(nil down-arrow)
                                 nil (simple)
                                 "word-wrap打开时在换行处显示down-arrow")
 '(window-divider-default-places 'right-only
                                 nil (frame)
                                 "横向'拖动条'可以用mode-line代替,所以只需要纵向'拖动条',也即,只在window的右侧显示'拖动条'")
 '(window-divider-default-right-width 12
                                      nil (simple)
                                      "设置window'拖动条'的宽度")
 '(global-company-mode t
                       nil (company))
 '(company-idle-delay 0
                      nil (company)
                      "令'company'进行补全猜测时,零延迟.")
 '(company-tooltip-offset-display 'lines
                                  nil (company)
                                  "原本在候选词界面的右侧是由'滚动条'的,现在改成:提示前面和后面分别有多少候选词")
 '(on-screen-delay 0.4
                   nil (on-screen)
                   "'on-screen'的提示持续时间")
 '(company-minimum-prefix-length 2
                                 nil (company)
                                 "当输入2个字符时,'company'就开始猜测'补全'")
 '(company-dabbrev-code-everywhere t
                                   nil (company)
                                   "还在'comment'和'string'中进行'补全'")
 '(company-dabbrev-code-other-buffers t
                                      nil (company)
                                      "在具有相同major-mode的'buffer'中搜索'补全'候选词")
 '(company-dabbrev-code-time-limit 2
                                   nil (company)
                                   "在'current-buffer'中搜索代码块中的关键词的时间限制")
 '(company-show-quick-access t
                             nil (company)
                             "给候选词编号")
 '(company-tooltip-limit 10
                         nil (company)
                         "一次性显示候选词的数量")
 '(next-screen-context-lines 5
                             nil ()
                             "'scroll'以使'window'底端的N行呈现到顶端")
 '(w32-mouse-button-tolerance w32-mouse-button-tolerance
                              nil ()
                              "如果鼠标的3个案件中有一个失灵了,可以在这么多毫秒内同时按下其余两个键,Emacs会将其识别为失灵的那个键")
 '(w32-swap-mouse-buttons nil
                          nil ()
                          "是否交换鼠标的中键和右键")
 '(dimmer-mode t
               nil (dimmer)
               "暗淡非聚焦状态的'window'(似乎可以设置渐变色)")
 '(scroll-error-top-bottom nil
                           nil (window)
                           "无法再'scroll'时停住,而不是继续移动'point'")
 '(global-highlight-parentheses-mode t
                                     nil (highlight-parentheses)
                                     "给内层括号换种颜色")
 '(sentence-end-double-space t)
 '(prog-mode-hook (append prog-mode-hook
                          (list
                           #'rainbow-mode
                           #'rainbow-delimiters-mode))
                  nil (prog-mode rainbow-mode rainbow-delimiters)
                  "e.g.,让“#ffffff”显示白色")
 '(scroll-bar-width 28)
 '(initial-buffer-choice t
                         nil ()
                         "启动时转向该'buffer'(t在这里表示'*scratch*')")
 '(maximum-scroll-margin 0.5
                         nil ())
 '(scroll-margin 1
                 nil ()
                 "相当于,'光标'不会到达的边缘地带的宽度(单位是 screen line);占'window'的最大比例为`maximum-scroll-margin'")
 '(scroll-conservatively most-positive-fixnum
                         nil ())
 '(scroll-minibuffer-conservatively t
                                    nil ()
                                    "对于'minibuffer',永远是一行一行地'automatic_scroll'")
 '(ivy-count-format "%d/%d "
                    nil (ivy))
 '(ivy-height 6
              nil (ivy)
              "准确来说是最大高度")
 '(minibuffer-setup-hook (append
                          minibuffer-setup-hook
                          (list
                           (lambda () ;令ivy的minibuffer拥有'自适应'高度
                             (add-hook 'post-command-hook
                                       (lambda ()
                                         (when (progn
                                                 (require 'ivy)
                                                 ivy-mode)
                                           (shrink-window (1+ (progn
                                                                (require 'ivy)
                                                                ivy-height)))))
                                       nil
                                       t)))))
 '(calendar-mark-holidays-flag t
                               nil (calendar))
 '(prettify-symbols-alist '(("lambda" . ?λ)
                            ("<<"     . ?≪)
                            ("<="     . ?≤)
                            (">="     . ?≥)
                            (">>"     . ?≫)
                            ("::"     . ?∷)
                            ("=>"     . ?⇒)
                            ("->"     . ?→))
                          nil (prog-mode)
                          "此为默认值,不生效;仅供'buffer-local'时使用")
 '(global-prettify-symbols-mode nil
                                nil (prog-mode)
                                "先关闭,等'buffer-local'的`prettify-symbols-alist'设置完成,再启动`prettify-symbols-mode'")
 '(display-hourglass t
                     nil ()
                     "当Emacs'busy'时,将鼠标指针显示为'漏斗'")
 '(hourglass-delay 0
                   nil ()
                   "当Emacs进入busy状态时,立刻将鼠标指针显示为漏斗(而不是过一段时间再显示)")
 '(make-pointer-invisible t
                          nil ()
                          "用户typing时隐藏鼠标指针")
 '(x-underline-at-descent-line nil)
 '(underline-minimum-offset 0
                            nil ()
                            "underline向下偏移基准线(相当于英语四线三格的3th线)的像素数")
 '(overline-margin 1
                   nil ()
                   "上划线的高度+宽度")
 '(display-raw-bytes-as-hex t
                            nil ()
                            "若不启用`ctl-arrow',则'\x80'而非'\200'")
 '(mouse-highlight t
                   nil ()
                   "当鼠标位于clickable位置时,高亮此处的文本")
 '(mouse-yank-at-point nil
                       nil (mouse)
                       "在'click'的地方'yank'而不是'point'")
 '(global-highlight-changes-mode t
                                 nil (hilit-chg))
 '(highlight-changes-visibility-initial-state nil
                                              nil (hilit-chg))
 '(eval-expression-debug-on-error t
                                  nil (simple)
                                  "在`eval-expression'时暂时地将`debug-on-error'设置为t")
 '(debug-on-quit nil
                 nil ()
                 "按下'C-g'时是否要进入'debugger'")
 '(bookmark-default-file (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "bookmark-default-file.el"))
                         nil (bookmark))
 '(bookmark-save-flag 1
                      nil (bookmark)
                      "每次保存'bookmark'时都会写进文件")
 '(bookmark-use-annotations t
                            nil (bookmark)
                            "保存/转向'bookmark'时,请求书写 / 在另一个window显示 备注信息")
 '(bookmark-search-size bookmark-search-size
                        nil (bookmark)
                        "文件在被'bookmark'记录之后可能会有改动,'bookmark'可以记住它的上下文以对应这种情况.该变量决定上下文的长度")
 '(pulse-delay 0.125
               nil (pluse))
 '(pulse-iterations 32
                    nil (pulse))
 '(comint-completion-addsuffix '("/" . " ")
                               nil (comint)
                               "'shell-mode'对pathname补全时,在pathname之后添加的字符串.(e.g., cat+.emacs.d/init.el+该变量的值)")
 '(comint-process-echoes (cond
                          ((eq system-type 'windows-nt)
                           t)
                          (t
                           comint-process-echoes))
                         nil (comint)
                         "Windows上的PowerShell会回显输入的命令(至少在'shell-mode'中是这样),设置此变量以删除它")
 '(selection-coding-system selection-coding-system
                           nil (select)
                           "与X/Windows交互'clipboard'时的编码/解码方式")
 '(list-colors-sort nil
                    nil (facemenu)
                    "决定`list-colors-display'如何排列颜色")
 '(use-empty-active-region nil
                           nil (simple)
                           "有些命令的行为取决于是否有'active''region'.'region'长度为0时应该让那些命令无视'region',因为用户很难识别长度为0的'region'")
 '(delete-active-region t
                        nil (simple)
                        "当'region''active'时,删除命令删除整个'region'而非单个字符")
 '(set-mark-command-repeat-pop nil
                               nil (simple)
                               "置t的话,轮流跳转到'mark-ring'中指定的位置时,只有第一次需要加'C-u'前缀,后续全部只需要'C-SPC'即可")
 '(rectangle-mark-mode nil
                       nil (rect)
                       "默认关闭,要用的时候可以用快捷键暂时性打开")
 '(mark-even-if-inactive nil
                         nil ()
                         "不把'inactive''region'当'region'看")
 '(explicit-shell-file-name (cond
                             (t
                              explicit-shell-file-name))
                            nil (shell)
                            "'shell-mode'的默认启动SHELL(见<https://www.gnu.org/software/emacs/manual/html_mono/efaq-w32.html#Using-shell>)")
 '(server-auth-dir (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "server-auth-dir/"))
                   nil (server)
                   "'server-auth-dir/server-name.txt',该变量需要在`server-start'之前设置好")
 '(server-socket-dir (shynur/pathname-ensure-parent-directory-exist
                      (concat
                       shynur/etc/
                       "server-socket-dir/"))
                     nil (server)
                     "'server-socket-dir/server-name.txt',该变量需要在`server-start'之前设置好")
 '(server-name "server-name.txt"
               nil (server)
               "'server-*-dir/server-name.txt',该变量需要在`server-start'之前设置好")
 '(register-preview-delay 0
                          nil (register)
                          "调用读写'register'的命令时,预览已赋值的'register',0延迟")
 '(mouse-autoselect-window nil
                           nil ()
                           "当鼠标在一个'frame'上移动时,并不根据鼠标的位置自动选择'window',以防鼠标突然被碰撞导致选中其它'window'")
 '(help-char ?\C-h
             nil ()
             "默认是'C-h'")
 '(scroll-preserve-screen-position nil
                                   nil ()
                                   "若非nil,则'scroll'时(尤其是鼠标滚轮)保持'point'在屏幕上的位置,但这样会扯坏'region'")
 '(frame-background-mode nil
                         nil (frame)
                         "让Emacs根据当前背景颜色(light/dark)自动选择应该呈现的'face'属性")
 '(text-scale-mode-step text-scale-mode-step
                        nil (face-remap)
                        "放缩字体大小时的倍率")
 '(after-init-hook (append after-init-hook
                           (list
                            (lambda ()
                              (defconst user-init-file (shynur/pathname-ensure-parent-directory-exist
                                                        (concat
                                                         shynur/etc/
                                                         ".user-init-file.el")))))))
 '(emacs-startup-hook (append emacs-startup-hook
                              (list
                               (lambda ()
                                 (other-window 1)
                                 (delete-other-windows))
                               (lambda ()
                                 ;;记录击键
                                 ;;(bug#62277)
                                 (lossage-size (* 10000 10)))
                               (lambda ()
                                 (prefer-coding-system 'utf-8-unix)
                                 (set-coding-system-priority 'utf-8-unix))
                               ;;[menu-bar]->[File]->[Filesets]
                               #'filesets-init
                               (lambda ()
                                 (progn
                                   (require 'zone)
                                   (zone-when-idle (* 60 30))))
                               (lambda ()
                                 (shynur/buffer-eval-after-created "*scratch*"
                                   (with-current-buffer "*scratch*"
                                     (setq-local prettify-symbols-alist (default-value 'prettify-symbols-alist))
                                     (prettify-symbols-mode)
                                     (setq-local default-directory (pcase system-name
                                                                     ("ASUS-TX2"
                                                                      "d:/Downloads/Tmp/")
                                                                     (_
                                                                      "~/"))))))
                               (lambda ()
                                 (let ((shynur/machine "~/.emacs.d/shynur/machine.el"))
                                   (when (file-exists-p shynur/machine)
                                     (load-file shynur/machine))))
                               (lambda ()
                                 (display-time-mode)
                                 (display-battery-mode))
                               (lambda ()
                                 (progn
                                   (require 'register)
                                   ;;见`register-separator'
                                   (set-register (progn
                                                   (require 'register)
                                                   register-separator) "\n\n")
                                   ;;将本文件的位置保存在'register'中,以便随时访问
                                   (set-register ?i '(file . "~/.emacs.d/init.el"))))
                               (lambda ()
                                 ;;调节'beep'的声音种类,而不是音量
                                 (set-message-beep nil))
                               (lambda ()
                                 (shynur/message #("启动耗时[%.1f]s"
                                            5 9 (face bold))
                                          (/ (- (car (time-convert after-init-time 1000))
                                                (car (time-convert before-init-time 1000)))
                                             1000.0))))))
 '(tooltip-delay 0
                 nil (tooltip))
 '(tooltip-mode t
                nil (tooltip))
 '(doom-modeline-window-width-limit nil
                                    nil (doom-modeline)
                                    "即使当前窗口宽度很小,也尽量显示所有信息")
 '(doom-modeline-bar-width 3
                           nil (doom-modeline)
                           "doom-modeline左侧小竖条的宽度(装饰品)")
 '(doom-modeline-height 1
                        nil (doom-modeline))
 '(inferior-lisp-program (cond
                          ((eq system-type 'windows-nt) (cond
                                                         ((string= system-name "ASUS-TX2") "d:/Progs/Steel_Bank_Common_Lisp/sbcl.exe")
                                                         (t                                inferior-lisp-program)))
                          (t                            inferior-lisp-program))
                         nil (sly))
 '(save-interprogram-paste-before-kill t
                                       nil (simple)
                                       "因`kill-do-not-save-duplicates'导致`kill-ring'只保留了不重复的文本,所以大可放心置t")
 '(yank-pop-change-selection nil
                             nil (simple)
                             "'M-y'不改变'clipboard'的内容")
 '(select-enable-clipboard t
                           nil (select)
                           "允许与'clipboard'交互")
 '(x-select-enable-clipboard-manager nil
                                     nil ()
                                     "Emacs退出时不需要将`kill-ring'转交给'clipboard'")
 '(select-enable-primary nil
                         nil (select)
                         "置t则说明不使用'clipboard'")
 '(mouse-drag-copy-region nil
                          nil (mouse)
                          "不自动复制鼠标拖选的'region'")
 '(help-at-pt-display-when-idle t
                                nil (help-at-pt)
                                "光标移到active-text处时,在echo-area显示'tooltip'")
 '(help-at-pt-timer-delay 0
                          nil (help-at-pt)
                          "让`help-at-pt-display-when-idle'的效果没有延迟")
 '(x-select-request-type x-select-request-type
                         nil (select)
                         "如何与X的'clipboard'交互")
 '(global-page-break-lines-mode t
                                nil (page-break-lines)
                                "将form-feed字符渲染成别致的下划线")
 '(page-break-lines-modes '(text-mode
                            prog-mode)
                          nil (page-break-lines))
 '(page-break-lines-lighter page-break-lines-lighter
                            nil (page-break-lines)
                            "mode-line上显示的该模式名")
 '(page-break-lines-max-width nil
                              nil (page-break-lines)
                              "渲染的下划线将会占用两个screen-line")
 '(font-lock-maximum-decoration t
                                nil (font-lock)
                                "不限制'fontification'的数量")
 '(fill-column 70
               nil ()
               "`auto-fill-mode'折行的位置(zero-based)")
 '(global-display-fill-column-indicator-mode t
                                             nil (display-fill-column-indicator))
 '(display-fill-column-indicator-column t
                                        nil (display-fill-column-indicator)
                                        "默认值参考`fill-column'")
 '(display-fill-column-indicator-character ?│
                                           nil (display-fill-column-indicator))
 '(indicate-buffer-boundaries nil
                              nil ()
                              "控制是否在'fringe'所在的区域上显示首尾指示符('window'的四个边角区域)")
 '(repeat-mode t
               nil (repeat))
 '(selective-display-ellipses t
                              nil ()
                              "selective-display会在行尾显示'...'表示省略")
 '(ctl-arrow t
             nil ()
             "用'^A'表示法(而非'\001'或'\x01')打印raw-byte(e.g.,`C-q'后接的字符)")
 '(nobreak-char-display t
                        nil ()
                        "将容易与ASCII字符中的几个混淆的Unicode字符使用特殊的face渲染(non-boolean在此基础上加上前缀backslash)")
 '(default-input-method "chinese-py")
 '(line-spacing nil
                nil ()
                "行距")
 '(case-fold-search t
                    nil ()
                    "search/match时忽略大小写(经试验,isearch仅在给定模式串全部是小写时忽略大小写);影响函数:`char-equal';无关函数:`string='")
 '(isearch-resume-in-command-history nil
                                     nil (isearch)
                                     "isearch将不会出现在`command-history'中")
 '(search-default-mode t
                       nil (isearch)
                       "令`isearch'使用'regexp'搜索")
 '(swiper-include-line-number-in-search nil
                                        nil (swiper))
 '(isearch-lazy-highlight t
                          nil (isearch)
                          "除了当前光标附近的match,还(使用`lazy-highlight'face)高亮其它的matches")
 '(lazy-highlight-initial-delay 0.25
                                nil (isearch)
                                "延迟0.25s后再高亮周围的匹配串")
 '(lazy-highlight-no-delay-length most-positive-fixnum
                                  nil (isearch))
 '(lazy-highlight-max-at-a-time nil
                                nil (isearch)
                                "在检查后续输入前处理的高亮标记的数量,越大响应速度越慢;nil表示仅处理当前屏幕上存在的匹配的串")
 '(isearch-lazy-count t
                      nil (isearch)
                      "给`lazy-count-prefix-format'和`lazy-count-suffix-format'匹配串的current/total值(当前是第几个,一共匹配了多少个)")
 '(lazy-count-prefix-format "%s/%s "
                            nil (isearch)
                            "___I-search: ...")
 '(lazy-count-suffix-format "..."
                            nil (isearch)
                            "I-search: ...___")
 '(isearch-repeat-on-direction-change t
                                      nil (isearch)
                                      "默认情况下,当isearch改变方向进行搜索时,会先掉头,再开始搜索.该变量置t以省略该过程")
 '(isearch-wrap-pause t
                      nil (isearch)
                      "匹配失败后的下一次匹配尝试会报错,之后再重新搜索;重新从首/尾开始搜索会在minibuffer中显示Wrapped,重新回到起始点会显示Overwrapped")
 '(search-ring-max most-positive-fixnum
                   nil (isearch))
 '(regexp-search-ring-max most-positive-fixnum
                          nil (isearch))
 '(search-upper-case 'not-yanks
                     nil (isearch)
                     "如果是case-insensitive搜索,pattern中若出现大写字母则会使其进化为case-sensitive.将该变量置为not-yanks以自动downcase粘贴的文本")
 '(search-exit-option 'edit
                      nil (isearch)
                      "比如,键入`C-a'会聚焦于pattern,并可以编辑它")
 '(search-nonincremental-instead t
                                 nil (isearch)
                                 "当搜索串为空时,可以先按RET以关闭增量搜索(这样的好处是,可以先参见光标周围的文本以编辑搜索串,编辑完成之后再RET进入增量搜索)")
 '(isearch-hide-immediately nil
                            t (isearch)
                            "显示匹配的invisible文本")
 '(isearch-allow-prefix nil
                        nil (isearch))
 '(isearch-allow-scroll nil
                        nil (isearch))
 '(isearch-allow-motion nil
                        nil (isearch))
 '(isearch-motion-changes-direction nil
                                    nil (isearch)
                                    "此处motion指的是`isearch-allow-motion'中的motion")
 '(isearch-yank-on-move nil
                        nil (isearch)
                        "一种编辑搜索字符串的方式,不是很有用")
 '(search-whitespace-regexp "[[:space:]\n]+"
                            nil (isearch)
                            "如果在`isearch-*-regexp'中开启了`isearch-toggle-lax-whitespace'的话,键入SPC会匹配的字符")
 '(search-highlight t
                    nil (isearch))
 '(search-highlight-submatches t
                               nil (isearch)
                               "用一组face('isearch-group-*')分别高亮子表达式匹配成功的串")
 '(char-fold-symmetric t
                       nil (char-fold)
                       "搜索时,e.g.,(如果提前设置了`char-fold-include')字符a与ä和á等是等价的")
 '(replace-char-fold t
                     nil (char-fold))
 '(replace-lax-whitespace t
                          nil (replace))
 '(replace-regexp-lax-whitespace nil
                                 nil (replace))
 '(query-replace-from-to-separator "—→"
                                   nil (replace))
 '(query-replace-highlight t
                           nil (replace))
 '(query-replace-lazy-highlight t
                                nil (replace))
 '(query-replace-show-replacement t
                                  nil (replace)
                                  "逐个query时显示扩展后的replace-regexp(而非原始的)")
 '(query-replace-highlight-submatches t
                                      nil (replace))
 '(query-replace-skip-read-only t
                                nil (replace))
 '(search-invisible 'open
                    nil (isearch))
 '(list-matching-lines-default-context-lines 0
                                             nil (replace)
                                             "不需要`occur'在'*Occur*'中列出匹配行的上下文")
 '(list-matching-lines-jump-to-current-line t
                                            nil (replace)
                                            "在'*Occur*'中显示调用`occur'之前的那一行,并用'list-matching-lines-current-line-face'高亮之(方便找到回家的路)")
 '(occur-mode-hook (append occur-mode-hook
                           (list
                            (lambda ()
                              (progn
                                (require 'display-line-numbers)
                                (display-line-numbers-mode -1)))))
                   nil (replace))
 '(undo-limit most-positive-fixnum
              nil ()
              "(字节)可以超过该大小;尽量保证在达到该大小的前提下,移除最先前的信息")
 '(undo-strong-limit most-positive-fixnum
                     nil ()
                     "(字节)任何使总量超出该大小的操作(不包括最近的一次)将被遗忘")
 '(undo-outer-limit most-positive-fixnum
                    nil ()
                    "(字节)这是唯一使最近的一次操作无法undo的情行;如果单次操作生产的数据大于该值,则会被直接遗忘")
 '(kmacro-execute-before-append nil
                                nil (kmacro)
                                "'C-u F3':附加定义;'C-u C-u ... F3':重执行且附加定义")
 '(kmacro-ring-max most-positive-fixnum
                   nil (kmacro))
 '(midnight-mode nil
                 nil (midnight))
 '(temp-buffer-resize-mode t
                           nil (help)
                           "e.g.,使*Completions*不会几乎占用整个frame")
 '(safe-local-variable-values '((eval
                                 . (let ((case-fold-search t))
                                     (highlight-phrase "shynur[^[:blank:][:space:][:cntrl:]()`'\"]*"
                                                       'underline)))
                                (prettify-symbols-alist
                                 . (("lambda" . ?λ)))
                                (eval
                                 . (prettify-symbols-mode)))
                              nil (files))
 '(enable-local-variables t
                          nil (files)
                          "设置安全的变量,并(一次)询问unsafe的变量")
 '(enable-local-eval :maybe
                     nil (files)
                     "'file-local'列表中可在'Eval:'后定义需要求值的形式,该变量的值表示执行前询问")
 '(enable-remote-dir-locals t
                            nil (files)
                            "远程时也向上寻找'.dir-locals.el'以应用'directory-local'变量")
 '(confirm-kill-processes nil
                          nil (files)
                          "退出时,不询问是否要kill子进程")
 '(require-final-newline t
                         nil (files))
 '(before-save-hook (append before-save-hook
                            (list
                             #'whitespace-cleanup
                             #'time-stamp))
                    nil (files))
 '(large-file-warning-threshold 1000000
                                nil (files)
                                "打开达到该字节数的大文件时询问相关事宜;重点在于可以借此开启'literally'读取模式,这会关闭一些昂贵的功能,以提高访问速度")
 '(find-file-wildcards t
                       nil (files)
                       "允许Shell-style的路径通配符")
 '(confirm-kill-emacs nil
                      nil (files)
                      "退出时,不询问“Really exit Emacs?”")
 '(confirm-nonexistent-file-or-buffer 'after-completion
                                      nil (files)
                                      "`switch-to-buffer'或`find-file'时,输入前缀并按下TAB后,若有多个候选者但仍然RET,会再确认一遍")
 '(enable-dir-local-variables t
                              nil (files)
                              "'.dir-locals.el'")
 '(query-about-changed-file t
                            nil (files)
                            "外部改动发生后,重新访问已经读取到buffer中的文件时,询问是否要revert")
 '(make-backup-files t
                     nil (files))
 '(vc-make-backup-files nil
                        nil (vc-hooks))
 '(version-control nil
                   nil (files)
                   "对numbered-backup文件制作number-backup;否则,制作单备份")
 '(file-preserve-symlinks-on-save t
                                  nil (files))
 '(write-region-inhibit-fsync t)
 '(create-lockfiles t
                    nil ()
                    "当对文件关联的buffer作出首个改动时,给文件上锁")
 '(remote-file-name-inhibit-locks nil
                                  nil (files))
 '(revert-buffer-with-fine-grain-max-seconds most-positive-fixnum
                                             nil (files))
 '(revert-buffer-quick-short-answers t
                                     nil (files))
 '(global-auto-revert-mode t
                           nil (autorevert))
 '(auto-revert-verbose t
                       nil (autorevert))
 '(auto-revert-remote-files t
                            nil (autorevert))
 '(auto-revert-use-notify t
                          nil (autorevert))
 '(auto-revert-avoid-polling t
                             nil (autorevert)
                             "默认情况下`auto-revert-mode'同时使用被动的OS级file-notification和主动的poll(poll在编辑remote-file时无可替代),该变量关闭polling")
 '(global-auto-revert-non-file-buffers t
                                       nil (autorevert))
 '(auto-revert-interval 5
                        nil (autorevert)
                        "buffer-menu只使用poll更新")
 '(buffer-auto-revert-by-notification t
                                      nil (files)
                                      "dired可以使用file-notification")
 '(auto-save-interval 20
                      nil ()
                      "键入如此之多个character之后auto-save")
 '(auto-save-timeout 30
                     nil ()
                     "经过如此之多的秒数的idleness之后auto-save,还可能执行一次GC.(这是一条heuristic的建议,Emacs可以不遵循,e.g.,编辑大文件)")
 '(auto-save-list-file-prefix "~/.emacs.d/.shynur/auto-save-list/")
 '(auto-save-no-message nil)
 '(auto-save-visited-mode nil
                          nil (files)
                          "这是与`auto-save-mode'正交的另一种auto-saving,等价于定时地'C-x C-s'")
 '(delete-auto-save-files t
                          nil ()
                          "'C-x C-s'会自动删除auto-save-file")
 '(kill-buffer-delete-auto-save-files nil)
 '(auto-save-default t
                     nil (files)
                     "Emacs在发生致命错误时会直接触发auto-save,e.g.,‘kill %emacs’")
 '(list-directory-brief-switches "-C --classify"
                                 nil (files))
 '(list-directory-verbose-switches "-1 --almost-all --author --color=auto --classify --format=verbose --human-readable --size --sort=extension --time-style=long-iso"
                                   nil (files))
 '(delete-by-moving-to-trash t)
 '(copy-directory-create-symlink nil
                                 nil (files)
                                 "制作symlink的话请使用`make-symbolic-link'")
 '(view-read-only nil
                  nil (files)
                  "键入[C-x C-q]使buffer成为read-only时,不必开启`view-mode'")
 '(tramp-mode t
              nil (tramp)
              "若置nil,直接关闭remote-filename识别")
 '(tramp-persistency-file-name (shynur/pathname-ensure-parent-directory-exist
                                (concat
                                 shynur/etc/
                                 "tramp-persistency-file-name.el"))
                               nil (tramp-cache))
 '(tramp-auto-save-directory (shynur/pathname-ensure-parent-directory-exist
                              (concat
                               shynur/etc/
                               "tramp-auto-save-directory/"))
                             nil (tramp))
 '(recentf-mode t
                nil (recentf))
 '(recentf-save-file "~/.emacs.d/.shynur/recentf.el"
                     nil (recentf))
 '(filesets-menu-cache-file "~/.emacs.d/.shynur/filesets-menu-cache.el"
                            nil (filesets))
 '(eval-expression-debug-on-error t
                                  nil (simple))
 '(debugger-stack-frame-as-list nil
                                nil ()
                                "debugger以C风格显示函数调用栈,而不是Lisp风格")
 '(edebug-all-defs nil
                   nil (edebug)
                   "置t则颠倒[C-M-x]对前缀参数的处理")
 '(life-step-time 0.2
                  nil (life))
 '(split-window-keep-point nil
                           nil (window)
                           "Cursor在下半window时,新建window在上半部分;反之则反.简言之,尽可能少地重绘.缺点是,新窗口的point未必与原先一致")
 '(window-resize-pixelwise t)
 '(frame-resize-pixelwise t)
 '(delete-window-choose-selected 'mru
                                 nil (window)
                                 "Delete窗口之后下一个选中的窗口是最近使用过的")
 '(window-min-height 4
                     nil (window))
 '(window-min-width 1
                    nil (window))
 '(window-divider-mode t
                       nil (frame)
                       "在window的周围显示'拖动条',用来调整window的长和宽.(横向'拖动条'可以用mode-line代替,所以只需要纵向'拖动条',据此设置`window-divider-default-places'为right-only)(`window-divider-default-right-width'决定'拖动条'的宽度)"))

(custom-set-faces
 `(default
    ((t
      (:family ,(pcase system-name
                  ("ASUS-TX2"
                   "Maple Mono SC NF")
                  (_
                   "Consolas"))
       :foundry "outline"
       :slant  normal
       :weight normal
       :height ,(pcase system-name
                  ("ASUS-TX2"
                   141)
                  (_
                   131))
       :width  normal))))
 '(cursor
   ((t
     (:background "chartreuse")))
   nil
   "该'face'仅有':background'字段有效")
 `(tooltip
   ((t
     (:family ,(face-attribute 'line-number :family)))))
 '(line-number
   ((t
     (:slant  italic
      :weight light))))
 `(line-number-major-tick
   ((t
     (:background ,(face-attribute 'line-number :background)
      :slant      italic
      :underline  t
      :weight     light)))
   nil
   "指定倍数的行号;除此以外,还有'line-number-minor-tick'实现相同的功能,但其优先级更低")
 '(line-number-current-line
   ((t
     (:slant  normal
      :weight black))))
 '(fill-column-indicator
   ((t
     (:foreground "yellow")))
   nil
   "该'face'仅有':foreground'字段有效"))

;;详见 info emacs 10.9: 一些似乎没啥用的帮助信息
(progn
  (global-unset-key (kbd "C-h C-c"))
  (global-unset-key (kbd "C-h g"))
  (global-unset-key (kbd "C-h C-m"))
  (global-unset-key (kbd "C-h C-o"))
  (global-unset-key (kbd "C-h C-t"))
  (global-unset-key (kbd "C-h C-w")))

(global-unset-key (kbd "C-M-S-l")) ;`recenter-other-window'
(global-unset-key (kbd "C-x s")) ;`save-some-buffers'
(global-unset-key (kbd "C-x C-o")) ;删除附近空行
(global-unset-key (kbd "M-^"))
(global-unset-key (kbd "C-S-<backspace>")) ;删除一整行及其换行符
(global-unset-key (kbd "C-x DEL")) ;kill至行首
(global-unset-key (kbd "M-k")) ;kill至句尾
(global-unset-key (kbd "M-z")) ;`zap-to-char'一帧就删完了,动作太快 反应不过来
(global-unset-key (kbd "C-M-w")) ;强制合并两次'kill',使其变成`kill-ring'上的一个字符串
(global-unset-key (kbd "C-M-<mouse-1>")) ;就是鼠标左击
(global-unset-key (kbd "C-x >")) ;`scroll-right'
(global-unset-key (kbd "C-x <")) ;`scroll-left'
(global-unset-key (kbd "C-x n p")) ;`narrow-to-page'
(global-unset-key (kbd "C-x n d")) ;`narrow-to-defun'
(global-unset-key (kbd "C-x C-+")) ;`text-scale-adjust'
(global-unset-key (kbd "C-x C-=")) ;`text-scale-adjust'
(global-unset-key (kbd "C-x C--")) ;`text-scale-adjust'
(global-unset-key (kbd "C-x C-0")) ;`text-scale-adjust'
(global-unset-key (kbd "M-s h w")) ;`hi-lock-write-interactive-patterns'
(global-unset-key (kbd "M-s h f")) ;`hi-lock-find-patterns'
(global-unset-key (kbd "C-M-i")) ;`ispell-complete-word'
(global-unset-key (kbd "C-x C-v")) ;`find-alternate-file'
(global-unset-key (kbd "C-x 4 f")) ;`find-file-other-window'
(global-unset-key (kbd "C-x 5 f")) ;`find-file-other-frame'
(global-unset-key (kbd "C-x m")) ;`compose-mail'
(global-unset-key (kbd "C-x 5 b")) ;`switch-to-buffer-other-frame'
(global-unset-key (kbd "C-x <left>")) ;`previous-buffer'
(global-unset-key (kbd "C-x <right>")) ;`next-buffer'
(global-unset-key (kbd "C-x C-q")) ;`read-only-mode'
(global-unset-key (kbd "C-x 4 0")) ;`kill-buffer-and-window'

;;保留`undo'绑定的'C-_',其余删除
;;(某些终端会将键入的'C-/'解释成'C-_')
;;与`undo'相对应的`redo-undo'绑定也一并修改
(progn
  (global-unset-key (kbd "C-x u"))
  (global-unset-key (kbd "C-/"))
  (global-unset-key (kbd "C-?")))

;;'Emacs-16.2-Transposing-Text'
(progn
  (global-unset-key (kbd "C-t")) ;`transpose-chars'
  (global-unset-key (kbd "M-t")) ;`transpose-words'
  (global-unset-key (kbd "C-x C-t"))) ;`transpose-lines'

;;关闭与X的'secondary_selection'兼容的功能
;;'<https://www.gnu.org/software/emacs/manual/html_node/emacs/Secondary-Selection.html>'
(progn
  (global-unset-key (kbd "M-<drag-mouse-1>"))
  (global-unset-key (kbd "M-<mouse-1>"))
  (global-unset-key (kbd "M-<mouse-3>"))
  (global-unset-key (kbd "M-<mouse-2>")))

(progn
  ;;区域大小写
  (global-unset-key (kbd "C-x C-u"))
  (global-unset-key (kbd "C-x C-l"))
  ;;区域缩进
  (global-unset-key (kbd "C-M-\\")))

;;设置mark并移动point的组合命令.由于是功能上的组合,所以不是很有必要
(progn
  (global-unset-key (kbd "M-@"))
  (global-unset-key (kbd "C-M-@"))
  (global-unset-key (kbd "M-h"))
  (global-unset-key (kbd "C-M-h"))
  (global-unset-key (kbd "C-x C-p")))

(progn
  (global-set-key (kbd "C-s") (lambda ()
                                (interactive)
                                (progn
                                  (require 'ivy)
                                  (ivy-mode 1))
                                (condition-case nil
                                    (progn
                                      (require 'swiper)
                                      (swiper))
                                  ('quit (progn
                                           (require 'ivy)
                                           (ivy-mode -1))))
                                (progn
                                  (require 'ivy)
                                  (ivy-mode -1))))
  (global-unset-key (kbd "C-r"))
  (global-unset-key (kbd "C-M-r")))

(global-set-key (kbd "C-x C-b") #'bs-show)

(mapc (lambda (postkey-function)
        (let ((postkey  (car postkey-function))
              (function (cdr postkey-function)))
          (pcase (length postkey)
            (0
             (error "Invalid customized key: `C-c '"))
            (length
             (if (let ((letter (aref postkey 0)))
                   (or (<= ?A letter ?Z)
                       (<= ?a letter ?z)))
                 (when (and (>= length 2)
                            (not (char-equal #x20 (aref postkey 1))))
                   (error "Invalid customized key: `C-c <letter><non-SPC>'"))
               (error "Invalid customized key: `C-c <non-letter>'"))))
          (global-set-key (kbd (concat "C-c " postkey)) function)))
      `(("c" . ,(progn
                  (require 'hilit-chg)
                  #'highlight-changes-visible-mode))
        ,@(progn
            (defvar shynur/drag-stuff-map
              (let ((shynur/drag-stuff-map (make-sparse-keymap)))
                (require 'drag-stuff)
                (define-key shynur/drag-stuff-map (kbd "<left>")  #'drag-stuff-left)
                (define-key shynur/drag-stuff-map (kbd "<down>")  #'drag-stuff-down)
                (define-key shynur/drag-stuff-map (kbd "<up>")    #'drag-stuff-up)
                (define-key shynur/drag-stuff-map (kbd "<right>") #'drag-stuff-right)
                shynur/drag-stuff-map))
            (progn
              (require 'repeat)
              (put #'drag-stuff-left  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-down  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-up    'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-right 'repeat-map 'shynur/drag-stuff-map))
            '(("d <left>"  . drag-stuff-left)
              ("d <down>"  . drag-stuff-down)
              ("d <up>"    . drag-stuff-up)
              ("d <right>" . drag-stuff-right)))
        ("g" . ,#'garbage-collect)
        ("r" . ,(progn
                  (require 'restart-emacs)
                  #'restart-emacs))
        ("s" . ,(progn
                  (require 'shortdoc)
                  #'shortdoc-display-group))))

(progn
  (keyboard-translate ?\[ ?\()
  (keyboard-translate ?\] ?\))
  (keyboard-translate ?\( ?\[)
  (keyboard-translate ?\) ?\]))

;;保存并恢复不同'session'之间的'frame'的位置和尺寸:'<https://emacs.stackexchange.com/questions/76087/remember-restore-the-frame-position-and-size-of-the-last-session>'
;;以下代码摘编自:'<https://github.com/portacle/emacsd/blob/master/portacle-window.el>'
;;缺点:'窗口最大化'会被转换成'尺寸',而不是'窗口最大化'这个概念.所以新会话的'frame'仍然不是与屏幕紧密贴合的.
(when (display-graphic-p)
  (defconst shynur/frame-save-position-size-file
    (shynur/pathname-ensure-parent-directory-exist
     (concat
      shynur/etc/
      "shynur-frame-save-position-size-file.el")))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (when (file-exists-p shynur/frame-save-position-size-file)
                (load-file shynur/frame-save-position-size-file))))
  (add-hook 'kill-emacs-hook
            (lambda ()
              (let* ((props
                      '(left top width height))
                     (values
                      (mapcar (lambda (parameter)
                                (let ((value
                                       (frame-parameter (selected-frame) parameter)))
                                  (if (number-or-marker-p value)
                                      (max value 0)
                                    0))) props)))
                (with-temp-buffer
                  (cl-loop for prop in props
                           for val  in values
                           do (insert
                               (format "(add-to-list 'initial-frame-alist '(%s . %d))\n"
                                       prop val)))
                  (write-file shynur/frame-save-position-size-file))))))

;;; End of Code

;; TODO:
;; [1]
;; 不应该单纯开启`global-display-line-numbers-mode',
;; 而是应该给出一个分类机制,有需要的mode才打开`display-line-numbers-mode'.
;; 有些mode(例如,'neotree','calendar',...)显示行号反而会占用空间.
;; [2]
;; 将_非选中的window_且_是prog-mode的buffer_全部开启全局彩虹括号
;; 'highlight-parentheses'只会高亮光标附近的括号,其余地方还是一成不变.
;; 这样不够酷炫.
;; [3]
;; 拖动GUI时自动缩小应用窗口
;; [4]
;; 'C-h v' 按'TAB'补全时,过滤掉"prefix--*"和"*-internal"

(defun shynur/set-property-at (where)
  (interactive "n")
  (set-text-properties (point) (1+ (point))
                       (text-properties-at where)))

;; Local Variables:
;; coding: utf-8-unix
;; eval: (let ((case-fold-search t))
;;         (highlight-phrase "shynur[^[:blank:][:space:][:cntrl:]()`'\"]*"
;;                           'underline))
;; prettify-symbols-alist: (("lambda" . ?λ))
;; eval: (prettify-symbols-mode)
;; no-byte-compile: t
;; no-native-compile: t
;; End:
;;; ~shynur/.emacs.d/init.el ends here
