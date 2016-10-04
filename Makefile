#
# Install asciidoc with:
#  brew install asciidoc
#
# For PDF generation install:
#  brew install fop
#
# For code formatting also install:
#  sudo easy_install Pygments
#

iconsdir := $(shell brew list asciidoc | grep /etc/asciidoc | head -n1 | egrep -o '.*/etc/asciidoc')/images/icons

default:
	asciidoc \
		-b html5 \
		-a theme=flask \
		-a toc2 \
		-a data-uri \
		-a docinfo \
		-a icons \
		-a pygments \
		-a iconsdir=$(iconsdir) \
		-o index.html \
		thrift.asciidoc

pdf:
	a2x --fop \
		-a toc \
		-a data-uri \
		-a docinfo \
		-a icons \
		-a pygments \
		-a iconsdir=$(iconsdir) \
		-a pygments \
		--no-xmllint \
		thrift.asciidoc

all: default pdf

clean:
	rm -f index.html *.png

publish: default pdf
	./publish.sh
