#! /usr/bin/make -f

# [[https://www.gnu.org/prep/standards/html_node/Makefile-Basics.html#Makefile-Basics][Every Makefile should contain this line:]]
SHELL = /bin/sh

.PHONY: clean
clean:
	rm --force --recursive  ./.data/
	rm --force              ./{.,etc,{,site-}lisp,scripts}/**/*.el[cn]
	rm --force              ./*.{html,pdf,tex}*
	rm --force              ./docs/pages/*
	rm --force              ./modules/*.{so,dylib,dll}

# Local Variables:
# coding: utf-8-unix
# End:
