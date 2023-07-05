;;; ~shynur/.emacs.d/init.el --- Part of Shynur’s Emacs Configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;; .1 设置环境变量:
;;   - EDITOR=bin/emacsclientw
;;   - VISUAL=$EDITOR
;;   - ALTERNATE_EDITOR=bin/runemacs
;;
;; .2 通用命令行参数:
;;   --no-splash
;;   --debug-init
;;   --no-blinking-cursor
;;   --vertical-scroll-bars
;; .

;;; Code:

(custom-set-variables
 '(post-gc-hook `(,@post-gc-hook
                  ,(lambda ()
                     (message (shynur/message-format "%s")
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
                                 (?m . ,shynur/time-running-minutes)
                                 (?s . ,(round gc-elapsed))
                                 (?B . ,(cl-loop for memory = (memory-limit) then (/ memory 1024.0)
                                                 for mem-unit across "KMGT"
                                                 when (< memory 1024)
                                                 return (format #("%.1f%c"
                                                                  0 4 (face bold))
                                                                memory
                                                                mem-unit)))))))))
 '(load-path (remq nil load-path))
 '(package-archive-priorities '(("gnu"    . 0)
                                ("nongnu" . 0)
                                ("melpa"  . 0))
                              1 (package)
                              "暂时不需要修改,因为根据‘package-menu-hide-low-priority’,默认选取最新的包")
 '(package-menu-hide-low-priority t
                                  2 (package))
 '(package-archives '(("gnu"    . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                      ("nongnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/")
                      ("melpa"  . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/"))
                    3 (package)
                    "[1]其它ELPA中的包会依赖gnu中的包[2]nongnu是官方维护的[3]MELPA滚动升级,收录的包的数量最大[4]stable-melpa依据源码的Tag(Git)升级,数量比MELPA少,因为很多包作者根本不打Tag[5]Org仅仅为了org-plus-contrib这一个包,Org重度用户使用[6]gnu-devel收录GNU中的包的开发中版本,一般不必启用(类似于MELPA与stable-melpa的关系)[7]nongnu-devel收录nongnu中的包的开发中版本,一般不必启用")
 '(package-selected-packages (progn
                               ;;摘编自<https://orgmode.org/elpa.html>
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
                                       git-modes
                                       highlight
                                       on-screen
                                       which-key
                                       yaml-mode
                                       drag-stuff
                                       marginalia
                                       ascii-table
                                       doom-themes
                                       use-package
                                       indent-guide
                                       rainbow-mode
                                       all-the-icons
                                       doom-modeline
                                       markdown-mode
                                       page-break-lines
                                       company-quickhelp
                                       rainbow-delimiters
                                       highlight-parentheses)))
                             4 (package))
 '(print-quoted t
                nil ()
                "打印成“'foo”而非“(quote foo)”")
 '(print-escape-newlines t)
 '(print-escape-control-characters nil
                                   nil ()
                                   "打印成“^C”而非“\3”,“\n”和“\f”不受影响")
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
 '(completion-list-mode-hook `(,@(bound-and-true-p 'completion-list-mode-hook)
                               ,(lambda ()
                                  "把没用的minor mode都关了"
                                  (make-thread (lambda ()
                                                 "关了‘highlight-changes-mode’和‘highlight-changes-visible-mode’会因为试图移除face导致报错"
                                                 (sleep-for 0.4)
                                                 (company-mode -1)
                                                 (electric-indent-local-mode -1)
                                                 (electric-quote-local-mode -1)
                                                 (page-break-lines-mode -1)
                                                 (indent-guide-mode -1)
                                                 (on-screen-mode -1))))
                               ,(lambda ()
                                  "1 screen line/一个条目"
                                  (make-thread (lambda ()
                                                 (sleep-for 0.4)
                                                 (toggle-truncate-lines 1)))))
                             nil (simple))
 '(marginalia-mode t
                   nil (marginalia)
                   "注解“*Completions*”中的词条")
 '(completions-format 'one-column
                      nil (minibuffer)
                      "[[https://github.com/minad/marginalia/issues/149#issuecomment-1326437873][Marginalia works only well with completions-format one-column.]]")
 '(marginalia-separator ""
                        nil ()
                        "“*Completions*”字段之间自带“TAB”,不需要额外加separator")
 '(custom-unlispify-remove-prefixes nil
                                    nil (cus-edit)
                                    "无视‘defgroup’中的‘:prefix’关键字")
 '(highlight-nonselected-windows t
                                 nil ()
                                 "除了当前选中的window,还highlight非选中的window的active-region")
 '(transient-history-file (shynur/pathname-~/.emacs.d/.shynur/
                           "transient-history-file.el")
                          nil (transient))
 '(transient-levels-file (shynur/pathname-~/.emacs.d/.shynur/
                          "transient-levels-file.el")
                         nil (transient))
 '(transient-values-file (shynur/pathname-~/.emacs.d/.shynur/
                          "transient-values-file.el")
                         nil (transient))
 '(case-replace t
                nil (replace)
                "文本替换时,大小写敏感")
 '(garbage-collection-messages t
                               nil ()
                               "GC时在echo area显示信息,但不会并入到“*Messages*”中")
 '(completion-styles '(basic partial-completion initials)
                     nil (minibuffer)
                     "minibuffer的补全风格(从‘completion-styles-alist’中选取)")
 '(column-number-mode t
                      nil (simple)
                      "mode line 显示列数")
 '(debug-on-error nil
                  nil ()
                  "没有对应的handler时进入debugger;debugger直接在error所在的环境中运行,所以很方便;但是有些package没有使用user-error,所以若此变量开启,会时常进入debugger,非常麻烦,所以暂时来说,应该关掉")
 '(electric-quote-mode t
                       nil (electric))
 '(markdown-mode-hook `(,@markdown-mode-hook
                        ,(lambda ()
                           (electric-quote-local-mode -1)))
                      nil (markdown-mode))
 '(electric-quote-paragraph t
                            nil (electric))
 '(electric-quote-comment t
                          nil (electric))
 '(electric-quote-string t
                         nil (electric))
 '(electric-quote-replace-double nil
                                 nil (electric)
                                 "不替换“\"”")
 '(column-number-indicator-zero-based nil
                                      nil ()
                                      "obsolete")
 '(completion-auto-help t
                        nil (minibuffer)
                        "一次TAB以显示help列表")
 '(completions-detailed t
                        nil (minibuffer)
                        "在minibuffer中对符号进行completion时,在符号所在的那一行显示符号的类型和docstring的第一行")
 '(truncate-lines nil
                  nil ()
                  "溢出的行尾转向下一个screen-line")
 '(truncate-partial-width-windows nil
                                  nil ()
                                  "当window的宽度小于指定值的时候,自动开启‘truncate-lines’")
 '(auto-hscroll-mode 'current-line
                     nil ()
                     "如果允许‘truncate-lines’,则自动触发hscroll时仅作用于当前行")
 '(calendar-week-start-day 1
                           nil (calendar)
                           "以星期一作为一周的开始")
 '(auth-sources (mapcar (lambda (pathname)
                          (apply #'shynur/pathname-~/.emacs.d/.shynur/
                                 (remove "~" (file-name-split pathname)))) auth-sources)
                nil (auth-source)
                "remote access认证信息(包含明文密码)的存储位置")
 '(coding-system-for-write 'utf-8-unix
                           nil ()
                           "该customization中的NEW被Emacs设置为t")
 '(file-name-coding-system (pcase (system-name)
                             ("ASUS-TX2" 'chinese-gb18030       )
                             (_          file-name-coding-system)))
 '(completion-cycle-threshold nil
                              nil (minibuffer)
                              "minibuffer补全时,按TAB会轮换候选词")
 '(indent-guide-global-mode t
                            nil (indent-guide))
 '(indent-guide-recursive t
                          nil (indent-guide))
 '(indent-guide-char "\N{BOX DRAWINGS LIGHT VERTICAL}"
                     nil (indent-guide))
 '(current-language-environment "UTF-8")
 '(kill-ring-max most-positive-fixnum
                 nil (simple))
 '(delete-trailing-lines t
                         nil (simple)
                         "执行‘delete-trailing-whitespace’时,还删除首尾的多余的空行")
 '(show-trailing-whitespace nil
                            nil ()
                            "不高亮行尾的whitespace,因为没必要")
 '(change-major-mode-with-file-name t
                                    nil (files)
                                    "写入/重命名 文件时,执行‘normal-mode’以使用恰当的major mode")
 '(indicate-empty-lines nil
                        nil ()
                        "若开启,buffer尾行之后的区域的右流苏区域会显示密集的刻度线")
 '(transient-mark-mode t
                       nil ()
                       "高亮region")
 '(mark-even-if-inactive nil)
 '(mark-ring-max mark-ring-max
                 nil (simple)
                 "太大的话就不能轮回访问了")
 '(global-mark-ring-max most-positive-fixnum
                        nil (simple)
                        "‘global-mark-ring’只会在离开某个buffer时,记住那个buffer最后设置的mark,这相当于将buffer作为节点的路径;因此,可以设置为较大的值")
 '(completion-ignored-extensions '())
 '(custom-enabled-themes '(modus-vivendi)
                         nil (custom)
                         "深色背景")
 '(custom-file (shynur/pathname-~/.emacs.d/.shynur/
                "custom-file.el")
               nil (cus-edit)
               "修改Emacs导出customization的位置,以防Emacs搅乱这个文件的‘custom-set-variables’形式和‘custom-set-faces’形式")
 '(display-time-day-and-date t
                             nil (time)
                             "使‘display-time-mode’显示日期")
 '(display-time-24hr-format nil
                            nil (time)
                            "关闭24h制")
 '(display-time-default-load-average 0
                                     nil (time)
                                     "使‘display-time-mode’显示过去1min的平均CPU荷载")
 '(display-time-use-mail-icon display-time-mail-icon
                              nil (time)
                              "GUI下的Mail图标")
 '(display-time-mail-file nil
                          nil (time)
                          "是否检查以及如何检查邮箱,采用默认策略(i.e.,系统相关)")
 '(display-time-mail-directory nil
                               nil (time)
                               "该目录下的所有非空文件都被当成新送达的邮件")
 '(display-time-hook `(,@display-time-hook
                       ,(lambda ()
                          (let ((inhibit-message t))
                            (transwin-dec)
                            (transwin-ask 77)))
                       ,(lambda ()
                          (cl-incf shynur/time-running-minutes)))
                     nil (time)
                     "‘display-time-mode’每次更新时间时调用(也即,每‘display-time-interval’秒一次)")
 '(after-make-frame-functions `(,@after-make-frame-functions
                                ,(lambda (frame-to-be-made)
                                   (let ((inhibit-message t))
                                     (with-selected-frame frame-to-be-made
                                       (transwin-ask 77)))))
                              nil (frame))
 '(display-time-interval 60
                         nil (time)
                         "决定‘display-time-mode’显示时间的更新频率")
 '(display-time-load-average-threshold 0
                                       nil (time)
                                       "使‘display-time-mode’在CPU荷载>=0时,显示CPU荷载")
 '(battery-mode-line-format "[%p%%] "
                            nil (battery))
 '(battery-update-interval battery-update-interval
                           nil (battery))
 '(mode-line-in-non-selected-windows t
                                     nil ()
                                     "未被选中的窗口使用‘mode-line-inactive’作为mode-line的face")
 '(eol-mnemonic-dos  "(CRLF)")
 '(eol-mnemonic-mac  "(CR)")
 '(eol-mnemonic-unix "(LF)")
 '(eol-mnemonic-undecided "(?EOL)")
 '(register-separator ?+
                      nil (register)
                      "用‘append-to-register’将文本并入已经存储了文本的register中时,可以插入分隔符.分隔符存储在该变量所指定的register中.(须在调用‘set-register’前,设置该变量)")
 '(delete-selection-mode t
                         nil (delsel)
                         "选中文本后输入字符,会先删除刚刚选择的文本,再插入输入的字符")
 '(enable-recursive-minibuffers t)
 '(eshell-directory-name (shynur/pathname-~/.emacs.d/.shynur/
                          "eshell-directory-name/")
                         nil (esh-mode))
 '(eshell-history-file-name (shynur/pathname-~/.emacs.d/.shynur/
                             "eshell-history-file-name.txt")
                            nil (em-hist))
 '(eshell-last-dir-ring-file-name (shynur/pathname-~/.emacs.d/.shynur/
                                   "eshell-last-dir-ring-file-name.txt")
                                  nil (em-dirs))
 '(eww-bookmarks-directory (shynur/pathname-~/.emacs.d/.shynur/
                            "eww-bookmarks-directory/")
                           nil (eww))
 '(extended-command-suggest-shorter t
                                    nil (simple)
                                    "通过不完整的函数名调用command时,在echo area中提示这个command的全名")
 '(savehist-file (shynur/pathname-~/.emacs.d/.shynur/
                  "savehist-file.el")
                 nil (savehist)
                 "必须在打开‘savehist-mode’之前设置此变量,否则‘savehist-mode’将找不到该文件")
 '(savehist-mode t
                 nil (savehist)
                 "保存minibuffer的历史记录")
 '(savehist-autosave-interval nil
                              nil (savehist)
                              "每多少秒保存一次minibuffer的历史记录")
 '(desktop-restore-eager t
                         nil (desktop)
                         "不使用懒惰策略去恢复desktop")
 '(desktop-load-locked-desktop nil
                               nil (desktop)
                               "Emacs运行时会创建一个locked的dekstop文件,如果Emacs崩溃了再启动,将忽略这个文件")
 '(desktop-auto-save-timeout nil
                             nil (desktop)
                             "取消功能:在idle时自动保存desktop")
 '(minibuffer-allow-text-properties t
                                    nil ()
                                    "大部分情况下,保留从‘read-from-minibuffer’获取的文本的属性")
 '(minibuffer-default-prompt-format #(" (default %s)"
                                      10 12 (face (underline (:foreground "VioletRed1"))))
                                    nil (minibuffer))
 '(read-minibuffer-restore-windows t
                                   nil ()
                                   "从minibuffer获取输入之后,恢复进入minibuffer之前当前frame的window-configurations")
 '(file-name-shadow-mode t
                         nil (rfn-eshadow)
                         "‘find-file’时,若输入绝对路径,则调暗默认值的前景")
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
                                   "每10行就用‘line-number-major-tick’高亮一次行号")
 '(neo-show-hidden-files t
                         nil (neotree))
 '(neotree-mode-hook `(,@neotree-mode-hook
                       ,(lambda ()
                          "关闭neotree的行号"
                          (display-line-numbers-mode -1)))
                     nil (neotree))
 '(global-hl-line-mode t
                       nil (hl-line))
 '(goto-line-history-local t
                           nil (simple)
                           "调用“M-g g”或“M-g M-g”(‘goto-line’)时,每个buffer使用自己的‘goto-line’历史记录,而不是使用全局的")
 '(help-enable-symbol-autoload t
                               nil (help-fns)
                               "如果一个autoloaded符号的autoload形式没有提供docstring,那就加载包含它的定义的文件,以查看它是否有docstring")
 '(history-delete-duplicates t
                             nil ()
                             "去重minibuffer历史记录列表")
 '(history-length t
                  nil ()
                  "使minibuffer历史记录的长度没有上限")
 '(global-tab-line-mode t
                        nil (tab-line))
 '(tab-line-close-button-show nil
                              nil (tab-line))
 '(tab-line-new-button-show nil
                            nil (tab-line))
 '(tab-line-switch-cycling nil
                           nil (tab-line)
                           "tab-line就是为了方便使用鼠标而存在的,直接用鼠标点就行了")
 '(tab-line-separator ""
                      nil (tab-line)
                      "关闭tab-line-name之间默认的空格")
 '(tab-width 4)
 '(indent-tabs-mode nil
                    nil ()
                    "制表符尽量用空格代替.(需要特别考虑Makefile)")
 '(tab-always-indent t)
 '(electric-indent-mode t
                        nil (electric)
                        "RET后自动缩进")
 '(kill-whole-line nil
                   nil (simple)
                   "“C-k”不删除换行符")
 '(echo-keystrokes 0.001
                   nil ()
                   "若快捷键未完整击入,则等待该时长后在echo-area显示已经击入的键")
 '(visible-bell t
                nil ()
                "响铃可视化.在Windows上表现为,任务栏图标闪烁")
 '(table-fixed-width-mode nil
                          nil (table)
                          "基于文本的表格自动调节尺寸")
 '(inhibit-startup-screen t
                          nil ()
                          "取消原本的 startup screen")
 '(initial-scratch-message #(";;     *
