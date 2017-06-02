#! /bin/sh
set -x

pkgname=diffutils-3.3

# get the file
[[ ! -f "${pkgname}.tar.xz" ]] && wget http://ftp.gnu.org/gnu/diffutils/${pkgname}.tar.xz

# extract the tarball
[[ -d "${pkgname}" ]] && rm -rf "${pkgname}"
tar xf ${pkgname}.tar.xz

# apply patches
cd ${pkgname}

for file in ../patches/*.patch
do
    patch -p0 -i "$file"
done

cd ..

# prep the output directory
[[ -d "out/${MINGW_CHOST}" ]] && rm -rf "out/${MINGW_CHOST}"
mkdir -p "out/${MINGW_CHOST}"

# prep the build directory
[[ -d "build-${pkgname}" ]] && rm -rf "build-${pkgname}"
mkdir -p "build-${pkgname}"

# build & install
cd "build-${pkgname}"

../${pkgname}/configure --prefix=$PWD/../out/${MINGW_CHOST} \
    --host=${MINGW_CHOST} \
    CFLAGS=-static LDFLAGS=-static

make

make install

# copy the license
cp ../${pkgname}/COPYING ../out/${MINGW_CHOST}/

# create source information
echo `git ls-remote --get-url`/commit/`git rev-parse HEAD` > ../out/${MINGW_CHOST}/SOURCES

strip.exe ../out/${MINGW_CHOST}/bin/*.exe
