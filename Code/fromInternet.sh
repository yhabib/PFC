#!/bin/bash

#*****************************************************************************************************************************#
#                                       fromInternet.sh                 
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#Su función es la de intalar todas las librerías, dependencias, programas auxiliares, ...
#necesarios. Para ello inicialmente instala a través del repositorio. Está script logra la instalación
#en una máquina que corra una distribución linux del tipo Ubuntu.
#Descarga, descomprime, configura, compila e instala cada uno de los paquetes.
#----------------------------------------------------------------------------------------------------------------------------

clear


#Variables
declare directorioDownload
declare directorioInstall
#----------------------------------------------------------------------------------------------------------------------------

#Funciones

#En caso de que exista la carpeta directamente entra en ella, en otro caso la crea y luego entra
gotDirectorio()
{
  if [ ! -d $1 ]; then 
    mkdir $1
    cd $1
  elif  then
    cd $1
}

#Extrae el archivo comprimido que se le pasa como argumento. Para ello compara su extensión con las
#listadas y en función de eso aplica una determinada descompresión.
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjvf $1     ;;
        *.tar.gz)    tar xzvf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
#----------------------------------------------------------------------------------------------------------------------------


#Instala de los repositorios todos los paquetes y librerias necesarias
sudo apt-get update
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev
#----------------------------------------------------------------------------------------------------------------------------

tput clear
tput cup 3 9
read -p "Instalador del Software desde Internet"

bash downloadSoft.sh


#YASM
extract directorioDownload/yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin"
make
make install
make distclean
cd ..

#libx264
extract directorioDownload/last_x264.tar.bz2
cd x264-snapshot*
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" ./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" --enable-static --disable-opencl
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" make
make install
make distclean
cd ..

#libopus
extract directorioDownload/xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="$$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --disable-shared
make
make install
make distclean
cd ..

#libpx
extract directorioDownload/xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
./configure --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" --disable-examples
make
make install
make clean
cd ..

#FFmpeg
extract directorioDownload/xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" PKG_CONFIG_PATH="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build" \
  --extra-cflags="-I$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/Escritorio/PFC/Ubuntu/ffmpeg_build/lib" \
  --bindir="$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" \
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
  --enable-nonfree \
  --enable-x11grab
PATH="$PATH:$HOME/Escritorio/PFC/Ubuntu/ffmpeg_bin" make
make install
make distclean
hash -r
cd ..