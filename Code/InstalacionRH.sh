#!/bin/bash

# run as root!

mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_build
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_bin



yum erase ffmpeg faac libfaac x264 libx264 libvpx -y
 
yum install gcc gcc-c++ automake autoconf libtool nasm git subversion nasm pkgconfig -y


export LD_LIBRARY_PATH=/usr/local/lib/
echo /usr/local/lib > /etc/ld.so.conf.d/custom-libs.conf
ldconfig

#Xvid Codec MPEG4
wget http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
tar zxf xvidcore-1.3.2.tar.gz
cd xvidcore/build/generic
./configure --enable-shared
make && make install
ldconfig
cd ../../../

#mp3 encoder
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Flame%2Ffiles%2F&ts=1346843156&use_mirror=dfn
tar zxf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --enable-shared
make && make install
ldconfig
cd ..

#acc encoder
wget http://downloads.sourceforge.net/faac/faac-1.28.tar.gz
tar xzf faac-1.28.tar.gz
cd faac-1.28
./bootstrap
./configure --enable-shared
make && make install
ldconfig
cd ..

#
wget http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fopencore-amr%2Ffiles%2Fopencore-amr%2F&ts=1346843453&use_mirror=dfn
tar xzf opencore-amr-0.1.3.tar.gz
cd opencore-amr-0.1.3
./configure --enable-shared
make && make install
ldconfig
cd ..

#ogg format
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz
tar xzf libogg-1.3.0.tar.gz
cd libogg-1.3.0
./configure --enable-shared
make && make install
ldconfig
cd ..

#libvorbis
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
tar xzf libvorbis-1.3.3.tar.gz
cd libvorbis-1.3.3
./configure --enable-shared
make && make install
ldconfig
cd ..

#libtheora
wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
tar xjf libtheora-1.1.1.tar.bz2
cd libtheora-1.1.1
./configure --enable-shared
make && make install
ldconfig
cd ..


#Yasm is an assembler used by x264 and FFmpeg.
wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure
make && make install
ldconfig
cd ..

#Lan video transmission
git clone git://git.videolan.org/x264.git
cd x264
./configure --enable-static --enable-shared
make && make install
ldconfig
cd ..

#encocer
wget http://downloads.sourceforge.net/opencore-amr/vo-aacenc-0.1.2.tar.gz
tar xzvf vo-aacenc-0.1.2.tar.gz
cd vo-aacenc-0.1.2
./configure --enable-shared
make && make install
ldconfig
cd ..

#livpx
git clone http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --enable-shared
make && make install
ldconfig
cd ..

#zlib
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xzvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --enable-shared
make && make install
ldconfig
cd ..


git clone git://git.videolan.org/ffmpeg.git ffmpeg
cd ffmpeg
./configure --enable-version3 --enable-libopencore-amrnb \
--enable-libopencore-amrwb --enable-libvpx --enable-libfaac \
--enable-libmp3lame --enable-libtheora --enable-libvorbis \
--enable-libx264 --enable-libxvid --enable-gpl --enable-postproc \
--enable-nonfree --enable-pthreads --enable-libvo-aacenc \
--enable-postproc --enable-swscale --enable-avfilter \
--enable-shared --enable-runtime-cpudetect --enable-x11grab \
--disable-stripping \
--extra-cflags='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -fPIC'
make
make install
ldconfig