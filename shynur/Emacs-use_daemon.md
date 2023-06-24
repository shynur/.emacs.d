# 如何运行 Emacs 作为后台服务?

(仅考虑 GUI.)

Emacs 提供了 daemon-client 模型, 简而言之就像 QQ 那样: 在后台启动一个服务, 每次打开新窗口都是后台的那个进程弹出的.
好处显而易见, 开机启动一次, 之后就不需要重复启动了.

## MS-Windows

以 Emacs 版本 28.2 为例, `emacs-28.2/bin/runemacs.exe --daemon` 与 `emacs-28.2/bin/emacsclientw.exe` 配合使用.
假设目录 `emacs-28.2/` 位于 `c:/Users/shynur/bin/`.

### 配置 `.emacs`

```lisp
(setq server-auth-dir "c:/Users/shynur/emacs-server-auth-dir/"
      server-name     "server-name.txt")
```

以上述配置为例.

### 创建 daemon

按 <kbd>Win-R</kbd>, 输入 `shell:startup` 后回车, 进入了一个目录.
(用户在此处放置的文件将在登入时自动运行.)

在该目录中创建一个指向 `c:/Users/shynur/bin/emacs-28.2/bin/runemacs.exe` 的*快捷方式*, 右键选择*属性*, 编辑*目标*, 使之成为 `c:/Users/shynur/bin/emacs-28.2/bin/runemacs.exe --daemon`.

### 打开 client

#### 直接打开

(例如, 在桌面上双击*记事本*就属于直接打开, 而不编辑文件.)

在桌面上创建指向 `c:/Users/shynur/bin/emacs-28.2/bin/emacsclientw.exe` 的*快捷方式*, 右键选择*属性*, 编辑*目标*, 使之成为 `c:/Users/shynur/bin/emacs-28.2/bin/emacsclientw.exe --server-file=c:/Users/shynur/emacs-server-auth-dir/server-name.txt --create-frame`.

#### 编辑文件

任选一个文件, *打开方式*选择 `c:/Users/shynur/bin/emacs-28.2/bin/emacsclientw.exe`.
打开之后 (即使失败了) 直接退出.

此时 MS-Windows 应该已经在*注册表*中自动建立了 `计算机\HKEY_CLASSES_ROOT\Applications\emacsclientw.exe\shell\open\command` 这个目录.
进入该目录, 看到 `(默认)` 这一项, 右键选择*修改*, 修改为 `C:\Users\shynur\bin\emacs-28.2\bin\emacsclientw.exe --server-file=c:/Users/shynur/emacs-server-auth-dir/server-name.txt --create-frame "%1"`.
这里 `"%1"` 表示*右键选择使用 `emacsclientw.exe` 打开*时要编辑的文件的名字.

由于中国大陆政府的规定, MS-Windows 在中国大陆默认使用 Chinese-GB18030 编码, 所以为了使 `emacsclientw.exe` 正确处理 `"%1"`, 需要在 `.emacs` 中添加:

```lisp
(setq file-name-coding-system 'chinese-gb18030)
```
