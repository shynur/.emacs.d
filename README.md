# `~shynur/.emacs.d`

![Glimpse of Shynur’s Emacs](https://raw.githubusercontent.com/shynur/misc/main/pictures/emacs/2023-6-17.png "五子棋, 输了...")

🥰 这是我的 Emacs 个人配置方案, from scratch.

🔬 当前正在阅读 [*GNU Emacs Manual*](https://www.gnu.org/software/emacs/manual/html_node/emacs) 和 [*GNU Emacs Lisp Reference Manual*](https://www.gnu.org/software/emacs/manual/html_node/elisp);
之后将会使用 [`use-package`](https://github.com/jwiegley/use-package) 进行彻底的重构.

📖 目录结构 (点划线之下为执行 `emacs -u shynur` 之后会生成的文件):

```
./
 │__ early-init.el
 │
 │__ init.el
 │
 │__ shynur/ (个人向的库合集)
 │    |
 │    |__ machine.el (该文件可有可无, 用于削减在不同机器间使用本配置的难度: 例
 │                    如, 某机器上没有配置中提到的某字体, 那么那台机器就需要在
 │                    该文件中指定替代字体.)
 │
 │__ README.md (this file)
 │
-│->8·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-
 │
 │__ elpa/
 │
 │__ .shynur/ (使用过程中生成的文件, 含临时文件.  这些文件都可能包含隐私信息,
               所以不放在 /tmp/ 目录下.)
```

## Written for

- 🪟 v28.2 on Windows 11, using GUI

## TODO

- 不应该单纯开启 `global-display-line-numbers-mode`, 而是应该给出一个分类机制, 有需要的 mode 才打开 `display-line-numbers-mode`.  有的 mode (e.g., neotree, calendar, ...) 显示行号反而会占用空间.
- 将任何 non-selected window 且是 `prog-mode` 的 buffer 开启全局彩虹括号.  `highlight-parentheses` 只会高亮光标附近的括号, 其余地方还是一尘不变, 这样不太 fancy.
- 拖动 GUI 时自动缩小应用窗口.
- <kbd>C-h v</kbd> 后按 <kbd>TAB</kbd> 补全时, 过滤掉 `prefix--*` 和 `*-internal`.
- 修改 `minibuffer-local-map` 和 `minibuffer-local-ns-map`.
- 用 context-menu 替代 menubar.

## LICENSE

***For now*, I retain all rights to this repository.**

Will include an open source license someday in the future when I’ve learned enough about open source licenses.
