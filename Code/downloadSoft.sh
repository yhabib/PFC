#!/bin/bash

#*****************************************************************************************************************************
#										downloadSoft.sh									  
#*****************************************************************************************************************************

#-----------------------------------------------------------------------------------------------------------------------------
#Este script se encarga de conectarse a los repositorios necesarios para la descarga de todos
#los paquetes necesarios para le funcionamiento del programa.
#Crea una carpeta para las descargas donde se le indique en su llamada.
#-----------------------------------------------------------------------------------------------------------------------------

clear

#Variables
declare directorio=$1

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
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
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

#Code

gotDirectorio $directorio

wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
wget http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Flame%2Ffiles%2F&ts=1346843156&use_mirror=dfn
wget http://downloads.sourceforge.net/faac/faac-1.28.tar.gz
wget http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fopencore-amr%2Ffiles%2Fopencore-amr%2F&ts=1346843453&use_mirror=dfn
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz
wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
git clone git://git.videolan.org/x264.git
wget http://downloads.sourceforge.net/opencore-amr/vo-aacenc-0.1.2.tar.gz
git clone http://git.chromium.org/webm/libvpx.git
wget http://zlib.net/zlib-1.2.8.tar.gz
git clone git://git.videolan.org/ffmpeg.git ffmpeg
