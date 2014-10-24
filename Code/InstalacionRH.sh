#!/bin/bash

#*********************************************************************************************************************
#										generacionArchivos.sh					 	
#*********************************************************************************************************************

#---------------------------------------------------------------------------------------------------------------------
#Instalador para CentOs. Funciona diferente al de Ubuntu ya que está optimizado para la versión 5.5, la cual
#fue liberada hace 4 años.
#---------------------------------------------------------------------------------------------------------------------

mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_build
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_bin


#Limpia las dependecias e instala de repositorio todos los paquetes y librerias necesarias
yum erase ffmpeg faac libfaac x264 libx264 libvpx -y
yum install gcc gcc-c++ automake autoconf libtool nasm git subversion nasm pkgconfig -y

#Configura el archivo custom-libs.conf
export LD_LIBRARY_PATH=/usr/local/lib/
echo /usr/local/lib > /etc/ld.so.conf.d/custom-libs.conf
ldconfig
#----------------------------------------------------------------------------------------------------------------------

#A traves del programa wget descarga todo el software externo al repositorio

#Xvid Codec MPEG4
tar zxf xvidcore-1.3.2.tar.gz
cd xvidcore/build/generic
./configure --enable-shared
make && make install
ldconfig
cd ../../../

#mp3 encoder
tar zxf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --enable-shared
make && make install
ldconfig
cd ..

#acc encoder
tar xzf faac-1.28.tar.gz
cd faac-1.28
./bootstrap
./configure --enable-shared
make && make install
ldconfig
cd ..

#
tar xzf opencore-amr-0.1.3.tar.gz
cd opencore-amr-0.1.3
./configure --enable-shared
make && make install
ldconfig
cd ..

#ogg format
tar xzf libogg-1.3.0.tar.gz
cd libogg-1.3.0
./configure --enable-shared
make && make install
ldconfig
cd ..

#libvorbis
tar xzf libvorbis-1.3.3.tar.gz
cd libvorbis-1.3.3
./configure --enable-shared
make && make install
ldconfig
cd ..

#libtheora
tar xjf libtheora-1.1.1.tar.bz2
cd libtheora-1.1.1
./configure --enable-shared
make && make install
ldconfig
cd ..


#Yasm 
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure
make && make install
ldconfig
cd ..

#x264
cd x264
./configure --enable-static --enable-shared
make && make install
ldconfig
cd ..

#encocer aac
tar xzvf vo-aacenc-0.1.2.tar.gz
cd vo-aacenc-0.1.2
./configure --enable-shared
make && make install
ldconfig
cd ..

#livpx
cd libvpx
./configure --enable-shared
make && make install
ldconfig
cd ..

#zlib
tar xzvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --enable-shared
make && make install
ldconfig
cd ..


#FFmpeg
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