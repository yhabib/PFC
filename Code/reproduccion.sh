#!/bin/bash

#*****************************************************************************************************************************#
#										reproduccion.sh									  
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
	#DESCRIPCION
#-----------------------------------------------------------------------------------------------------------------------------#

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
video1=$folder/Pantalla1Audio.mp4
video2=$folder/Pantalla2.mp4

vlc $video1 --input-slave=$video2