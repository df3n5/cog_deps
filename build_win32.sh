#!/bin/bash

#Create directories
PLATFORM="win32"
mkdir -p $PLATFORM/{include,lib}
pushd $PLATFORM
dest_dir=`pwd`
popd

build_freealut () {
    pushd src/freealut
	mkdir build
	pushd build
	export CMAKE_LIBRARY_PATH="${CMAKE_LIBRARY_PATH}:$dest_dir/lib"
	export CMAKE_INCLUDE_PATH="${CMAKE_INCLUDE_PATH}:$dest_dir/include/AL"
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:$dest_dir/include"
	export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$dest_dir/lib"
	cmake -G"MSYS Makefiles" -DCMAKE_INSTALL_PREFIX:PATH= ../
    make
    make install DESTDIR=$dest_dir
	popd
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
    pushd src/win32/glew-1.10.0
    make GLEW_DEST=$dest_dir install.all
    popd
}

build_luajit () {
    pushd src/win32/luajit-2.0
	mingw32-make clean
	mingw32-make
	cp src/lua51.dll $dest_dir/bin
	cp src/luajit.exe $dest_dir/bin
	mkdir -p $dest_dir/bin/lua/jit
	cp -rf src/jit/* $dest_dir/bin/lua/jit
    popd
}

build_openal () {
    pushd src/openal-soft
    pushd build
    cmake -G"MSYS Makefiles" -DCMAKE_INSTALL_PREFIX:PATH= ../
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

build_lpng () {
    pushd src/win32/lpng
	export LD_LIBRARY_PATH=$dest_dir/lib
	export C_INCLUDE_PATH=$dest_dir/include
	make clean
    make
    make install prefix=$dest_dir ZLIBLIB=$dest_dir/lib ZLIBINC=$dest_dir/include LIBPATH=$dest_dir/lib
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
#build_freetype2
#build_glew # DONE
#build_luajit # DONE
#build_openal # DONE
#build_zlib # DONE
#build_lpng # DONE
#build_sdl
