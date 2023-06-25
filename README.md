<!-- ~shynur/.emacs.d/README.md -->

# `~shynur/.emacs.d`

![Glimpse of Shynur’s Emacs](https://raw.githubusercontent.com/shynur/shynur/main/Pictures/Emacs/2023-6-17.png "五子棋, 输了...")

🥰 这是我的 Emacs 个人配置方案, from scratch.

🔬 当前正在阅读 [*GNU Emacs Manual*](https://www.gnu.org/software/emacs/manual/html_node/emacs) 和 [*GNU Emacs Lisp Reference Manual*](https://www.gnu.org/software/emacs/manual/html_node/elisp);
之后将会使用 [`use-package`](https://github.com/jwiegley/use-package) 进行彻底的重构.

📖 目录结构 (点划线之下为执行 `emacs -u shynur` 之后会生成的文件):

```
./
 |
 |__ .dir-locals.el (本地变量, 应用于: .dir-locals.el, early-init.el,
 |                                      init.el, shynur/*, README.md)
 |
 |__ early-init.el
 |
 |__ init.el
 |
 |__ shynur/ (个人向的库合集)
 |    |
 |    |__ machine.el (该文件可有可无, 用于削减在不同机器间使用本配置的难度: 例
 |    |               如, 某机器上没有配置中提到的某字体, 那么那台机器就需要在
 |    |               该文件中指定替代字体.)
 |    |
 |    |__ clang-format.yaml
 |
 |__ README.md (this file)
 |
-|->8·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-
 |
 |__ elpa/
 |
 |__ .shynur/ (使用过程中生成的文件, 含临时文件.  这些文件都可能包含隐私信息,
               所以不放在 /tmp/ 目录下.)
```

## 键位

### 键盘输入

对调了键盘上的*圆括号* (<kbd>(</kbd><kbd>)</kbd>) 与*方括号* (<kbd>[</kbd><kbd>]</kbd>).  <br>
而*大括号* (<kbd>{</kbd><kbd>}</kbd>) 与*数字* (<kbd>9</kbd><kbd>0</kbd>) 不受任何影响.  <br>
(BTW, 其它软件做得到吗?)

### 快捷键

- 未换绑任何默认快捷键, 除了那些自带备选方案的 (e.g., 手册中提到 <kbd>C-x C-b</kbd> 可换绑到 `bs-show`);
- 取消了很多不必要的默认快捷键;
- 自定义了以 <kbd>C-c <letter></kbd> 起手的快捷键.  See below.

### 新增快捷键 (<kbd>C-c <letter></kbd>)

<kbd>C-c c</kbd><br>
高亮截至目前为止, 修改过的文本部分.

<kbd>C-c d</kbd><br>
选中区域后执行此键, 按*方向键*可以上下左右平移选中的文本.

<kbd>C-c f</kbd><br>
调用 `clang-format` 美化代码.  光标的相对位置保持不变.  非编程语言的缓冲区中可选中一段可能是编程语言的区域进行美化.

<kbd>C-c g</kbd><br>
立刻执行垃圾收集.

<kbd>C-c h</kbd><br>
持久性地高亮选中区域.

<kbd>C-c s</kbd><br>
以 Elisp 数据类型为关键词, 搜索相关 API.

## Written for

Latest version, using GUI, run as daemon-clients ([如何运行 Emacs 后台服务?](./shynur/Emacs-use_daemon.md)).

- on MS-Windows 11

## TODO

- 不应该单纯开启 `global-display-line-numbers-mode`, 而是应该给出一个分类机制, 有需要的 mode 才打开 `display-line-numbers-mode`.  有的 mode (e.g., neotree, calendar, ...) 显示行号反而会占用空间.
- 将任何 non-selected window 且是 `prog-mode` 的 buffer 开启全局彩虹括号.  `highlight-parentheses` 只会高亮光标附近的括号, 其余地方还是一尘不变, 这样不太 fancy.
- 拖动 GUI 时自动缩小应用窗口.
- <kbd>C-h v</kbd> 后按 <kbd>TAB</kbd> 补全时, 过滤掉 `prefix--*` 和 `*-internal`.
- 修改 `minibuffer-local-map` 和 `minibuffer-local-ns-map`.
- 用 context-menu 替代 menubar.
- 写修改 <kbd>NumberLock</kbd> 映射到 <code>`</code>, <kbd>CapitalizedLock</kbd> 映射到 <code>Control</code> 的文章.

## LICENSE

***For now*, I retain all rights to this repository.**

Will include an open source license someday in the future when I’ve learned enough about open source licenses.

<!-- Local Variables: -->
<!-- coding: utf-8-unix -->
<!-- End: -->
