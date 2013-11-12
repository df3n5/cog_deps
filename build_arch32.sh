#!/bin/bash

#Create directories
PLATFORM="arch32"
mkdir -p $PLATFORM/{include,lib}
pushd $PLATFORM
dest_dir=`pwd`
popd

build_freealut () {
    pushd src/freealut
    ./autogen.sh
    ./configure --prefix=$dest_dir
    make
    make install
    popd
}

build_freetype2 () {
    pushd src/freetype2
    ./autogen.sh
    ./configure --prefix=$dest_dir
    make
    make install
    popd
}

build_glew () {
    pushd src/glew
    sed -i 's|lib64|lib|' config/Makefile.linux
    make GLEW_DEST=$dest_dir install.all
    popd
}

build_luajit () {
    pushd src/luajit-2.0
    make
    make install PREFIX=$dest_dir
    popd
}

build_openal () {
    pushd src/openal-soft
    pushd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH= ../
    make
    make install DESTDIR=$dest_dir
    popd
    popd
}

build_zlib () {
    pushd src/zlib
    ./configure --prefix=$dest_dir
	make -f win32/Makefile.gcc BINARY_PATH=$dest_dir/bin INCLUDE_PATH=$dest_dir/include LIBRARY_PATH=$dest_dir/lib install
    popd
}

build_png () {
    pushd src/png
    ./autogen.sh
    ./configure --prefix=$dest_dir
    make
    make install
    popd
}

build_sdl () {
    pushd src/SDL2
    ./autogen.sh
    ./configure --prefix=$dest_dir
    make extensions
    make
    make install
    popd
}


build_freealut
build_freetype2
build_glew
build_luajit
build_openal
#build_zlib
build_png
build_sdl
