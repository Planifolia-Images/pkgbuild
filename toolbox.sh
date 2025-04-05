#!/usr/bin/bash

repo_name='planifolia'
mkdir -p repo

if [[ $1 == 'add' ]]; then
	repo-add repo/$repo_name.db.tar.zst repo/*pkg.tar.zst
elif [[ $1 == 'build' ]]; then
	BASE_DIR=$(pwd)

	sudo pacman -Syu --noconfirm meson glib2-devel optipng librsvg base-devel python meson libadwaita gettext desktop-file-utils make ninja pkgconf glib2 libxml2 gtk-update-icon-cache libjpeg-turbo blueprint-compiler docbook-xsl git modemmanager gobject-introspection vala

	for dir in *;
	do
		if [ -d "$dir" ];
		then
			cd $dir
			makepkg -dfc
			cd $BASE_DIR
		fi
	done

elif [[ $1 == 'clear' ]]; then
	rm repo/*.old
elif [[ $1 == 'move' ]]; then

	mv ./*/*.pkg.tar.zst repo
else
	printf "No valid parameter provided\n"
fi