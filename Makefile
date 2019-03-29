.PHONY: clean install run

ELS  =  nix-haskell-mode.el
ELCS = $(ELS:.el=.elc)

DESTDIR =
PREFIX  = /usr

all: $(ELCS)

install: $(ELCS) $(DOCS)
	mkdir -p $(DESTDIR)$(PREFIX)/share/emacs/site-lisp/nix-haskell-mode/
	cp $(ELCS) $(DESTDIR)$(PREFIX)/share/emacs/site-lisp/nix-haskell-mode/

clean:
	rm -f $(ELCS)

run:
	emacs -l nix-haskell.el

%.elc: %.el
	emacs -batch -L . --eval "(progn\
	(when (file-exists-p \"$@\")\
	  (delete-file \"$@\"))\
	(fset 'message* (symbol-function 'message))\
	(fset 'message  (lambda (f &rest a)\
	                  (unless (equal f \"Wrote %s\")\
	                    (apply 'message* f a)))))" \
	-f batch-byte-compile $<