;;      May the Code be with You!
;;     .                                 .
;;                               *
;;          /\\/|_      __/\\\\
;;         /    -\\    /-   ~\\  .              \\='
;;         \\    = Y =T_ =   /
;;          )==*(\\=`     \\=`) ~ \\
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
\n"
                             0 671 (font-lock-face (:foreground "VioletRed1"))))
 '(insert-default-directory t
                            nil (minibuffer)
                            "‘find-file’时,给出默认目录")
 '(integer-width (* 8 16)
                 nil ()
                 "bignum的位宽")
 '(line-move-visual t
                    nil (simple)
                    "按照screen line上下移动")
 '(line-number-mode nil
                    nil (simple)
                    "mode-line不显示行号")
 '(max-mini-window-height 0.3
                          nil ()
                          "minubuffer最大高度占比(float)/绝对高度(int)")
 '(message-log-max t
                   nil ()
                   "对于“*Messages*”的最大行数,不做限制")
 '(minibuffer-depth-indicate-mode t
                                  nil (mb-depth)
                                  "显示minibuffer的深度(e.g.,“[2] Describe function: ”).(文档说仅当‘enable-recursive-minibuffers’非nil时,该变量有效,但是实际上试验结果是:都有效)")
 '(minibuffer-eldef-shorten-default t
                                    nil (minibuf-eldef)
                                    "将minibuffer的prompt的默认值提示字符串改成[default-arg]的形式,以节约屏幕面积.(生效的前提是打开‘minibuffer-electric-default-mode’,然而,这个模式下,输入任何字符后,就会隐藏默认值(改变prompt的长度),光标会瞬间向前移动,所以拒绝使用它,那么这个变量是无效变量)")
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
                            "HTML可能会有很深的嵌套,因此需要更多的PDL.该变量决定自动增长PDL的大小")
 '(shift-select-mode t
                     nil (simple)
                     "按住SHIFT时移动光标,以选中文本")
 '(read-buffer-completion-ignore-case t
                                      nil ()
                                      "对buffer名字进行补全时,忽略大小写")
 '(read-extended-command-predicate #'command-completion-default-include-p
                                   nil (simple))
 '(read-file-name-completion-ignore-case read-file-name-completion-ignore-case
                                         nil (minibuffer)
                                         "对文件路径进行补全时,是否忽略大小写(系统相关的)")
 '(read-quoted-char-radix 16
                          nil (simple)
                          "“C-q”后接16进制")
 '(resize-mini-windows t
                       nil ()
                       "minibuffer可以变宽变窄,由输入的字符串的行数决定")
 '(resize-mini-frames #'fit-frame-to-buffer
                      nil ()
                      "trim首尾的空行")
 '(inhibit-startup-echo-area-message user-login-name
                                     nil ()
                                     "只有将该变量设置为自己在OS中的username,才能屏蔽startup时echo area的“For information about GNU Emacs and the GNU system, type C-h C-a.”")
 '(save-place-file (shynur/pathname-~/.emacs.d/.shynur/
                    "save-place-file.el")
                   nil (saveplace))
 '(save-place-mode t
                   nil (saveplace)
                   "在session之间保存访问文件时的浏览位置")
 '(scroll-bar-mode 'right
                   nil (scroll-bar))
 '(kill-read-only-ok nil
                     nil (simple)
                     "kill只读的文本时,beep且显示error消息")
 '(kill-transform-function (lambda (string)
                             (and (not (string-blank-p string))
                                  string))
                           nil (simple)
                           "将它应用到被kill的文本上,并将其返回值加入到‘kill-ring’中;若返回nil则不加入.(该例选自<https://www.gnu.org/software/emacs/manual/html_node/emacs/Kill-Options.html>)")
 '(kill-do-not-save-duplicates t
                               nil (simple)
                               "kill重复的文本时,不将其加入到‘kill-ring’中(具体行为受‘equal-including-properties’影响)")
 '(size-indication-mode t
                        nil (simple)
                        "mode-line显示buffer大小(k=10^3,M=10^6,...)")
 '(hscroll-margin 5)
 '(hscroll-step 1)
 '(suggest-key-bindings most-positive-fixnum
                        nil (simple)
                        "_1_通过函数名调用command时,在minibuffer中提示这个command可能绑定的快捷键;_2_决定‘extended-command-suggest-shorter’的显示持续时间;_3_将前面这两个提示信息持续显示5秒;_4_使command候选词列表中,各函数名的后面显示该函数绑定的快捷键")
 '(temporary-file-directory (let ((temporary-file-directory (shynur/pathname-~/.emacs.d/.shynur/
                                                             "temporary-file-directory/")))
                              (make-directory temporary-file-directory t)
                              temporary-file-directory))
 '(text-quoting-style nil
                      nil ()
                      "渲染成对的单引号时,尽可能使用‘curve’这种样式,退而求此次地可以使用`grave'这种样式")
 '(track-eol nil
             nil (simple)
             "上下移动时,不紧贴行尾")
 '(apropos-do-all nil
                  nil (apropos)
                  "有些apropos命令,在提供prefix参数时,会扩大查找范围.如果该变量为t,则即使不提供prefix参数,apropos命令也仍然会扩大查找范围")
 '(on-screen-global-mode t
                         nil (on-screen)
                         "在scroll时提示_刚刚的/接下来新增的_visible区域,以防止迷失方向")
 '(on-screen-inverse-flag t
                          nil (on-screen)
                          "令‘on-screen-global-mode’提示刚刚的visible区域")
 '(on-screen-highlight-method (nth 1 '(fringe shadow line narrow-line))
                              nil (on-screen)
                              "决定‘on-screen-global-mode’如何提示")
 '(fast-but-imprecise-scrolling t
                                nil ()
                                "scroll时假定滚过的文本有default face,从而避免fontify它们.当那些滚过的文本的size不一致时,可能导致终点位置有偏差")
 '(jit-lock-defer-time 0.3
                       nil (jit-lock)
                       "scroll之后延迟多久再fontify文本")
 '(redisplay-skip-fontification-on-input t)
 '(recenter-redisplay recenter-redisplay
                      nil ()
                      "如果recenter时不redraw整个frame,则可能造成TUI屏幕有少许显示错误.使用默认值即可")
 '(hi-lock-auto-select-face t
                            nil (hi-lock)
                            "每次‘highlight-regexp’自动选择且尽量使用不同的face")
 '(hi-lock-file-patterns-policy 'always
                                nil (hi-lock)
                                "‘hi-lock-mode’下可使用‘hi-lock-write-interactive-patterns’将当时的高亮配置以注释的形式写下来,以供以后访问时用‘hi-lock-find-patterns’再次应用它们.将该变量置为t,则打开‘hi-lock-mode’时自动抽取并应用它们")
 '(apropos-sort-by-scores 'verbose
                          nil (apropos))
 '(apropos-documentation-sort-by-scores 'verbose
                                        nil (apropos))
 '(uniquify-buffer-name-style 'forward
                              nil (uniquify)
                              "当buffer对应的文件名相同时,在buffer名字之前补全文件的路径,使buffer的名字互异(行为上的细节受‘uniquify-strip-common-suffix’影响)")
 '(uniquify-strip-common-suffix t
                                nil (uniquify)
                                "当‘uniquify-buffer-name-style’的设置涉及补全文件路径时,保留显示路径名之间相同的部分")
 '(url-cache-directory (shynur/pathname-~/.emacs.d/.shynur/
                        "url-cache-directory/")
                       nil (url-cache))
 '(url-cookie-file (shynur/pathname-~/.emacs.d/.shynur/
                    "url-cookie-file")
                   nil (url-cookie))
 '(user-full-name "谢骐")
 '(user-mail-address "one.last.kiss@outlook.com"
                     nil ()
                     "用户的email")
 '(blink-cursor-mode nil
                     nil (frame))
 '(blink-cursor-delay 0
                      nil (frame)
                      "cursor开始闪烁的时间点")
 '(blink-cursor-blinks 0
                       nil (frame)
                       "如果打开‘blink-cursor-mode’的话,停止输入后cursor会闪烁一定次数,然后静止")
 '(blink-cursor-alist '((box  . nil)
                        (bar  . box)
                        (hbar . bar))
                      nil ()
                      "当设置‘cursor-type’时,将会根据此alist设置光标黯淡时的type")
 '(blink-cursor-interval 0.5
                         nil (frame)
                         "cursor闪烁的时间间隔")
 '(visible-cursor t
                  nil ()
                  "在TUI下,如果有可能的话,使cursor外形或特征更加显著(通常是blinking)")
 '(what-cursor-show-names t
                          nil (simple)
                          "使“C-x =”(‘what-cursor-position’)顺便显示字符的Unicode名字")
 '(cursor-type 'box
               nil ()
               "GUI下的cursor的静态图标")
 '(cursor-in-non-selected-windows t
                                  nil ()
                                  "未选择的window中的cursor显示为静态镂空框")
 '(Info-mode-hook `(,@Info-mode-hook
                    ,(lambda ()
                       "单词之间换行"
                       (visual-line-mode))))
 '(help-mode-hook `(,@help-mode-hook
                    ,(lambda ()
                       "单词之间换行"
                       (visual-line-mode))))
 '(visual-line-fringe-indicators '(nil down-arrow)
                                 nil (simple)
                                 "word-wrap打开时在换行处显示down-arrow")
 '(global-company-mode t
                       nil (company))
 '(company-idle-delay 0
                      nil (company))
 '(company-tooltip-offset-display 'lines
                                  nil (company)
                                  "原本在候选词界面的右侧是由scroll bar的,现在改成:提示前面和后面分别有多少候选词")
 '(on-screen-delay 0.4
                   nil (on-screen)
                   "on-screen的提示持续时间")
 '(company-minimum-prefix-length 2
                                 nil (company)
                                 "当输入2个字符时,company就开始猜测")
 '(company-dabbrev-code-everywhere t
                                   nil (company)
                                   "还在comment和string中进行completion")
 '(company-dabbrev-code-other-buffers t
                                      nil (company)
                                      "在具有相同major mode的buffer中搜索候选词")
 '(company-dabbrev-code-time-limit 2
                                   nil (company)
                                   "在current buffer中搜索代码块中的关键词的时间限制")
 '(company-show-quick-access t
                             nil (company)
                             "给候选词编号")
 '(company-tooltip-limit 10
                         nil (company)
                         "一次性显示候选词的数量")
 '(company-clang-executable (pcase (system-name)
                              ("ASUS-TX2" "d:/Progs/LLVM/bin/clang.exe"))
                            nil (company))
 '(next-screen-context-lines 5
                             nil ()
                             "scroll以使window底端的N行呈现到顶端")
 '(w32-mouse-button-tolerance w32-mouse-button-tolerance
                              nil ()
                              "如果鼠标的3个案件中有一个失灵了,可以在这么多毫秒内同时按下其余两个键,Emacs会将其识别为失灵的那个键")
 '(w32-swap-mouse-buttons nil
                          nil ()
                          "是否交换鼠标的中键和右键")
 '(dimmer-mode t
               nil (dimmer)
               "暗淡非聚焦状态的window(似乎可以设置渐变色)")
 '(scroll-error-top-bottom nil
                           nil (window)
                           "无法再scroll时停住,而不是继续移动point")
 '(global-highlight-parentheses-mode t
                                     nil (highlight-parentheses)
                                     "给内层括号换种颜色")
 '(sentence-end-double-space t)
 '(sentence-end-without-period nil)
 '(colon-double-space nil)
 '(prog-mode-hook `(,@prog-mode-hook
                    ,(lambda ()
                       (rainbow-mode))
                    ,(lambda ()
                       (rainbow-delimiters-mode))
                    ,(lambda ()
                       (eldoc-mode)))
                  nil (prog-mode)
                  "e.g.,让“#ffffff”显示白色")
 '(hs-hide-comments-when-hiding-all t
                                    nil (hideshow))
 '(hs-isearch-open t
                   nil (hideshow))
 '(scroll-bar-width 28)
 '(initial-buffer-choice t
                         nil ()
                         "启动时转向该buffer(t在这里表示“*scratch*”)")
 '(maximum-scroll-margin 0.5
                         nil ())
 '(scroll-margin 1
                 nil ()
                 "相当于,光标不会到达的边缘地带的宽度(单位是screen line);占window的最大比例为‘maximum-scroll-margin’")
 '(scroll-conservatively most-positive-fixnum
                         nil ())
 '(scroll-minibuffer-conservatively t
                                    nil ()
                                    "对于minibuffer,永远是一行一行地automatically scroll")
 '(ivy-count-format "%d/%d "
                    nil (ivy))
 '(ivy-height 6
              nil (ivy)
              "准确来说是最大高度")
 '(minibuffer-setup-hook `(,@minibuffer-setup-hook
                           ,(lambda ()
                              "令ivy的minibuffer拥有自适应高度"
                              (add-hook 'post-command-hook
                                        (lambda ()
                                          (when (progn
                                                  (require 'ivy)
                                                  ivy-mode)
                                            (shrink-window (1+ (progn
                                                                 (require 'ivy)
                                                                 ivy-height)))))
                                        nil
                                        t))))
 '(calendar-mark-holidays-flag t
                               nil (calendar))
 '(prettify-symbols-alist '(("lambda" . ?λ)
                            ("<="     . ?≤)
                            (">="     . ?≥)
                            ("::"     . ?∷)
                            ("->"     . ?→))
                          nil (prog-mode)
                          "此为默认值,不生效;仅供buffer-local时使用")
 '(prettify-symbols-unprettify-at-point nil
                                        nil (prog-mode))
 '(display-hourglass t
                     nil ()
                     "当Emacs是busy时,将鼠标指针显示为漏斗")
 '(hourglass-delay 0
                   nil ()
                   "当Emacs进入busy状态时,立刻将鼠标指针显示为漏斗(而不是过一段时间再显示)")
 '(make-pointer-invisible nil
                          nil ()
                          "原本用户typing时鼠标指针会被隐藏,但现在可以用‘mouse-avoidance-mode’达到更好的效果")
 '(mouse-avoidance-mode nil
                        nil (avoid)
                        "目前有bug")
 '(overline-margin 0
                   nil ()
                   "上划线的高度+宽度")
 '(display-raw-bytes-as-hex t
                            nil ()
                            "若不启用‘ctl-arrow’,则“\x80”而非“\200”")
 '(mouse-highlight t
                   nil ()
                   "当鼠标位于clickable位置时,高亮此处的文本")
 '(global-highlight-changes-mode t
                                 nil (hilit-chg))
 '(highlight-changes-visibility-initial-state nil
                                              nil (hilit-chg))
 '(python-shell-interpreter (pcase (system-name)
                              ("ASUS-TX2" "python" )
                              (_          "python3"))
                            nil (python))
 '(python-shell-interpreter-interactive-arg nil
                                            nil (python))
 '(eval-expression-debug-on-error t
                                  nil (simple)
                                  "在‘eval-expression’时暂时地将‘debug-on-error’设置为t")
 '(debug-on-quit nil
                 nil ()
                 "按下“C-g”时是否要进入debugger")
 '(bookmark-default-file (shynur/pathname-~/.emacs.d/.shynur/
                          "bookmark-default-file.el")
                         nil (bookmark))
 '(bookmark-save-flag 1
                      nil (bookmark)
                      "每次保存bookmark时都会写进文件")
 '(bookmark-use-annotations t
                            nil (bookmark)
                            "保存/转向bookmark时,请求书写 / 在另一个window显示 备注信息")
 '(bookmark-search-size bookmark-search-size
                        nil (bookmark)
                        "文件在被bookmark记录之后可能会有改动,bookmark可以记住它的上下文以对应这种情况.该变量决定上下文的长度")
 '(pulse-delay 0.125
               nil (pluse))
 '(pulse-iterations 32
                    nil (pulse))
 '(comint-completion-addsuffix '("/" . " ")
                               nil (comint)
                               "‘shell-mode’对pathname补全时,在pathname之后添加的字符串.(e.g., cat+.emacs.d/init.el+该变量的值)")
 '(comint-process-echoes (pcase system-type
                           ('windows-nt t                    )
                           (_           comint-process-echoes))
                         nil (comint)
                         "Windows上的PowerShell会回显输入的命令(至少在‘shell-mode’中是这样),设置此变量以删除它")
 '(selection-coding-system selection-coding-system
                           nil (select)
                           "与X/Windows交互clipboard时的编码/解码方式")
 '(list-colors-sort nil
                    nil (facemenu)
                    "决定‘list-colors-display’如何排列颜色")
 '(use-empty-active-region nil
                           nil (simple)
                           "有些命令的行为取决于是否有active region.  Region长度为0时应该让那些命令无视region,因为用户很难识别长度为0的region")
 '(delete-active-region t
                        nil (simple)
                        "当region是active时,删除命令删除整个region而非单个字符")
 '(set-mark-command-repeat-pop nil
                               nil (simple)
                               "置t的话,轮流跳转到‘mark-ring’中指定的位置时,只有第一次需要加‘C-u’前缀,后续全部只需要‘C-SPC’即可")
 '(mark-even-if-inactive nil)
 '(server-auth-dir (shynur/pathname-~/.emacs.d/.shynur/
                    "server-auth-dir/")
                   nil (server))
 '(server-socket-dir (shynur/pathname-~/.emacs.d/.shynur/
                      "server-socket-dir/")
                     nil (server))
 '(server-name "server-name.txt"
               nil (server))
 '(register-preview-delay 0
                          nil (register)
                          "调用读写register的命令时,预览已赋值的register,0延迟")
 '(mouse-autoselect-window nil
                           nil ()
                           "当鼠标在一个frame上移动时,并不根据鼠标的位置自动选择window,以防鼠标突然被碰撞导致选中其它window")
 '(help-char ?\C-h
             nil ()
             "默认是“C-h”")
 '(scroll-preserve-screen-position nil
                                   nil ()
                                   "若非nil,则scroll时(尤其是鼠标滚轮)保持point在屏幕上的位置,但这样会扯坏region")
 '(frame-background-mode t
                         nil (frame)
                         "让Emacs根据当前背景颜色(light/dark)自动选择应该呈现的face属性")
 '(text-scale-mode-step text-scale-mode-step
                        nil (face-remap)
                        "放缩字体大小时的倍率")
 '(after-init-hook `(,@after-init-hook
                     ,(lambda ()
                        (setq user-init-file (shynur/pathname-~/.emacs.d/.shynur/
                                              "user-init-file.el")))))
 '(emacs-startup-hook `(,@emacs-startup-hook
                        ,(lambda ()
                           (other-window 1)
                           (delete-other-windows))
                        ,(lambda ()
                           (when (daemonp)
                             (pcase (system-name)
                               ("ASUS-TX2" (shell-command "start c:/WINDOWS/system32/Taskmgr.exe /0")))))
                        ,(lambda ()
                           "记录击键(bug#62277)"
                           (lossage-size (* 10000 10)))
                        ,(lambda ()
                           (prefer-coding-system 'utf-8-unix)
                           (set-coding-system-priority 'utf-8-unix))
                        ,(lambda ()
                           "[menu-bar]->[File]->[Filesets]"
                           (filesets-init))
                        ,(lambda ()
                           (shynur/buffer-eval-after-created "*scratch*"
                             (with-current-buffer "*scratch*"
                               (setq-local prettify-symbols-alist (default-value 'prettify-symbols-alist))
                               (prettify-symbols-mode)
                               (setq-local default-directory (pcase (system-name)
                                                               ("ASUS-TX2" "d:/Downloads/Tmp/")
                                                               (_          "~/"               ))))))
                        ,(lambda ()
                           (let ((shynur/machine.el "~/.emacs.d/shynur/machine.el"))
                             (when (file-exists-p shynur/machine.el)
                               (load-file shynur/machine.el))))
                        ,(lambda ()
                           (display-time-mode)
                           (display-battery-mode))
                        ,(lambda ()
                           (progn
                             (require 'register)
                             ;;见‘register-separator’
                             (set-register (progn
                                             (require 'register)
                                             register-separator) "\n\n")
                             (set-register ?i '(file . "~/.emacs.d/init.el"))))
                        ,(lambda ()
                           "调节beep的声音种类,而不是音量"
                           (set-message-beep nil))
                        ,(lambda ()
                           "解决‘mouse-drag-and-drop-region’总是copy的问题(bug#63872)"
                           (advice-add (prog1 'mouse-drag-and-drop-region
                                         (require 'mouse)) :around
                                         (lambda (mouse-drag-and-drop-region_ &rest arguments)
                                           (let ((mark-even-if-inactive t))
                                             (apply mouse-drag-and-drop-region_ arguments)))))
                        ,(lambda ()
                           (message (shynur/message-format #("启动耗时[%.1f]s"
                                                             5 9 (face bold)))
                                    (/ (- (car (time-convert after-init-time 1000))
                                          (car (time-convert before-init-time 1000)))
                                       1000.0)))))
 '(makefile-gmake-mode-hook `(,@(bound-and-true-p 'makefile-gmake-mode-hook)
                              ,(lambda ()
                                 (indent-tabs-mode)))
                            nil (make-mode))
 '(tooltip-delay 0
                 nil (tooltip))
 '(tooltip-mode t
                nil (tooltip))
 '(tooltip-short-delay 0
                       nil (tooltip))
 '(tooltip-hide-delay most-positive-fixnum
                      nil (tooltip))
 '(tooltip-frame-parameters tooltip-frame-parameters
                            nil (tooltip))
 '(doom-modeline-mode t
                      nil (doom-modeline all-the-icons))
 '(doom-modeline-minor-modes t
                             nil (doom-modeline))
 '(doom-modeline-window-width-limit nil
                                    nil (doom-modeline)
                                    "即使当前窗口宽度很小,也尽量显示所有信息")
 '(doom-modeline-bar-width 3
                           nil (doom-modeline)
                           "doom-modeline左侧小竖条的宽度(装饰品)")
 '(doom-modeline-height 1
                        nil (doom-modeline))
 '(inferior-lisp-program (pcase (system-name)
                           ("ASUS-TX2" "d:/Progs/Steel_Bank_Common_Lisp/sbcl.exe")
                           (_          inferior-lisp-program                     ))
                         nil (sly))
 '(save-interprogram-paste-before-kill t
                                       nil (simple)
                                       "因‘kill-do-not-save-duplicates’导致‘kill-ring’只保留了不重复的文本,所以大可放心置t")
 '(yank-pop-change-selection nil
                             nil (simple)
                             "“M-y”不改变clipboard的内容")
 '(help-at-pt-display-when-idle t
                                nil (help-at-pt)
                                "光标移到active-text处时,在echo-area显示tooltip")
 '(help-at-pt-timer-delay 0
                          nil (help-at-pt)
                          "让‘help-at-pt-display-when-idle’的效果没有延迟")
 '(x-stretch-cursor t
                    nil ()
                    "在tab字符上拉长显示cursor")
 '(shell-mode-hook `(,@shell-mode-hook
                     ,(lambda ()
                        "设置编码"
                        (pcase (system-name)
                          ("ASUS-TX2" (set-buffer-process-coding-system 'chinese-gb18030 'chinese-gb18030))))
                     ,(lambda ()
                        "设置shell"
                        (pcase (system-name)
                          ("ASUS-TX2" (make-thread (lambda ()
                                                     (let ((attempts 100000))
                                                       (while (and (natnump attempts)
                                                                   (length> "Microsoft Windows" (buffer-size)))
                                                         (thread-yield)
                                                         (cl-decf attempts)))
                                                     (when (save-excursion
                                                             (re-search-backward "Microsoft Windows"))
                                                       (execute-kbd-macro [?p ?o ?w ?e ?r ?s ?h ?e ?l ?l ?\C-m]))))))))
                   nil (shell))
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
 '(which-key-mode t
                  nil (which-key))
 '(font-lock-maximum-decoration t
                                nil (font-lock)
                                "不限制fontification的数量")
 '(fill-column 70)
 '(comment-column 0
                  nil (newcomment)
                  "“M-;”时comment的左边界")
 '(comment-fill-column 80
                       nil (newcomment))
 '(adaptive-fill-mode t
                      nil ()
                      "“M-q”时自动选择每行首的填充前缀")
 '(text-mode-hook `(,@text-mode-hook
                    ,(lambda ()
                       (when (eq major-mode 'text-mode)
                         (display-fill-column-indicator-mode)))))
 '(c-mode-common-hook `(,@c-mode-common-hook
                        ,(lambda ()
                           (c-set-offset 'case-label '+))
                        ;;只保留当前编译环境下,生效的ifdef从句
                        ,(lambda ()
                           (hide-ifdef-mode)))
                      nil (cc-mode))
 '(c-basic-offset 4
                  nil (cc-mode))
 '(c-default-style '((awk-mode . "awk" )
                     (other    . "java"))
                   nil (cc-mode))
 '(c-tab-always-indent t
                       nil (cc-mode))
 '(c-mode-common-hook `(,@(bound-and-true-p 'c-mode-common-hook)
                        ,(lambda ()
                           "换行不够智能"
                           (c-toggle-auto-newline -1))
                        ,(lambda ()
                           "键入特定字符后,自动缩进当前行"
                           (c-toggle-electric-state 1)))
                      nil (cc-mode))
 '(c-initialization-hook `(,@(bound-and-true-p 'c-initialization-hook)
                           ,(lambda ()
                              "写C宏时换行自动加反斜线;写注释时换行相当于“M-j”(‘c-indent-new-comment-line’)"
                              (define-key c-mode-base-map "\C-m"
                                #'c-context-line-break)))
                         nil (cc-mode))
 '(comment-multi-line t
                     nil (newcomment)
                     "“M-j”时,“/* lines */”而不是“/* */ \n /* */”")
 '(blink-matching-paren t
                        nil (simple)
                        "功能之一是在echo area显示匹配的paren")
 '(show-paren-mode t
                   nil (paren))
 '(show-paren-delay 0.1
                    nil (paren))
 '(show-paren-highlight-openparen t
                                  nil (paren)
                                  "光标位于左paren上“.(...)时,高亮左paren")
 '(show-paren-style 'parenthesis
                    nil (paren)
                    "只高亮两个paren")
 '(show-paren-when-point-in-periphery nil
                                      nil (paren)
                                      "当光标置于sexp周边的空白区域时")
 '(electric-pair-mode t
                      nil (elec-pair))
 '(electric-pair-preserve-balance t
                                  nil (elec-pair)
                                  "若nil,会出现这种情况“(((()”")
 '(electric-pair-delete-adjacent-pairs t
                                       nil (elec-pair)
                                       "当成对的两个paren邻接时,删左paren时,同步地删除右paren")
 '(electric-pair-open-newline-between-pairs t
                                            nil (elec-pair)
                                            "“{RET}”=>“{newline newline}”.(可考虑‘electric-layout-mode’作为替代方案:键入左paren自动补充右paren并换两行)")
 '(lisp-data-mode-hook `(,@(bound-and-true-p 'lisp-data-mode-hook)
                         ,(lambda ()
                            (setq-local electric-pair-open-newline-between-pairs nil))))
 '(display-fill-column-indicator-column t
                                        nil (display-fill-column-indicator)
                                        "默认值参考fill-column")
 '(display-fill-column-indicator-character ?\N{BOX DRAWINGS LIGHT VERTICAL}
                                           nil (display-fill-column-indicator))
 '(indicate-buffer-boundaries nil
                              nil ()
                              "控制是否在fringe所在的区域上显示首尾指示符(window的四个边角区域)")
 '(repeat-mode t
               nil (repeat))
 '(selective-display-ellipses t
                              nil ()
                              "selective-display会在行尾显示“...”表示省略")
 '(ctl-arrow t
             nil ()
             "用“^A”表示法(而非“\001”或“\x01”)打印raw-byte(e.g.,“C-q”后接的字符)")
 '(nobreak-char-display t
                        nil ()
                        "将容易与ASCII字符中的几个混淆的Unicode字符使用特殊的face渲染(non-boolean在此基础上加上前缀backslash)")
 '(default-input-method "chinese-py")
 '(input-method-highlight-flag t)
 '(input-method-verbose-flag t)
 '(line-spacing nil
                nil ()
                "行距")
 '(minibuffer-message-timeout nil
                              nil ()
                              "使‘minibuffer-message’的行为有点像‘message’")
 '(case-fold-search t
                    nil ()
                    "search/match时忽略大小写(经试验,isearch仅在给定模式串全部是小写时忽略大小写);影响函数:‘char-equal’;无关函数:‘string=’")
 '(isearch-resume-in-command-history nil
                                     nil (isearch)
                                     "isearch将不会出现在‘command-history’中")
 '(search-default-mode t
                       nil (isearch)
                       "令isearch使用regexp搜索")
 '(swiper-include-line-number-in-search nil
                                        nil (swiper))
 '(isearch-lazy-highlight t
                          nil (isearch)
                          "除了当前光标附近的match,还(使用‘lazy-highlight’face)高亮其它的matches")
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
                      "给‘lazy-count-prefix-format’和‘lazy-count-suffix-format’匹配串的current/total值(当前是第几个,一共匹配了多少个)")
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
                      "比如,键入“C-a”会聚焦于pattern,并可以编辑它")
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
                                    "此处motion指的是‘isearch-allow-motion’中的motion")
 '(isearch-yank-on-move nil
                        nil (isearch)
                        "一种编辑搜索字符串的方式,不是很有用")
 '(search-whitespace-regexp "[[:space:]\n]+"
                            nil (isearch)
                            "如果在‘isearch-*-regexp’中开启了‘isearch-toggle-lax-whitespace’的话,键入SPC会匹配的字符")
 '(search-highlight t
                    nil (isearch))
 '(search-highlight-submatches t
                               nil (isearch)
                               "用一组face(‘isearch-group-*’)分别高亮子表达式匹配成功的串")
 '(char-fold-symmetric t
                       nil (char-fold)
                       "搜索时,e.g.,(如果提前设置了‘char-fold-include’)字符a与ä和á等是等价的")
 '(replace-char-fold t
                     nil (char-fold))
 '(replace-lax-whitespace t
                          nil (replace))
 '(replace-regexp-lax-whitespace nil
                                 nil (replace))
 '(query-replace-from-to-separator "修改为"
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
                                             "不需要‘occur’在“*Occur*”中列出匹配行的上下文")
 '(list-matching-lines-jump-to-current-line t
                                            nil (replace)
                                            "在“*Occur*”中显示调用‘occur’之前的那一行,并用‘list-matching-lines-current-line-face’高亮之(方便找到回家的路)")
 '(outline-minor-mode-cycle [tab ?\S-\t]
                            nil (outline))
 '(outline-minor-mode-prefix [nil]
                             nil (outline))
 '(occur-mode-hook `(,@occur-mode-hook
                     ,(lambda ()
                        (progn
                          (require 'display-line-numbers)
                          (display-line-numbers-mode -1))))
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
                                "“C-u F3”:附加定义;“C-u C-u ... F3”:重执行且附加定义")
 '(kmacro-ring-max most-positive-fixnum
                   nil (kmacro))
 '(temp-buffer-resize-mode t
                           nil (help)
                           "e.g.,使“*Completions*”不会几乎占用整个frame")
 `(safe-local-variable-values ',(let ((safe-local-variable-values (list)))
                                  (named-let get-vars ((dir-locals (with-temp-buffer
                                                                     (insert-file-contents "~/.emacs.d/.dir-locals.el")
                                                                     (read (current-buffer)))))
                                    (dolist (mode-vars dir-locals)
                                      (let ((vars (cdr mode-vars)))
                                        (if (stringp (car mode-vars))
                                            (get-vars vars)
                                          (dolist (var-pair vars)
                                            (push var-pair safe-local-variable-values))))))
                                  safe-local-variable-values)
                              nil (files))
 '(enable-local-variables t
                          nil (files)
                          "尽量不询问,但提供记忆功能(可能会修改‘custom-file’的文件内容)")
 '(enable-dir-local-variables t
                              nil (files))
 '(enable-remote-dir-locals t
                            nil (files)
                            "远程时也向上寻找“.dir-locals.el”以应用directory local变量")
 '(imenu-auto-rescan t
                     nil (imenu))
 '(imenu-sort-function #'imenu--sort-by-name
                       nil (imenu))
 '(which-function-mode t
                       nil (which-func))
 '(confirm-kill-processes nil
                          nil (files)
                          "退出时,不询问是否要kill子进程")
 '(require-final-newline t
                         nil (files))
 '(before-save-hook `(,@before-save-hook
                      ,(lambda ()
                         (whitespace-cleanup))
                      ,(lambda ()
                         (time-stamp)))
                    nil (files))
 '(large-file-warning-threshold 1000000
                                nil (files)
                                "打开达到该字节数的大文件时询问相关事宜;重点在于可以借此开启literally读取模式,这会关闭一些昂贵的功能,以提高访问速度")
 '(find-file-wildcards t
                       nil (files)
                       "允许Bash style的路径通配符")
 '(confirm-kill-emacs nil
                      nil (files)
                      "退出时,不询问“Really exit Emacs?”")
 '(confirm-nonexistent-file-or-buffer 'after-completion
                                      nil (files)
                                      "‘switch-to-buffer’或‘find-file’时,输入前缀并按下TAB后,若有多个候选者但仍然RET,会再确认一遍")
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
                             "默认情况下‘auto-revert-mode’同时使用被动的OS级file-notification和主动的poll(poll在编辑remote-file时无可替代),该变量关闭polling")
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
 '(auto-save-list-file-prefix (shynur/pathname-~/.emacs.d/.shynur/
                               "auto-save-list/"))
 '(auto-save-no-message nil)
 '(delete-auto-save-files t
                          nil ()
                          "“C-x C-s”会自动删除auto-save-file")
 '(kill-buffer-delete-auto-save-files nil)
 '(auto-save-default t
                     nil (files)
                     "Emacs在发生致命错误(e.g.,“kill %emacs”)时会直接触发auto-save")
 '(list-directory-brief-switches "-C --classify"
                                 nil (files))
 '(list-directory-verbose-switches "-1 --almost-all --author --color=auto --classify --format=verbose --human-readable --size --sort=extension --time-style=long-iso"
                                   nil (files))
 '(delete-by-moving-to-trash t)
 '(copy-directory-create-symlink nil
                                 nil (files)
                                 "制作symlink的话请使用‘make-symbolic-link’")
 '(view-read-only nil
                  nil (files)
                  "键入[C-x C-q]使buffer成为read-only时,不必开启‘view-mode’")
 '(tramp-mode t
              nil (tramp)
              "若置nil,直接关闭remote-filename识别")
 '(tramp-persistency-file-name (shynur/pathname-~/.emacs.d/.shynur/
                                "tramp-persistency-file-name.el")
                               nil (tramp-cache))
 '(tramp-auto-save-directory (shynur/pathname-~/.emacs.d/.shynur/
                              "tramp-auto-save-directory/")
                             nil (tramp))
 '(recentf-mode t
                nil (recentf))
 '(recentf-save-file (shynur/pathname-~/.emacs.d/.shynur/
                      "recentf-save-file.el")
                     nil (recentf))
 '(filesets-menu-cache-file (shynur/pathname-~/.emacs.d/.shynur/
                             "filesets-menu-cache-file.el")
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
 '(x-underline-at-descent-line nil)
 '(x-use-underline-position-properties t)
 '(underline-minimum-offset 0
                            nil ()
                            "underline向下偏移baseline(相当于英语四线三格的3th线)的像素数")
 '(select-enable-clipboard t
                           nil (select)
                           "允许与clipboard交互")
 '(x-select-enable-clipboard-manager nil
                                     nil ()
                                     "Emacs退出时不需要将‘kill-ring’转交给clipboard")
 '(select-enable-primary nil
                         nil (select)
                         "置t则说明不使用clipboard")
 '(mouse-drag-copy-region nil
                          nil (mouse)
                          "不自动复制鼠标拖选的region")
 '(x-mouse-click-focus-ignore-position nil)
 '(focus-follows-mouse nil
                       nil ()
                       "告诉Emacs当前window manager通过鼠标指针选择聚焦窗口的方式,因为Emacs无法自动侦window manager使用何种策略")
 '(mouse-scroll-min-lines 1
                          nil (mouse)
                          "按下左键拖动鼠标选中文本时,鼠标指针离开window边缘后会自动滚屏.一次最少滚动一行")
 '(mouse-yank-at-point t
                       nil (mouse)
                       "<mouse-2>只yank而不移动point")
 '(mouse-wheel-mode t
                    nil (mwheel))
 '(mouse-wheel-follow-mouse t
                            nil (mwheel))
 '(mouse-wheel-progressive-speed t
                                 nil (mwheel))
 '(mouse-wheel-scroll-amount-horizontal 1
                                        nil (mwheel))
 '(mouse-wheel-tilt-scroll t
                           nil (mwheel))
 '(mouse-select-region-move-to-beginning nil
                                         nil (mouse)
                                         "在开/闭括号处双击左键,point自动移动到闭括号处")
 '(mouse-1-click-follows-link 400
                              nil (mouse)
                              "在button/hyperlink上点击,不放开鼠标按键持续一定毫秒数后,将仅设置point而不循入链接")
 '(mouse-1-click-in-non-selected-windows t
                                         nil (mouse)
                                         "点击non-selected-window中的button/hyperlink同样会循入链接")
 '(scroll-bar-adjust-thumb-portion nil
                                   nil ()
                                   "滚动条落至底部(overscrolling)时的行为")
 '(kill-transform-function (lambda (killed-string)
                             "若被复制的文本全部由whitespace组成,则直接返回;否则,trim首尾的whitespace"
                             (if (string-blank-p killed-string)
                                 killed-string
                               (string-trim killed-string)))
                           nil (simple))
 '(window-divider-default-places 'right-only
                                 nil (frame))
 '(window-divider-default-right-width 12
                                      nil (simple)
                                      "scroll bar的宽度")
 '(window-divider-mode t
                       nil (frame)
                       "在window的周围显示拖动条,用来调整window的长和宽.(横向拖动条可以用mode-line代替,所以只需要纵向拖动条,据此设置‘window-divider-default-places’为right-only)(‘window-divider-default-right-width’决定拖动条的宽度)")
 '(dnd-open-file-other-window nil
                              nil (dnd))
 '(mouse-drag-and-drop-region t
                              nil (mouse))
 '(mouse-drag-and-drop-region-cut-when-buffers-differ t
                                                      nil (mouse))
 '(mouse-drag-and-drop-region-show-tooltip 100
                                           nil (mouse))
 '(tool-bar-mode t)
 '(tool-bar-style 'both)
 '(use-dialog-box t)
 '(use-file-dialog t)
 '(x-gtk-show-hidden-files t
                           nil ()
                           "在GTK+的file-chooser-dialog中显示隐藏文件"))

