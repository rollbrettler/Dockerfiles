#!/bin/bash
cd /build/ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="/build/ffmpeg_build" --bindir="/build/bin"
make
make install
make distclean

cd /build/ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="/build/bin:$PATH" ./configure --prefix="/build/ffmpeg_build" --bindir="/build/bin" --enable-static
PATH="/build/bin:$PATH" make
make install
make distclean

sudo apt-get install cmake mercurial
cd /build/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd /build/ffmpeg_sources/x265/build/linux
PATH="/build/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/build/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
make distclean

sudo apt-get install unzip
cd /build/ffmpeg_sources
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master
unzip fdk-aac.zip
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="/build/ffmpeg_build" --disable-shared
make
make install
make distclean

sudo apt-get install nasm
cd /build/ffmpeg_sources
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="/build/ffmpeg_build" --enable-nasm --disable-shared
make
make install
make distclean

cd /build/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="/build/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /build/ffmpeg_sources
wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
tar xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
PATH="/build/bin:$PATH" ./configure --prefix="/build/ffmpeg_build" --disable-examples --disable-unit-tests
PATH="/build/bin:$PATH" make
make install
make clean

cd /build/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="/build/bin:$PATH" PKG_CONFIG_PATH="/build/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="/build/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/build/ffmpeg_build/include" \
  --extra-ldflags="-L/build/ffmpeg_build/lib" \
  --bindir="/build/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
PATH="/build/bin:$PATH" make
make install
make distclean
hash -r
