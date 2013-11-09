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
    make
    make install
    popd
}


build_freealut
#build_png
#build_sdl
