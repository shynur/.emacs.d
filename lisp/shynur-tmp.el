;;; -*- lexical-binding: t; -*-

(custom-set-variables
 '(completion-list-mode-hook `(,@(bound-and-true-p completion-list-mode-hook)
                               ,(lambda ()
                                  "把没用的minor mode都关了"
                                  (make-thread (lambda ()
                                                 (sleep-for 0.4)
                                                 (company-mode -1)
                                                 (electric-indent-local-mode -1)
                                                 (page-break-lines-mode -1))))
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
 `(,(set 'shynur--tmp 'shynur--tmp) ,(progn
                                       (shynur/custom:appdata/ transient-history-file el)
                                       (shynur/custom:appdata/ transient-levels-file el)
                                       (shynur/custom:appdata/ transient-values-file el)
                                       (shynur/custom:appdata/ tramp-persistency-file-name el)
                                       (shynur/custom:appdata/ filesets-menu-cache-file el)
                                       (shynur/custom:appdata/ bookmark-default-file el)
                                       (shynur/custom:appdata/ url-cache-directory /)
                                       (shynur/custom:appdata/ url-cookie-file)
                                       (shynur/custom:appdata/ temporary-file-directory /)
                                       (shynur/custom:appdata/ save-place-file el)
                                       (shynur/custom:appdata/ eww-bookmarks-directory /)
                                       ))
 '(case-replace t
                nil (replace)
                "文本替换时,大小写敏感")
 '(completion-styles '(basic partial-completion initials)
                     nil (minibuffer)
                     "minibuffer的补全风格(从‘completion-styles-alist’中选取)")
 '(debug-on-error nil
                  nil ()
                  "没有对应的handler时进入debugger;debugger直接在error所在的环境中运行,所以很方便;但是有些package没有使用user-error,所以若此变量开启,会时常进入debugger,非常麻烦,所以暂时来说,应该关掉")
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
 '(file-name-coding-system shynur/custom:filename-coding)
 '(neo-show-hidden-files t
                         nil (neotree))
 '(neotree-mode-hook `(,@neotree-mode-hook
                       ,(lambda ()
                          "关闭neotree的行号"
                          (display-line-numbers-mode -1)))
                     nil (neotree))
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
 '(max-specpdl-size max-specpdl-size
                    nil ()
                    "似乎在emacs-29中被废弃了")
 '(shr-offer-extend-specpdl t
                            nil (shr)
                            "HTML可能会有很深的嵌套,因此需要更多的PDL.该变量决定自动增长PDL的大小")
 '(save-place-mode t
                   nil (saveplace)
                   "在session之间保存访问文件时的浏览位置")
 '(size-indication-mode t
                        nil (simple)
                        "mode-line显示buffer大小(k=10^3,M=10^6,...)")
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
 '(highlight-changes-visibility-initial-state nil
                                              nil (hilit-chg))
 '(python-shell-interpreter shynur/custom:python-path
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
 '(inferior-lisp-program shynur/custom:commonlisp-path
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
 '(vc-make-backup-files nil
                        nil (vc-hooks))
 '(file-preserve-symlinks-on-save t
                                  nil (files))
 '(write-region-inhibit-fsync t)
 '(create-lockfiles t
                    nil ()
                    "当对文件关联的buffer作出首个改动时,给文件上锁")
 '(remote-file-name-inhibit-locks nil
                                  nil (files))
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
 '(mouse-1-click-in-non-selected-windows t
                                         nil (mouse)
                                         "点击non-selected-window中的button/hyperlink同样会循入链接")
 '(dnd-open-file-other-window nil
                              nil (dnd))
 '(mouse-drag-and-drop-region t
                              nil (mouse))
 '(mouse-drag-and-drop-region-cut-when-buffers-differ t
                                                      nil (mouse))
 '(mouse-drag-and-drop-region-show-tooltip 100
                                           nil (mouse))
 '(compilation-scroll-output 'first-error
                             nil (compile))
 '(compilation-always-kill nil
                           nil (compile)))

;;; Feature: ‘savehist’
(shynur/custom:appdata/ savehist-file el)
(setq savehist-autosave-interval nil)
(savehist-mode)  ; 保存 minibuffer 的历史记录

;;; Feature: ‘dired’
(keymap-global-unset "C-x C-j")    ; ‘dired-jump’
(keymap-global-unset "C-x 4 C-j")  ; ‘dired-jump-other-window’
(keymap-global-unset "C-x 5 d")    ; ‘dired-other-frame’
(setq dired-maybe-use-globstar t)
;; (setq dired-listing-switches list-directory-verbose-switches) 在 MS-Windows 上用不了
(setq dired-switches-in-mode-line nil)

;;; Feature: ‘desktop’ [X]
(setq desktop-restore-eager t)  ; 尽快恢复 buffer, 而不是 idle 时逐步恢复.
(setq desktop-load-locked-desktop t)  ; Lock 文件 是为了 防止其它 Emacs 实例将其复写, 但我的电脑上只会有一个 Emacs 实例. 所以即使文件是 locked, 也只能是因为上一次 session 中 Emacs 崩溃了.
(setq desktop-auto-save-timeout nil)  ; Idle 时不自动保存, 毕竟 session 结束时会自动保存.
(setq desktop-restore-frames nil)
;; ‘desktop-files-not-to-save’: 默认不保存 Remote file.
(shynur/custom:appdata/ desktop-dirname /)
(shynur/custom:appdata/ desktop-base-file-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-file-name.el")
(shynur/custom:appdata/ desktop-base-lock-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-lock-name.el")
(setq desktop-save t)

;;; Feature: ‘recentf’
(shynur/custom:appdata/ recentf-save-file el)
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
                                 ;; ‘年份’前面加两个空格, 使右侧和‘分钟’对齐.
                                 "%m/%d  %Y"))
(setq ls-lisp-support-shell-wildcards t)

;;; Feature: ‘so-long’
(global-so-long-mode)

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
                  (let ((clang-format shynur/custom:clang-format-path)
                        (options `("--Werror"
                                   "--fallback-style=none"
                                   "--ferror-limit=0"
                                   ,(format "--style=file:%s"
                                            (expand-file-name "~/.emacs.d/etc/clang-format.yaml"))))
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
                            (goto-char 1)
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
