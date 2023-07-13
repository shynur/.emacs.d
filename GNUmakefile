-*- -1940380149179152408 -*-
-*- 1040292777855296725 -*-
#! /bin/make -f
### ~shynur/.emacs.d/GNUmakefile

# [[https://www.gnu.org/prep/standards/html_node/Makefile-Basics.html#Makefile-Basics][Every Makefile should contain this line:]]
SHELL = /bin/sh

.PHONY: clean

# 只需删除会对路径_补全_有影响的文件;“elpa/”这种平时根本用不到,而且也不在“.gitignore”中的,就属于没必要删除的.
# 改完了记得更新“.dir-locals.el”中的“(eval . (global-set-key (kbd "C-c c") ...))”
clean:
	rm --force  README.html*
	rm --force  docs/Emacs-regexp.html*     docs/Emacs-regexp.tex*     docs/Emacs-regexp.pdf
	rm --force  docs/Emacs-use_daemon.html* docs/Emacs-use_daemon.pdf
	rm --force  shynur/*.el[cn]

# Local Variables:
# coding: utf-8-unix
# End:
