#!/bin/bash
cd /ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="/ffmpeg_build" --bindir="/build"
make
make install
make distclean

cd /ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="/build:$PATH" ./configure --prefix="/ffmpeg_build" --bindir="/build" --enable-static
PATH="/build:$PATH" make
make install
make distclean

sudo apt-get install cmake mercurial
cd /ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd /ffmpeg_sources/x265/build/linux
PATH="/build:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
make distclean

sudo apt-get install unzip
cd /ffmpeg_sources
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master
unzip fdk-aac.zip
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="/ffmpeg_build" --disable-shared
make
make install
make distclean

sudo apt-get install nasm
cd /ffmpeg_sources
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="/ffmpeg_build" --enable-nasm --disable-shared
make
make install
make distclean

cd /ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /ffmpeg_sources
wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
tar xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
PATH="/build:$PATH" ./configure --prefix="/ffmpeg_build" --disable-examples --disable-unit-tests
PATH="/build:$PATH" make
make install
make clean

cd /ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="/build:$PATH" PKG_CONFIG_PATH="/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/ffmpeg_build/include" \
  --extra-ldflags="-L/ffmpeg_build/lib" \
  --bindir="/build" \
  --enable-gpl \
  --enable-libass \
#  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
PATH="/build:$PATH" make
make install
make distclean
hash -r
