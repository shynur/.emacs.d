#! /bin/make -f
### ~shynur/.emacs.d/GNUmakefile

# [[https://www.gnu.org/prep/standards/html_node/Makefile-Basics.html#Makefile-Basics][Every Makefile should contain this line:]]
SHELL = /bin/sh

.PHONY: clean

# 改完了记得更新“.dir-locals.el”中的“(eval . (global-set-key (kbd "C-c c") ...))”
clean:
	rm --force --recursive  .shynur/
	rm --force              README.html*
	rm --force              docs/Emacs-regexp.html*     docs/Emacs-regexp.tex*     docs/Emacs-regexp.pdf
	rm --force              docs/Emacs-use_daemon.html* docs/Emacs-use_daemon.pdf
	rm --force --recursive  elpa/
	rm --force              shynur/*.el[cn]

# Local Variables:
# coding: utf-8-unix
# End:
