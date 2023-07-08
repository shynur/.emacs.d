#! /bin/make -f
### ~shynur/.emacs.d/GNUmakefile

.PHONY: clean

# 改完了记得更新“.dir-locals.el”中的“(eval . (global-set-key (kbd "C-c c") ...))”
clean:
	rm --force --recursive .shynur/
	rm --force             README.html*
	rm --force             docs/Emacs-regexp.html*     docs/Emacs-regexp.tex*     docs/Emacs-regexp.pdf
	rm --force             docs/Emacs-use_daemon.html* docs/Emacs-use_daemon.pdf
	rm --force --recursive elpa/

# Local Variables:
# coding: utf-8-unix
# End:
