#!/bin/bash
set -e

#Create directories
PLATFORM="linux32"
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
    export PATH="$dest_dir/bin:$PATH"
    export BIN_PATH=$dest_dir/bin 
    export INCLUDE_PATH=$dest_dir/include 
    export LIBRARY_PATH=$dest_dir/lib
    export CMAKE_LIBRARY_PATH="${CMAKE_LIBRARY_PATH}:$dest_dir/lib"
    export CMAKE_INCLUDE_PATH="$dest_dir/include/"
    export C_INCLUDE_PATH="${C_INCLUDE_PATH}:$dest_dir/include"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$dest_dir/lib"
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
    mkdir -p build
    pushd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH= ../
    make
    make install DESTDIR=$dest_dir
    popd
    popd
}

build_zlib () {
    pushd src/zlib
    chmod +x configure
    ./configure --prefix=$dest_dir
	make -f Makefile BIN_PATH=$dest_dir/bin INCLUDE_PATH=$dest_dir/include LIBRARY_PATH=$dest_dir/lib install
    popd
}

build_png () {
    pushd src/png
    mkdir -p build
    pushd build
    export BIN_PATH=$dest_dir/bin 
    export INCLUDE_PATH=$dest_dir/include 
    export LIBRARY_PATH=$dest_dir/lib
    export CMAKE_LIBRARY_PATH="${CMAKE_LIBRARY_PATH}:$dest_dir/lib"
    export CMAKE_INCLUDE_PATH="$dest_dir/include/"
    export C_INCLUDE_PATH="${C_INCLUDE_PATH}:$dest_dir/include"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$dest_dir/lib"
    cmake -DCMAKE_INSTALL_PREFIX:PATH= ../
    echo `pwd`
    make
    make install DESTDIR=$dest_dir
    popd
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


#build_zlib
#build_openal
#build_freealut
#build_png
build_freetype2
build_glew
#build_sdl

#build_luajit
