#! /bin/make -f
### ~shynur/.emacs.d/Makefile

.PHONY: clean
clean:
	rm --force  --recursive elpa/
	rm --force  --recursive .shynur/
	rm --force              .github/REAME.html*

# Local Variables:
# coding: utf-8-unix
# End:
