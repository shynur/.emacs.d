.. See `reStructuredText Markup Specification <https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html>`_.

Installation Guide
==================

假设你的机器上有 名为 *shynur* 的用户, 他将 Emacs 安装在 ``c:/Users/shynur/bin/`` 目录下.


.. contents::


Download
--------

From repository
^^^^^^^^^^^^^^^

将 `本仓库 <https://github.com/shynur/.emacs.d>`_ 解压至 ``c:/Users/shynur/``
(或 类似 ``c:/Users/shynur/.config/`` 的 XDG-兼容 位置, see `How Emacs Finds Your Init File`_),
确保能看到 ``c:/Users/shynur/.emacs.d/INSTALL.rst`` (this file).
(如果 安装在 XDG-compatible 位置, 则需要修改目录名, 确保存在类似 ``c:/Users/shynur/.config/emacs/INSTALL.rst`` 的路径.)

(下文所有提及的相对路径, 都是基于 ``c:/Users/shynur/.emacs.d/`` 目录.)

.. _How Emacs Finds Your Init File: https://gnu.org/s/emacs/manual/html_node/emacs/Find-Init.html

Out of the box (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^

也可以直接下载我本地编译好的配置, 见 `README.org <./README.org>`_.
但是会小概率出现不兼容现象, 并且我不会及时更新它.

Place site-wide libraries
^^^^^^^^^^^^^^^^^^^^^^^^^

将 ``site-lisp/`` 下的所有文件及子目录移动到 ``c:/Users/shynur/bin/emacs-VERSION/share/emacs/site-lisp/``
(在 GNU-like 系统上, 是像 ``/usr/local/share/emacs/site-lisp/`` 的目录).

如果有重复文件, 请自行判断是否要‘替换’或‘跳过’, 总之不影响结果.


Configure
---------

Customize
^^^^^^^^^

编辑 ``etc/shynur-custom.el`` 文件进行本地化配置.
(这应当不需要 Emacs Lisp 知识.)

(假设你将该文件中的 变量 ``shynur/c-appdata/`` 的值设为 ``~/.emacs.d/.appdata/``.)

Requisites
^^^^^^^^^^

`README.org <./README.org#prerequisites>`_ 中列出了依赖项目,
其中, 字体 是 **必须** 的.


Compile
-------

环境变量 (Optional)
^^^^^^^^^^^^^^^^^^^

在 MS-Windows 上, 需要显式地指出用户的 HOME 目录 (see `Where do I put my init file?`_):

设置 -> 系统信息 -> 高级系统设置 -> 环境变量 -> 新建 (*shynur* 的用户变量),
将变量 ``HOME`` 设为 ``C:/Users/shynur/``.

.. _Where do I put my init file?: https://gnu.org/s/emacs/manual/html_mono/efaq-w32.html#Location-of-init-file

Fetch Packages
^^^^^^^^^^^^^^

从各类 ELPA 网站上获取 Emacs packages, 请确保你有正常的网络环境.

执行如下命令::

    PS C:\Users\shynur> ./bin/emacs-VERSION/bin/emacs.exe --kill

等到 Emacs 正常退出后, 应该能看到类似 ``.appdata/package-user-directory/`` 的路径, 该目录下是编译好的 package.

Compile configuration files (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Byte-compile Emacs Lisp files
:::::::::::::::::::::::::::::

有些配置文件也可以编译 (反正我懒得编译), see `.dir-locals.el <./.dir-locals.el>`_.

动态链接库 (perhaps Required at some point in the future)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

在 ``.emacs.d/modules/src/`` 下有名如 ``shynur-*.c`` 的 C 文件, 参见 `modules/src/shynur-hello.c <./modules/src/shynur-hello.c>`_ 中提示的编译指令.
编译后会在 ``modules/`` 下生成动态链接库, 例如 ``modules/shynur-hello.dll`` (其中的模块函数演示了一个简化的柯里化概念, 可以编译下来玩玩).


Test
----

Start process
^^^^^^^^^^^^^

执行如下命令::

    PS C:\Users\shynur> ./bin/emacs-VERSION/bin/emacsclientw.exe --server-file=c:/Users/shynur/.emacs.d/.appdata/server-auth-dir/server-name.txt --alternate-editor="" --create-frame

此时 Emacs 首先在后台创建了一个 daemon (see `如何运行 Emacs 作为后台服务进程? <./docs/Emacs-use_daemon.md>`_),
然后 (耐心点) 会弹出一个窗口, 默认会打开 ``user-emacs-directory/`` 目录.

Create frame
^^^^^^^^^^^^

将当前窗口关闭, 再次运行上一节提到的命令, Emacs 会瞬间 (在我的电脑上是 0.7s) 启动.
这是因为关闭窗口并没有结束 Emacs 的进程, Emacs 将会一直驻留在后台.


善后
----

基本上没有需要清理的中间文件.
但如果你想从头开始安装的话, 请::

    ~/.emacs.d $ make clean


..
   Local Variables:
   coding: utf-8-unix
   End:
