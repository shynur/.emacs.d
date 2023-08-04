#! /usr/bin/make -f

# [[https://www.gnu.org/prep/standards/html_node/Makefile-Basics.html#Makefile-Basics][Every Makefile should contain this line:]]
SHELL = /bin/sh

.PHONY: clean docs

# 诸如 auto-save 等文件 不必清理, 它们对备份/恢复很重要.
clean:
	rm --force                                         ./**/?*.el[cn]
	mkdir --parents ./docs/pages/.empty/ ; rm --force  ./docs/pages/*
	rm --force                                         ./modules/?*.{so,dylib,dll}

docs:
	mkdir --parents  ./docs/pages/
	pandoc --from=textile  --to=html -o docs/pages/CONTRIBUTING.html      .github/CONTRIBUTING.textile
	pandoc --from=rst      --to=html -o docs/pages/INSTALL.html			  INSTALL.rst
	pandoc --from=markdown --to=html -o docs/pages/MANIFEST.html		  MANIFEST.md
	yes | cp --remove-destination --target-directory=docs/pages/          MS_Windows-keyboard_remap.txt
	pandoc --from=org      --to=html -o docs/pages/README.html			  README.org
	yes | cp --remove-destination --target-directory=docs/pages/          docs/Emacs-FAQ.txt
	pandoc --from=org      --to=html -o docs/pages/Emacs-regexp.html	  docs/Emacs-regexp.org
	pandoc --from=markdown --to=html -o docs/pages/Emacs-use_daemon.html  docs/Emacs-use_daemon.md


# Local Variables:
# coding: utf-8-unix
# End:
