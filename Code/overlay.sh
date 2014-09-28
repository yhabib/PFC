#!/bin/bash

#*****************************************************************************************************************************#
#									Overlay: Para generar un archivo con los dos videos más el audio						  #	
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

#Variables
declare video1
declare video2
declare audio
declare output
declare folder=$1
#------------------------------------------------------------------------------------------------------------------------_

#Code
#cd $folder 
video1=$folder/Pantalla1.mp4
video2=$folder/Pantalla2.mp4
audio=$folder/Audio.mp3
output=$folder/Overlay.mp4

echo $folder
echo $video1
echo $video2
echo $audio

sleep 10
cd ~/bin && ./ffmpeg -i $video1 -i $video2 -i $audio  -filter_complex "[0:v]setpts=PTS-STARTPTS, pad=iw*2:ih[bg]; \
[1:v]setpts=PTS-STARTPTS[fg]; [bg][fg]overlay=w" $output



