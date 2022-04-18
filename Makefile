NAME	= openssl-s_client-enddate-days-json
SPEC	= $(NAME).spec
VERSION	= $(shell sed -e '/Version:/!d' -e 's/[^0-9.]*\([0-9.]*\).*/\1/' $(SPEC))
BIN	= $(NAME).pl
AUX	= $(SPEC) Makefile
DISTDIR	= $(NAME)-$(VERSION)
SRCS	= $(CONF) $(BIN)

dist:	$(SRCS) $(AUX)
	-rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	ln $(AUX) $(SRCS) $(DISTDIR)
	tar chzfv $(DISTDIR).tar.gz $(DISTDIR)
	-rm -rf $(DISTDIR)

$(DISTDIR).tar.gz: dist

rpm:	$(DISTDIR).tar.gz
	rpmbuild -ta $(DISTDIR).tar.gz
