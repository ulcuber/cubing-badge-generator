GIMP_SCRIPTS_PATH=$(HOME)/.config/GIMP/2.10/scripts/

run:
	./main --help

install:
	cp -f ./schemes/cubingrf-badge.scm $(GIMP_SCRIPTS_PATH)
	cp -f ./schemes/cubingrf-diploma.scm $(GIMP_SCRIPTS_PATH)
	cp -f ./schemes/cubingrf-certificate.scm $(GIMP_SCRIPTS_PATH)

all: install run

clean:
	rm -r ./badges/*
	rm -r ./diplomas/*

# TODO: combine badges to A4
# a4:
# convert -append ./badges/*.png -background white -page a4 pdf/badges.pdf
# montage -mode concatenate ./badges/*.png -tile 2x -geometry '+4+4' -auto-orient -page a4 pdf/badges.pdf
# magick ./badges/*.png -resize "%[papersize:A4]>" -geometry '+4+4' -gravity center -background white -extent "%[papersize:A4]" pdf/badges.pdf
