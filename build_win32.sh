
#Create directories
mkdir -p arch32/{include,lib}
pushd arch32
dest_dir=`pwd`
popd

#SDL2
pushd src/SDL2
./configure
make
make install DESTDIR=$dest_dir
popd
