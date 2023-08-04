;;; -*- lexical-binding: t; -*-

(custom-set-variables
 '(major-mode 'text-mode)
 '(completion-list-mode-hook `(,@(bound-and-true-p completion-list-mode-hook)
                               ,(lambda ()
                                  "把没用的minor mode都关了"
                                  (make-thread (lambda ()
                                                 "关了‘highlight-changes-mode’和‘highlight-changes-visible-mode’会因为试图移除face导致报错"
                                                 (sleep-for 0.4)
                                                 (company-mode -1)
                                                 (electric-indent-local-mode -1)
                                                 (page-break-lines-mode -1)
                                                 (indent-guide-mode -1)
                                                 (on-screen-mode -1))))
                               ,(lambda ()
                                  "1 screen line/一个条目"
                                  (make-thread (lambda ()
                                                 (sleep-for 0.4)
                                                 (let ((inhibit-message t))
                                                   (toggle-truncate-lines 1))))))
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
 `(,(set 'shynur--tmp 'shynur--tmp) ,(progn
                                       (shynur/custom-appdata/ transient-history-file el)
                                       (shynur/custom-appdata/ transient-levels-file el)
                                       (shynur/custom-appdata/ transient-values-file el)
                                       (shynur/custom-appdata/ tramp-persistency-file-name el)
                                       (shynur/custom-appdata/ tramp-auto-save-directory /)
                                       (shynur/custom-appdata/ filesets-menu-cache-file el)
                                       (shynur/custom-appdata/ auto-save-list-file-prefix /)
                                       (shynur/custom-appdata/ bookmark-default-file el)
                                       (shynur/custom-appdata/ url-cache-directory /)
                                       (shynur/custom-appdata/ url-cookie-file)
                                       (shynur/custom-appdata/ temporary-file-directory /)
                                       (shynur/custom-appdata/ save-place-file el)
                                       (shynur/custom-appdata/ eww-bookmarks-directory /)
                                       ))
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
 '(coding-system-for-write 'utf-8-unix
                           nil ()
                           "该customization中的NEW被Emacs设置为t")
 '(file-name-coding-system shynur/custom-filename-coding)
 '(completion-cycle-threshold nil
                              nil (minibuffer)
                              "minibuffer补全时,按TAB会轮换候选词")
 '(indent-guide-recursive t
                          nil (indent-guide))
 '(indent-guide-char "\N{BOX DRAWINGS LIGHT VERTICAL}"
                     nil (indent-guide))
 ;; '(current-language-environment "UTF-8")
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
 '(extended-command-suggest-shorter t
                                    nil (simple)
                                    "通过不完整的函数名调用command时,在echo area中提示这个command的全名")
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
 '(help-enable-autoload t
                        nil (help))
 '(help-enable-completion-autoload t
                                   nil (help-fns))
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
 '(kill-whole-line nil
                   nil (simple)
                   "“C-k”不删除换行符")
 '(echo-keystrokes 0.001
                   nil ()
                   "若快捷键未完整击入,则等待该时长后在echo-area显示已经击入的键")
 '(visible-bell t
                nil ()
                "响铃可视化.在 MS-Windows 上表现为,任务栏图标闪烁")
 '(table-fixed-width-mode nil
                          nil (table)
                          "基于文本的表格自动调节尺寸")
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
 '(read-file-name-completion-ignore-case t
                                         nil (minibuffer))
 '(read-quoted-char-radix 16
                          nil (simple)
                          "“C-q”后接16进制")
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
 '(Info-mode-hook `(,@Info-mode-hook
                    ,(lambda ()
                       "单词之间换行"
                       (visual-line-mode))))
 '(help-mode-hook `(,@(bound-and-true-p help-mode-hook)
                    ,(lambda ()
                       "单词之间换行"
                       (visual-line-mode))))
 '(visual-line-fringe-indicators '(nil down-arrow)
                                 nil (simple)
                                 "word-wrap打开时在换行处显示down-arrow")
 '(on-screen-delay 0.4
                   nil (on-screen)
                   "on-screen的提示持续时间")
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
 '(mouse-highlight t
                   nil ()
                   "当鼠标位于clickable位置时,高亮此处的文本")
 '(global-highlight-changes-mode t
                                 nil (hilit-chg))
 '(highlight-changes-visibility-initial-state nil
                                              nil (hilit-chg))
 '(python-shell-interpreter shynur/custom-python-path
                            nil (python))
 '(python-shell-interpreter-interactive-arg nil
                                            nil (python))
 '(eval-expression-debug-on-error t
                                  nil (simple)
                                  "在‘eval-expression’时暂时地将‘debug-on-error’设置为t")
 '(debug-on-quit nil
                 nil ()
                 "按下“C-g”时是否要进入debugger")
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
 '(text-scale-mode-step text-scale-mode-step
                        nil (face-remap)
                        "放缩字体大小时的倍率")
 '(emacs-startup-hook `(,@(bound-and-true-p emacs-startup-hook)
                        ,(lambda ()
                           (lossage-size 33554431))
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
                               (prettify-symbols-mode))))
                        ,(lambda ()
                           (display-time-mode)
                           (display-battery-mode))
                        ,(lambda ()
                           "调节beep的声音种类,而不是音量"
                           (set-message-beep nil))
                        ,(lambda ()
                           "解决‘mouse-drag-and-drop-region’总是copy的问题(bug#63872)"
                           (advice-add (prog1 'mouse-drag-and-drop-region
                                         (require 'mouse)) :around
                                         (lambda (mouse-drag-and-drop-region_ &rest arguments)
                                           (let ((mark-even-if-inactive t))
                                             (apply mouse-drag-and-drop-region_ arguments)))))))
 '(makefile-gmake-mode-hook `(,@(bound-and-true-p makefile-gmake-mode-hook)
                              ,(lambda ()
                                 (indent-tabs-mode)))
                            nil (make-mode))
 '(inferior-lisp-program shynur/custom-commonlisp-path
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
 '(text-mode-hook `(,@(bound-and-true-p text-mode-hook)
                    ,(lambda ()
                       (when (eq major-mode 'text-mode)
                         (display-fill-column-indicator-mode)))))
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
 '(what-cursor-show-names t
                          nil (simple)
                          "使“C-x =”(‘what-cursor-position’)顺便显示字符的Unicode名字")
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
 '(before-save-hook `(,@(bound-and-true-p before-save-hook)
                      ,#'whitespace-cleanup)
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
 '(auto-revert-check-vc-info t
                             nil (autorevert)
                             "autorevert时检查VC状态,即使文件没有修改时也检查")
 '(buffer-auto-revert-by-notification t
                                      nil (files)
                                      "dired可以使用file-notification")
 '(auto-save-interval 20
                      nil ()
                      "键入如此之多个character之后auto-save")
 '(auto-save-timeout 30
                     nil ()
                     "经过如此之多的秒数的idleness之后auto-save,还可能执行一次GC.(这是一条heuristic的建议,Emacs可以不遵循,e.g.,编辑大文件)")
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
 '(edebug-all-defs nil
                   nil (edebug)
                   "置t则颠倒[C-M-x]对前缀参数的处理")
 '(life-step-time 0.2
                  nil (life))
 '(split-window-keep-point nil
                           nil (window)
                           "Cursor在下半window时,新建window在上半部分;反之则反.简言之,尽可能少地重绘.缺点是,新窗口的point未必与原先一致")
 '(delete-window-choose-selected 'mru
                                 nil (window)
                                 "Delete窗口之后下一个选中的窗口是最近使用过的")
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
 '(double-click-time 400)
 '(double-click-fuzz 3)
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
 '(register-separator "\n\n"
                      nil (register))
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
                           "在GTK+的file-chooser-dialog中显示隐藏文件")
 '(compilation-scroll-output 'first-error
                             nil (compile))
 '(compilation-always-kill nil
                           nil (compile)))

