# 依赖图

```
site-lisp/subdirs.el

site-lisp/leim-list.el

early-init.el
  |
  |__ lisp/shynur-early-init.el
        |
        |__ etc/shynur-custom.el
        |
        |__ lisp/shynur-package.el

site-lisp/site-start.el

init.el
  |
  |__ lisp/shynur-init.el
        |
        |__ lisp/shynur-elisp.el
        |
        |__ lisp/shynur-tmp.el
        |
        |__ lisp/shynur-org.el
        |
        |__ lisp/shynur-abbrev.el
        |
        |__ lisp/shynur-server.el
        |
        |__ lisp/shynur-cc.el
        |
        |__ lisp/shynur-kbd.el
        |
        |__ lisp/shynur-sh.el
        |
        |__ lisp/shynur-yas.el
        |
        |__ lisp/shynur-profile.el
        |
        |__ lisp/shynur-startup.el
        |
        |__ lisp/shynur-ui.el
        |     |
        |     |__ lisp/themes/shynur-themes.el
        |
        |__ lisp/shynur-lib.el

site-lisp/default.el

etc/abbrev_defs.el
```

位于 `modules/` 下的动态链接库也可加载, 这是可选的.
(另外还写了一个 `modules/shynur-hello.dll` 当玩具, 可以在任何时间加载.)

___

后续会补充 目录/文件 的 说明.

<!-- Local Variables: -->
<!-- coding: utf-8-unix -->
<!-- End: -->
