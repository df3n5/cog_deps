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

build_openal () {
    pushd src/OpenAL
    mkdir build
    pushd build
    cmake ../src
    make
    make install DESTDIR=$dest_dir
    popd
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


#build_freealut
#build_freetype2
#build_glew
build_openal
#build_png
#build_sdl