;;; Feature: ‘files’
(with-eval-after-load 'files
  (setq safe-local-variable-values `(,@safe-local-variable-values
                                     ,@(let ((shynur--safe-local-variable-values (list)))
                                         (named-let get-vars ((dir-locals (mapcan (lambda (file-path)
                                                                                    (when (file-exists-p file-path)
                                                                                      (with-temp-buffer
                                                                                        (insert-file-contents file-path)
                                                                                        (read (current-buffer))))) `[,@(mapcar (lambda (dir-loc)
                                                                                                                                 "囊括诸如‘~/.emacs.d/’下的‘.dir-locals.el’文件."
                                                                                                                                 (file-name-concat user-emacs-directory
                                                                                                                                                   dir-loc)) [".dir-locals.el"
                                                                                                                                                               ".dir-locals-2.el"])
                                                                                                                     ])))
                                           (dolist (mode-vars dir-locals)
                                             (let ((vars (cdr mode-vars)))
                                               (if (stringp (car mode-vars))
                                                   (get-vars vars)
                                                 (dolist (var-pair vars)
                                                   (push var-pair shynur--safe-local-variable-values))))))
                                         shynur--safe-local-variable-values))))

(put 'narrow-to-region 'disabled nil)

;;; Feature: ‘project’
(shynur/custom-appdata/ project-list-file el)
(setq project-switch-commands #'project-find-file)  ; “C-x p p”选中项目后, 立刻执行指定的 command.

;;; Feature: ‘nsm’
(shynur/custom-appdata/ nsm-settings-file data)  ; 记录已知的安全 connection.

;;; Feature: ‘company’
(setq company-idle-delay 0
      company-minimum-prefix-length 2)
(setq company-dabbrev-code-everywhere t)  ; 还在 comment 和 string 中进行 completion.
(setq company-dabbrev-code-other-buffers t  ; 在具有相同‘major-mode’的 buffer 中搜索候选词.
      company-dabbrev-code-time-limit 2  ; 在 current buffer 中搜索代码块中的关键词的时间限制.
      )
(setq company-show-quick-access t  ; 给候选词编号.
      company-tooltip-offset-display 'lines  ; 原本在候选词界面的右侧是由 scroll bar, 现改成: 上/下面分别有多少候选词.
      company-tooltip-limit 10)
(setq company-clang-executable shynur/custom-clang-path)
(global-company-mode)

;;; Feature: ‘savehist’
(shynur/custom-appdata/ savehist-file el)
(setq savehist-autosave-interval nil)
(savehist-mode)  ; 保存 minibuffer 的历史记录

;;; Feature: ‘dired’
(keymap-global-unset "C-x C-j")    ; ‘dired-jump’
(keymap-global-unset "C-x 4 C-j")  ; ‘dired-jump-other-window’
(keymap-global-unset "C-x 5 d")    ; ‘dired-other-frame’
(setq dired-maybe-use-globstar t)
;; (setq dired-listing-switches list-directory-verbose-switches) 在 MS-Windows 上用不了
(setq dired-switches-in-mode-line nil)

;;; Feature: ‘simple’
(keymap-global-unset "C-x m")    ; ‘compose-mail’
(keymap-global-unset "C-x 4 m")  ; ‘compose-mail’
(keymap-global-unset "C-x 5 m")  ; ‘compose-mail’

;;; Feature: ‘desktop’ [X]
(setq desktop-restore-eager t)  ; 尽快恢复 buffer, 而不是 idle 时逐步恢复.
(setq desktop-load-locked-desktop t)  ; Lock 文件 是为了 防止其它 Emacs 实例将其复写, 但我的电脑上只会有一个 Emacs 实例. 所以即使文件是 locked, 也只能是因为上一次 session 中 Emacs 崩溃了.
(setq desktop-auto-save-timeout nil)  ; Idle 时不自动保存, 毕竟 session 结束时会自动保存.
(setq desktop-restore-frames nil)
;; ‘desktop-files-not-to-save’: 默认不保存 Remote file.
(shynur/custom-appdata/ desktop-dirname /)
(shynur/custom-appdata/ desktop-base-file-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-file-name.el")
(shynur/custom-appdata/ desktop-base-lock-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-lock-name.el")
(setq desktop-save t)

;;; Feature: ‘minibuffer’
(add-hook 'minibuffer-mode-hook
          (lambda ()
            (define-key minibuffer-local-completion-map " "
              #'self-insert-command)
            (define-key minibuffer-local-completion-map "?"
              #'self-insert-command)))

;;; Feature: ‘recentf’
(shynur/custom-appdata/ recentf-save-file el)
(setq recentf-max-saved-items nil)
(setq recentf-max-menu-items 30)
(recentf-mode)

;;; Feature: ‘electric’
(setq electric-quote-paragraph t
      electric-quote-comment t
      electric-quote-string t
      ;; 不替换 双引号.
      electric-quote-replace-double nil)
(electric-indent-mode)

;;; [[package][ivy]]
(keymap-global-set "C-s"
                   (lambda ()
                     (interactive)
                     (ivy-mode)
                     (unwind-protect
                         (swiper)
                       (ivy-mode -1))))
(keymap-global-unset "C-r")
(keymap-global-unset "C-M-r")
(setq ivy-count-format "%d/%d ")
(setq ivy-height 6)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            "令 ivy 的 minibuffer 拥有自适应高度."
            (add-hook 'post-command-hook
                      (lambda ()
                        (when (bound-and-true-p ivy-mode)
                          (shrink-window (1+ ivy-height))))
                      nil t)))

;;; melpa:‘page-break-lines’
(setq page-break-lines-modes '(emacs-lisp-mode
                               emacs-lisp-compilation-mode
                               ))
(setq page-break-lines-lighter " 分页"  ; Mode-line 上显示的该模式名.
      page-break-lines-max-width nil)
(global-page-break-lines-mode)

;;; Feature: ‘ls-lisp’
;; 排序:
(setq ls-lisp-use-string-collate nil  ; 不知道为什么, 置 t 就不区分大小写了.
      ls-lisp-ignore-case nil
      ls-lisp-dirs-first t
      ;; 该算法会使 文件名中的字母部分 相同的聚集在一起.
      ls-lisp-UCA-like-collation t)
(setq ls-lisp-verbosity '(uid)

      ls-lisp-use-localized-time-format t  ; 使用下面指定的格式, 而非 OS 提供的.
      ls-lisp-format-time-list '("%m/%d %k:%M"  ; 今年编辑的显示为 “07/01  6:42”.
                                 "%m/%d %Y"))
(setq ls-lisp-support-shell-wildcards t)

;;; Feature: ‘hanoi’
(setq hanoi-use-faces nil)  ; 不要使用彩色动画, 因为看起来很鬼畜.

;;; Feature: ‘so-long’
(global-so-long-mode)

;;; Feature: ‘cus-edit’
(setq custom-search-field nil)  ; 感觉不如‘customize-apropos’.
(setq custom-buffer-done-kill nil)  ; 按“[Exit]”(GUI 下 该图标 位于 tool bar) 并不 kill buffer.
(shynur/custom-appdata/ custom-file el)  ; 该文件需要 手动‘load-file’, 所以 直接 设置 即可, 无后顾之忧.

(keymap-global-unset "C-h g")
(keymap-global-unset "C-h h")
(keymap-global-unset "C-h t")
(keymap-global-unset "C-h C-a")
(keymap-global-unset "C-h C-c")
(keymap-global-unset "C-h C-m")
(keymap-global-unset "C-h C-o")
(keymap-global-unset "C-h C-p")
(keymap-global-unset "C-h C-t")
(keymap-global-unset "C-h C-w")
(keymap-global-unset "C-M-S-l")  ; ‘recenter-other-window’
(keymap-global-unset "C-x s")    ; ‘save-some-buffers’
(keymap-global-unset "C-x C-o")  ; 删除附近空行
(keymap-global-unset "C-S-<backspace>")  ; 删除一整行及其换行符
(keymap-global-unset "C-x DEL")          ; kill至行首
(keymap-global-unset "M-k")      ; kill至句尾
(keymap-global-unset "M-z")      ; ‘zap-to-char’一帧就删完了,动作太快 反应不过来
(keymap-global-unset "C-M-w")    ; 强制合并两次kill,使其变成‘kill-ring’上的一个字符串
(keymap-global-unset "C-x >")    ; ‘scroll-right’
(keymap-global-unset "C-x <")    ; ‘scroll-left’
(keymap-global-unset "C-x n p")  ; ‘narrow-to-page’
(keymap-global-unset "C-x n d")  ; ‘narrow-to-defun’
(keymap-global-unset "C-x C-+")  ; ‘text-scale-adjust’
(keymap-global-unset "C-x C-=")  ; ‘text-scale-adjust’
(keymap-global-unset "C-x C--")  ; ‘text-scale-adjust’
(keymap-global-unset "C-x C-0")  ; ‘text-scale-adjust’
(keymap-global-unset "M-s h w")  ; ‘hi-lock-write-interactive-patterns’
(keymap-global-unset "M-s h f")  ; ‘hi-lock-find-patterns’
(keymap-global-unset "C-M-i")    ; ‘ispell-complete-word’
(keymap-global-unset "C-x C-v")  ; ‘find-alternate-file’
(keymap-global-unset "C-x <left>")        ; ‘previous-buffer’
(keymap-global-unset "C-x <right>")       ; ‘next-buffer’
(keymap-global-unset "C-x C-q")           ; ‘read-only-mode’
(keymap-global-unset "C-<down-mouse-1>")  ; ‘mouse-buffer-menu’
(keymap-global-unset "C-<down-mouse-3>")  ; 右键菜单式(context-menu)的mode-specific menubar
(keymap-global-unset "C-x 4 0")    ; ‘kill-buffer-and-window’
(keymap-global-unset "C-x 4 f")    ; ‘find-file-other-window’
(keymap-global-unset "C-x 5 f")    ; ‘find-file-other-frame’
(keymap-global-unset "C-x 5 C-f")  ; ‘find-file-other-frame’
(keymap-global-unset "C-x 5 C-o")  ; ‘display-buffer-other-frame’
(keymap-global-unset "C-x 5 b")    ; ‘switch-to-buffer-other-frame’
(keymap-global-unset "C-x 5 d")    ; ‘dired-other-frame’
(keymap-global-unset "C-x 5 m")    ; ‘compose-mail-other-frame’
(keymap-global-unset "C-x 5 r")    ; ‘find-file-read-only-other-frame’
(keymap-global-unset "C-x RET C-\\")  ; ‘set-input-method’
(keymap-global-unset "C-x \\")     ; ‘activate-transient-input-method’
(keymap-global-unset "C-x RET F")  ; ‘set-file-name-coding-system’
(keymap-global-unset "C-x RET t")  ; ‘set-terminal-coding-system’
(keymap-global-unset "C-x RET k")  ; ‘set-keyboard-coding-system’
(keymap-global-unset "C-t")        ; ‘transpose-chars’
(keymap-global-unset "M-t")        ; ‘transpose-words’
(keymap-global-unset "C-x C-t")    ; ‘transpose-lines’
(keymap-global-unset "C-x u")      ; “C-_”
(keymap-global-unset "C-/")        ; “C-_”
(keymap-global-unset "C-?")        ; “C-M-_”,有些终端不认识这个字符
(keymap-global-unset "M-<drag-mouse-1>")  ; 与X的secondary selection兼容的功能
(keymap-global-unset "M-<down-mouse-1>")  ; 与X的secondary selection兼容的功能
(keymap-global-unset "M-<down-mouse-3>")  ; 与X的secondary selection兼容的功能
(keymap-global-unset "M-<down-mouse-2>")  ; 与X的secondary selection兼容的功能
(keymap-global-unset "C-x C-u")
(keymap-global-unset "C-x C-l")
(keymap-global-unset "C-M-\\")   ; ‘indent-region’
(keymap-global-unset "M-@")      ; ‘mark-word’
(keymap-global-unset "C-M-@")
(keymap-global-unset "M-h")      ; ‘mark-paragraph’
(keymap-global-unset "C-M-h")    ; ‘mark-defun’
(keymap-global-unset "C-x C-p")  ; ‘mark-page’
(keymap-global-unset "C-M-o")    ; ‘split-line’
(keymap-global-unset "M-i")      ; ‘tab-to-tab-stop’
(keymap-global-unset "C-x TAB")  ; ‘indent-rigidly’
(keymap-global-unset "C-@")      ; “C-SPC”
(keymap-global-unset "C-x f")    ; ‘set-fill-column’
(keymap-global-unset "C-x .")    ; ‘set-fill-prefix’
(keymap-global-unset "<f2>")     ; ‘2C-mode’相关的键
(keymap-global-unset "C-x 6")    ; ‘2C-mode’相关的键
(keymap-global-unset "C-x ;")    ; ‘comment-set-column’
(keymap-global-unset "C-x p D")  ; ‘project-dired’
(keymap-global-unset "C-x p b")  ; ‘project-switch-to-buffer’
(keymap-global-unset "C-x 5 .")  ; ‘xref-find-definitions-other-frame’
(keymap-global-unset "C-x C-d")  ; ‘list-directory’
(keymap-global-unset "C-x C-z")  ; ‘suspend-frame’
(keymap-global-unset "C-M-c")    ; ‘exit-recursive-edit’
(keymap-global-unset "C-]")      ; ‘abort-recursive-edit’
(keymap-global-unset "C-x X a")  ; ‘abort-recursive-edit’

(progn
  (require 'cc-mode)
  (advice-add 'backward-kill-word :before-while
              (lambda (arg)
                "前面顶多只有空白字符 或 后面顶多只有空白字符且前面有空白字符 时,删除前方所有空白"
                (if (and (interactive-p)  ; 只在使用键盘且
                         (= 1 arg)        ; 没有前缀参数时执行
                         (or (save-match-data
                               (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=")))
                             (and (looking-at-p (concat "\\=\\(" search-whitespace-regexp "\\)?$"))
                                  (save-match-data
                                    (looking-back (concat search-whitespace-regexp "\\="))))))
                    (prog1 nil
                      (c-hungry-delete))
                  t)))
  (advice-add 'kill-word :before-while
              (lambda (arg)
                "后面顶多只有空白字符 或 前面顶多只有空白字符且后面有空白字符 时, 删除后面所有空白"
                (if (and (interactive-p)  ; 只在使用键盘且
                         (= 1 arg)        ; 没有前缀参数时执行
                         (or (looking-at-p (concat "\\=\\(" search-whitespace-regexp "\\)?$"))
                             (and (save-match-data
                                    (looking-back (concat "^\\(" search-whitespace-regexp "\\)?\\=")))
                                  (looking-at-p (concat "\\=" search-whitespace-regexp)))))
                    (prog1 nil
                      (c-hungry-delete-forward))
                  t))))
(let ((shynur--completion-regexp-list (mapcar (lambda (regexp)
                                                (concat
                                                 "\\(?:" regexp "\\)"
                                                 "\\|\\`:?shynur[^[:alnum:]]")) '(;; 滤除‘prefix--*’(i.e., 不允许两个“-”连续出现).
                                                                                  "\\`-?\\(?:[^-]+\\(?:-[^-]+\\)*-?\\)?\\'"
                                                                                  ;; 滤除‘*-internal’(i.e., 不允许出现“-internal”).
                                                                                  "\\(?:\\(?:\\`\\|[^l]\\)\\|\\(?:\\`\\|[^a]\\)l\\|\\(?:\\`\\|[^n]\\)al\\|\\(?:\\`\\|[^r]\\)nal\\|\\(?:\\`\\|[^e]\\)rnal\\|\\(?:\\`\\|[^t]\\)ernal\\|\\(?:\\`\\|[^n]\\)ternal\\|\\(?:\\`\\|[^i]\\)nternal\\|\\(?:\\`\\|[^-]\\)internal\\)\\'")))
      (completers [try-completion
                   test-completion
                   all-completions]))
  (seq-doseq (key ["C-h f"
                   "C-h o"
                   "C-h v"
                   "C-h w"
                   "C-h x"
                   "M-x"])
    (let ((original-command (keymap-global-lookup key)))
      (keymap-global-set key (lambda ()
                               (interactive)
                               (unwind-protect
                                   (progn
                                     (let ((shynur--completion-regexp-list+ `(,@completion-regexp-list
                                                                              ,@shynur--completion-regexp-list)))
                                       (seq-doseq (completer completers)
                                         (advice-add completer :around
                                                     (lambda (advised-function &rest arguments)
                                                       "Bug#64351#20"
                                                       (let ((completion-regexp-list shynur--completion-regexp-list+))
                                                         (apply advised-function
                                                                arguments))) '((name . "shynur--let-bind-completion-regexp-list")))))
                                     (call-interactively original-command))
                                 (seq-doseq (completer completers)
                                   (advice-remove completer "shynur--let-bind-completion-regexp-list"))))))))

(keymap-global-set "C-x C-b"
                   #'bs-show)
(keymap-global-set "<mouse-2>"
                   #'mouse-yank-at-click)
(mapc (lambda (postkey-function)
        (keymap-global-set (concat "C-c " (car postkey-function))
                           (cdr postkey-function)))
      `(("c" . ,#'highlight-changes-visible-mode)
        ,@(prog1 '(("d M-<left>"  . drag-stuff-left)
                   ("d M-<down>"  . drag-stuff-down)
                   ("d M-<up>"    . drag-stuff-up)
                   ("d M-<right>" . drag-stuff-right))
            (defconst shynur/drag-stuff-map
              (let ((shynur/drag-stuff-map (make-sparse-keymap)))
                (require 'drag-stuff)
                (define-key shynur/drag-stuff-map (kbd "M-<left>")
                            #'drag-stuff-left)
                (define-key shynur/drag-stuff-map (kbd "M-<down>")
                            #'drag-stuff-down)
                (define-key shynur/drag-stuff-map (kbd "M-<up>")
                            #'drag-stuff-up)
                (define-key shynur/drag-stuff-map (kbd "M-<right>")
                            #'drag-stuff-right)
                shynur/drag-stuff-map))
            (progn
              (require 'repeat)
              (put #'drag-stuff-left  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-down  'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-up    'repeat-map 'shynur/drag-stuff-map)
              (put #'drag-stuff-right 'repeat-map 'shynur/drag-stuff-map)))
        ("f" . ,(lambda ()
                  "调用“clang-format --Werror --fallback-style=none --ferror-limit=0 --style=file:~/.emacs.d/etc/clang-format.yaml”.
在 C 语系中直接 (整个 buffer 而不仅是 narrowed region) 美化代码, 否则美化选中区域."
                  (interactive)
                  (let ((clang-format shynur/custom-clang-format-path)
                        (options `("--Werror"
                                   "--fallback-style=none"
                                   "--ferror-limit=0"
                                   ,(format "--style=file:%s"
                                            (file-truename "~/.emacs.d/etc/clang-format.yaml"))))
                        (programming-language (pcase major-mode
                                                ('c-mode    "c"   )
                                                ('c++-mode  "cpp" )
                                                ('java-mode "java")
                                                ('js-mode   "js"  )
                                                (_ (unless mark-active
                                                     (user-error (shynur/message-format "无法使用“clang-format”处理当前语言")))))))
                    (if (stringp programming-language)
                        (shynur/save-cursor-relative-position-in-window
                          ;; shynur/TODO:
                          ;;     不确定这边的‘without-restriction’有没有必要,
                          ;;   以及要不要和‘shynur/save-cursor-relative-position-in-window’互换位置.
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
                                                               (delete-line)))))))
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
                  "更换屏幕时记得修改这些参数"
                  (interactive)
                  (set-frame-parameter nil 'fullscreen nil)
                  (set-frame-position nil 220 130)
                  (set-frame-size nil 800 600 t)))))

(provide 'shynur-tmp)

;; Local Variables:
;; coding: utf-8-unix
;; End:
