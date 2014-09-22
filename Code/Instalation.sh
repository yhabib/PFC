#!/bin/bash




#!/bin/bash

#*****************************************************************************************************************************#
#									Overlay: Script para la configuración de la sesión 										  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#La interfaz recopila la información necesaria para la sesión de grabación, esto es: el nº de pantallas, la inclusión o no del #
#audio, el tiempo de grabación,...										    #
#Se creará una carpeta para la sesion total, luego otra para cada dia de grabación y un más puqueña en función del tamaño	  #
#final de los archivos																										  #
#El bucle para obtener los datos de los monitores, en caso de que se seleccione mas de uno , ga ha de identicar la posición   #
#relativa del monitor respecto al original, derecha o izquierda. Este array solo me interesan las posiciones 1,2 en caso de q #
#3 monitores. Valores posibles i,d--> ÑLuego opero. Trabajar con strings  para la posion del monitor hacer una funcion.#
#-----------------------------------------------------------------------------------------------------------------------------#



clear


sudo apt-get update
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev


mkdir ~/Escritorio/PFC
mkdir ~/Escritorio/PFC/Ubuntu
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_build
mkdir ~/Escritorio/PFC/Ubuntu/ffmpeg_bin


#YASM
cd ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin"
make
make install
make distclean


#libx264
cd ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" ./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" --enable-static --disable-opencl
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" make
make install
make distclean


#libopus
cd ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="$$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --disable-shared
make
make install
make distclean


#libpx
cd ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
tar xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --disable-examples
make
make install
make clean



#FFmpeg
cd ~/Escritorio/PFC/Ubuntu/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" PKG_CONFIG_PATH="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" \
  --extra-cflags="-I$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/lib" \
  --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" \
  --enable-gpl \
  --enable-libass \
  #--enable-libfdk-aac \
  --enable-libfreetype \
  #--enable-libmp3lame \
  #--enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  #--enable-libvpx \
  --enable-libx264 \
  --enable-nonfree \
  --enable-x11grab
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" make
make install
make distclean
hash -r