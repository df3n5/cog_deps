
#Create directories
mkdir -p arch32/{include,lib}
pushd arch32
dest_dir=`pwd`
popd

#libpng
echo "Building libpng..."
pushd src/libpng
./configure --prefix=$dest_dir
make
make DESTDIR=$dest_dir install
popd
echo "Built libpng..."

#SDL2
#pushd src/SDL2
#./autogen.sh
#./configure --prefix=$dest_dir
#make
#make DESTDIR=$dest_dir install
#popd
