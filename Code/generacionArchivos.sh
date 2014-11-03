#!/bin/bash

#**************************************************************************************************************************
#										generacionArchivos.sh					 	
#**************************************************************************************************************************

#--------------------------------------------------------------------------------------------------------------------------
#Su función es la de generar los archivos de reproducción final. Para ello hace uso de las funciones  
#de FFmpeg concat para realizar la concatenación del video del monitor principal y del audio, y overlay,
#para construir un archivo de salida a partir de las 2 instancias de video y la de audio.
#--------------------------------------------------------------------------------------------------------------------------

clear

#Variables
declare video1
declare video2
declare audio
declare output
declare folder
#--------------------------------------------------------------------------------------------------------------------------

#Code
path=~/Proyecto/Grabaciones
softwarePath=`pwd`

tput sgr0
tput bold
tput cup 1 1
echo "Script basado en FFmpeg para la generación de los archivos finales"
cd $path
tput sgr0
tput cup 3 2
echo "Dias disponibles" 
ls
tput cup 6 2
read -p "Día? " dia
cd $dia
tput cup 8 2
echo "Sesiones disponibles" 
ls
tput cup 10 2
read -p "Sesión? " sesion
cd $sesion

folder=$path/$dia/$sesion
video1=$folder/Pantalla1.mp4
video2=$folder/Pantalla2.mp4
video=$folder/Pantalla1Audio.mp4
audio=$folder/Audio.mp3
output=$folder/Overlay.mp4


#Genero archivo overlay con pantalla1, pantalla2, y audio
cd $softwarePath && gnome-terminal --tab -e "bash overlay.sh $video1 $video2 $audio $output"

#Concateno audio y pantalla1
cd ~/bin && ./ffmpeg -i $video1 -i $audio -c:v copy -c:a aac -strict experimental $video

#Genero archivo overlay con pantalla1, pantalla2, y audio


#cd ~/bin && ./ffmpeg -i $video1 -i $video2 -i $audio  -filter_complex "[0:v]setpts=PTS-STARTPTS, pad=iw*2:ih[bg]; \
#[1:v]setpts=PTS-STARTPTS[fg]; [bg][fg]overlay=w" $output