(letrec ((shynur--custom-set-faces (lambda ()
                                     "daemon-client运行在同一个机器上,只需要在一个client进程中执行‘custom-set-faces’,其余(以及后续)的client都能生效"
                                     (custom-set-faces
                                      `(default
                                         ((t . ( :font ,(pcase (system-name)
                                                          ("ASUS-TX2" "Maple Mono SC NF-12:slant:weight=medium:width=normal:spacing")
                                                          (_          "Courier New-10"                                              ))
                                                 :foundry "outline"))))
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
                                     (remove-hook 'server-after-make-frame-hook shynur--custom-set-faces))))
  (add-hook 'server-after-make-frame-hook shynur--custom-set-faces))

(global-unset-key (kbd "C-h C-c"))
(global-unset-key (kbd "C-h g"))
(global-unset-key (kbd "C-h h"))
(global-unset-key (kbd "C-h C-m"))
(global-unset-key (kbd "C-h C-o"))
(global-unset-key (kbd "C-h C-t"))
(global-unset-key (kbd "C-h C-w"))
(global-unset-key (kbd "C-M-S-l")) ;‘recenter-other-window’
(global-unset-key (kbd "C-x s")) ;‘save-some-buffers’
(global-unset-key (kbd "C-x C-o")) ;删除附近空行
(global-unset-key (kbd "C-S-<backspace>")) ;删除一整行及其换行符
(global-unset-key (kbd "C-x DEL")) ;kill至行首
(global-unset-key (kbd "M-k")) ;kill至句尾
(global-unset-key (kbd "M-z")) ;‘zap-to-char’一帧就删完了,动作太快 反应不过来
(global-unset-key (kbd "C-M-w")) ;强制合并两次kill,使其变成‘kill-ring’上的一个字符串
(global-unset-key (kbd "C-x >")) ;‘scroll-right’
(global-unset-key (kbd "C-x <")) ;‘scroll-left’
(global-unset-key (kbd "C-x n p")) ;‘narrow-to-page’
(global-unset-key (kbd "C-x n d")) ;‘narrow-to-defun’
(global-unset-key (kbd "C-x C-+")) ;‘text-scale-adjust’
(global-unset-key (kbd "C-x C-=")) ;‘text-scale-adjust’
(global-unset-key (kbd "C-x C--")) ;‘text-scale-adjust’
(global-unset-key (kbd "C-x C-0")) ;‘text-scale-adjust’
(global-unset-key (kbd "M-s h w")) ;‘hi-lock-write-interactive-patterns’
(global-unset-key (kbd "M-s h f")) ;‘hi-lock-find-patterns’
(global-unset-key (kbd "C-M-i")) ;‘ispell-complete-word’
(global-unset-key (kbd "C-x C-v")) ;‘find-alternate-file’
(global-unset-key (kbd "C-x m")) ;‘compose-mail’
(global-unset-key (kbd "C-x <left>")) ;‘previous-buffer’
(global-unset-key (kbd "C-x <right>")) ;‘next-buffer’
(global-unset-key (kbd "C-x C-q")) ;‘read-only-mode’
(global-unset-key (kbd "C-<down-mouse-1>")) ;‘mouse-buffer-menu’
(global-unset-key (kbd "C-<down-mouse-3>")) ;右键菜单式(context-menu)的mode-specific menubar
(global-unset-key (kbd "C-x 4 0")) ;‘kill-buffer-and-window’
(global-unset-key (kbd "C-x 4 f")) ;‘find-file-other-window’
(global-unset-key (kbd "C-x 5 f")) ;‘find-file-other-frame’
(global-unset-key (kbd "C-x 5 C-f")) ;‘find-file-other-frame’
(global-unset-key (kbd "C-x 5 C-o")) ;‘display-buffer-other-frame’
(global-unset-key (kbd "C-x 5 b")) ;‘switch-to-buffer-other-frame’
(global-unset-key (kbd "C-x 5 d")) ;‘dired-other-frame’
(global-unset-key (kbd "C-x 5 m")) ;‘compose-mail-other-frame’
(global-unset-key (kbd "C-x 5 r")) ;‘find-file-read-only-other-frame’
(global-unset-key (kbd "C-x RET C-\\")) ;‘set-input-method’
(global-unset-key (kbd "C-x \\")) ;‘activate-transient-input-method’
(global-unset-key (kbd "C-x RET F")) ;‘set-file-name-coding-system’
(global-unset-key (kbd "C-x RET t")) ;‘set-terminal-coding-system’
(global-unset-key (kbd "C-x RET k")) ;‘set-keyboard-coding-system’
(global-unset-key (kbd "C-t")) ;‘transpose-chars’
(global-unset-key (kbd "M-t")) ;‘transpose-words’
(global-unset-key (kbd "C-x C-t")) ;‘transpose-lines’
(global-unset-key (kbd "C-x u")) ;“C-_”
(global-unset-key (kbd "C-/")) ;“C-_”
(global-unset-key (kbd "C-?")) ;“C-M-_”,有些终端不认识这个字符
(global-unset-key (kbd "M-<drag-mouse-1>")) ;与X的secondary selection兼容的功能
(global-unset-key (kbd "M-<down-mouse-1>")) ;与X的secondary selection兼容的功能
(global-unset-key (kbd "M-<down-mouse-3>")) ;与X的secondary selection兼容的功能
(global-unset-key (kbd "M-<down-mouse-2>")) ;与X的secondary selection兼容的功能
(global-unset-key (kbd "C-x C-u"))
(global-unset-key (kbd "C-x C-l"))
(global-unset-key (kbd "C-M-\\")) ;‘indent-region’
(global-unset-key (kbd "M-@")) ;‘mark-word’
(global-unset-key (kbd "C-M-@"))
(global-unset-key (kbd "M-h")) ;‘mark-paragraph’
(global-unset-key (kbd "C-M-h")) ;‘mark-defun’
(global-unset-key (kbd "C-x C-p")) ;‘mark-page’
(global-unset-key (kbd "C-M-o")) ;‘split-line’
(global-unset-key (kbd "M-i")) ;‘tab-to-tab-stop’
(global-unset-key (kbd "C-x TAB")) ;‘indent-rigidly’
(global-unset-key (kbd "C-@")) ;“C-SPC”
(global-unset-key (kbd "C-x f")) ;‘set-fill-column’
(global-unset-key (kbd "C-x .")) ;‘set-fill-prefix’
(global-unset-key (kbd "<f2>")) ;‘2C-mode’相关的键
(global-unset-key (kbd "C-x 6")) ;‘2C-mode’相关的键
(global-unset-key (kbd "C-x ;")) ;‘comment-set-column’

(progn
  (advice-add 'backward-kill-word :before-while
              (lambda (&rest arguments)
                "“<backspace>”"
                (if (and (interactive-p)
                         (= (cl-first arguments) 1))
                    (let ((old-point (point)))
                      (insert-char #x20)
                      (c-hungry-backspace)
                      (= old-point (point)))
                  t)))
  (advice-add 'kill-word :before-while
              (lambda (&rest arguments)
                "“M-d”"
                (if (and (interactive-p)
                         (= (cl-first arguments) 1))
                    (let ((old-size (buffer-size)))
                      (insert-char #x20)
                      (backward-char)
                      (c-hungry-delete-forward)
                      (= old-size (buffer-size)))
                  t))))
(let ((shynur--completion-regexp-list (mapcar (lambda (regexp)
                                                (concat
                                                 "\\`shynur[^[:alnum:]]" "\\|"
                                                 "\\(" regexp "\\)")) '(;;滤除‘prefix--*’
                                                                        ;"\\`-?\\([^-]+-?\\)*$"
                                                                        ;;滤除‘*-internal’
                                                                        "\\(\\`\\|[^l]\\|[^a]l\\|[^n]al\\|[^r]nal\\|[^e]rnal\\|[^t]ernal\\|[^n]ternal\\|[^i]nternal\\|[^-]internal\\)\\'")))
      (functions-for-completion [try-completion
                                 test-completion
                                 all-completions]))
  (seq-doseq (key ["C-h f"
                   "C-h v"
                   "M-x"])
    (let ((key-original-function (keymap-global-lookup key)))
      (global-set-key (kbd key) (lambda ()
                                  "(bug#64351#20)"
                                  (interactive)
                                  (let ((completion-regexp-list+shynur--completion-regexp-list `(,@completion-regexp-list
                                                                                                 ,@shynur--completion-regexp-list)))
                                    (seq-doseq (funtion-for-completion functions-for-completion)
                                      (advice-add funtion-for-completion :around
                                                  (lambda (advised-function &rest arguments)
                                                    (let ((completion-regexp-list completion-regexp-list+shynur--completion-regexp-list))
                                                      (apply advised-function
                                                             arguments))) '((name . "shynur--let-bind-completion-regexp-list")))))
                                  (unwind-protect
                                      (call-interactively key-original-function)
                                    (seq-doseq (funtion-for-completion functions-for-completion)
                                      (advice-remove funtion-for-completion "shynur--let-bind-completion-regexp-list"))))))))
(progn
  (global-set-key (kbd "C-s") (lambda ()
                                (interactive)
                                (require 'ivy)
                                (ivy-mode)
                                (unwind-protect
                                    (progn
                                      (require 'swiper)
                                      (swiper))
                                  (ivy-mode -1))))
  (global-unset-key (kbd "C-r"))
  (global-unset-key (kbd "C-M-r")))
(global-set-key (kbd "C-x C-b") #'bs-show)
(global-set-key (kbd "<mouse-2>") #'mouse-yank-at-click)
(mapc (lambda (postkey-function)
        (global-set-key (kbd (concat "C-c " (car postkey-function))) (cdr postkey-function)))
      `(("c" . ,#'highlight-changes-visible-mode)
        ,@(prog1 '(("d M-<left>"  . drag-stuff-left)
                   ("d M-<down>"  . drag-stuff-down)
                   ("d M-<up>"    . drag-stuff-up)
                   ("d M-<right>" . drag-stuff-right))
            (defconst shynur/drag-stuff-map
              (let ((shynur/drag-stuff-map (make-sparse-keymap)))
                (require 'drag-stuff)
                (define-key shynur/drag-stuff-map (kbd "M-<left>")  #'drag-stuff-left)
                (define-key shynur/drag-stuff-map (kbd "M-<down>")  #'drag-stuff-down)
                (define-key shynur/drag-stuff-map (kbd "M-<up>")    #'drag-stuff-up)
                (define-key shynur/drag-stuff-map (kbd "M-<right>") #'drag-stuff-right)
                shynur/drag-stuff-map))
            (progn
              (require 'repeat)
              (put #'drag-stuff-left  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-down  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-up    'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-right 'repeat-map 'shynur/drag-stuff-map)))
        ("f" . ,(lambda ()
                  "调用“clang-format --Werror --fallback-style=none --ferror-limit=0 --style=file:~/.emacs.d/shynur/clang-format.yaml”.
在C语系中直接美化代码,否则美化选中区域"
                  (interactive)
                  (let ((clang-format (pcase (system-name)
                                        ("ASUS-TX2" "d:/Progs/LLVM/bin/clang-format.exe")
                                        (_          "clang-format"                      )))
                        (options `("--Werror"
                                   "--fallback-style=none"
                                   "--ferror-limit=0"
                                   ,(format "--style=file:%s"
                                            (file-truename "~/.emacs.d/shynur/clang-format.yaml"))))
                        (programming-language (pcase major-mode
                                                ('c-mode    "c"   )
                                                ('c++-mode  "cpp" )
                                                ('java-mode "java")
                                                ('js-mode   "js"  )
                                                (_ (unless mark-active
                                                     (user-error (shynur/message-format "无法使用“clang-format”处理当前语言")))))))
                    (if (stringp programming-language)
                        (without-restriction
                          (apply #'call-process-region
                                 1 (point-max) clang-format t t nil
                                 (format "--assume-filename=a.%s" programming-language)
                                 (format "--cursor=%d" (1- (point)))
                                 options)
                          (beginning-of-buffer)
                          (goto-char (1+ (string-to-number (prog1 (let ((case-fold-search nil))
                                                                    (save-match-data
                                                                      (buffer-substring-no-properties
                                                                       (re-search-forward "\\`[[:blank:]]*{[[:blank:]]*\"Cursor\":[[:blank:]]*")
                                                                       (re-search-forward "[[:digit:]]+"))))
                                                             (delete-line))))))
                      (let ((formatted-code (let ((buffer-substring `(,(current-buffer) ,(region-beginning) ,(region-end))))
                                              (with-temp-buffer
                                                (apply #'insert-buffer-substring-no-properties
                                                       buffer-substring)
                                                (apply #'call-process-region
                                                       1 (point-max) clang-format t t nil
                                                       (format "--assume-filename=a.%s"
                                                               (completing-read #("assume language: "
                                                                                  0 16 (face italic))
                                                                                '("c" "cpp" "java" "js" "json" "cs")))
                                                       options)
                                                (buffer-substring-no-properties 1 (point-max)))))
                            (point-at-region-end (prog1 (= (point) (region-end))
                                                   (delete-active-region))))
                        (if point-at-region-end
                            (insert formatted-code)
                          (save-excursion
                            (insert formatted-code))))))))
        ("g" . ,#'garbage-collect)
        ("h" . ,#'hlt-highlight-region)
        ("s" . ,#'shortdoc-display-group)
        ("z" . ,(lambda ()
                  (interactive)
                  (set-frame-size nil 1100 850 t)))))

(letrec ((modify-keyboard-translation (lambda ()
                                        "daemon-client运行在同一个机器上,只需要在一个client进程中执行‘keyboard-translate’,其余(以及后续)的client都能生效"
                                        (keyboard-translate ?\[ ?\()
                                        (keyboard-translate ?\] ?\))
                                        (keyboard-translate ?\( ?\[)
                                        (keyboard-translate ?\) ?\])
                                        (remove-hook 'server-after-make-frame-hook modify-keyboard-translation))))
  (add-hook 'server-after-make-frame-hook modify-keyboard-translation))

;;当最后一个frame关闭时,存入它的位置和尺寸;当桌面上没有frame时,下一个打开的frame将使用那个被存入的位置和尺寸.
(let ((shynur/--size&position-relayer `(,(cons 'top 0) ,(cons 'left 0)
                                        ;;‘fullscreen’放最后,以覆盖‘width’&‘height’的设置.
                                        ,(cons 'width 0) ,(cons 'height 0) ,(cons 'fullscreen nil)))
      shynur/--size&position-relayer-holding?)
  (letrec ((shynur/--get-size&position (lambda ()
                                         (when shynur/--size&position-relayer-holding?
                                           (dolist (parameter-value shynur/--size&position-relayer)
                                             (set-frame-parameter nil (car parameter-value) (cdr parameter-value))))
                                         (remove-hook 'server-after-make-frame-hook shynur/--get-size&position)
                                         (   add-hook 'delete-frame-functions       shynur/--put-size&position)))
           (shynur/--put-size&position (lambda (frame-to-be-deleted)
                                         (when (length= (frames-on-display-list) 1)
                                           (dolist (parameter-value shynur/--size&position-relayer)
                                             (setcdr parameter-value (frame-parameter frame-to-be-deleted (car parameter-value))))
                                           (setq shynur/--size&position-relayer-holding? t)
                                           (remove-hook 'delete-frame-functions       shynur/--put-size&position)
                                           ;;当需要调用该λ表达式时,必然没有除此以外的其它frame了,因此之后新建的frame必然是server弹出的,所以此处无需使用‘after-make-frame-functions’
                                           (   add-hook 'server-after-make-frame-hook shynur/--get-size&position)))))
    (add-hook 'server-after-make-frame-hook shynur/--get-size&position)))

;; 这页的函数有朝一日会移到 ~shynur/.emacs.d/shynur/ 目录下

(defun shynur/text-reverse-characters (beginning end)
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

(defun shynur/text-set-region-properties-same-as (beginning end same-as-where)
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

(require 'shynur/org "~/.emacs.d/shynur/org.el")

;;; End of Code

;; Local Variables:
;; coding: utf-8-unix
;; End:
;;; ~shynur/.emacs.d/init.el ends here
