#!/bin/bash

#*****************************************************************************************************************************#
#									AudioRecord: Script para la grabación de audio										  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#Se obtienen los parámetros relevantes para la grabacion de una instancia de video. Estos son: la resolucion de la pantalla,  #
#la posición de esta, los frames por segundo*, el nombre de la grabación, el tiempo de grabación* y el número de pantalla.    #
#El nombre de cada archivo se formará con el nombre de la sesión*, el numero de la pantalla y la hora con preciosion de ms.   #
#Los parámetros con *, son iguales a todas las instancias.	
#Ejecutar el script con un bucle while, hasta que se cancele los procesos con CTRL+C																  #
#-----------------------------------------------------------------------------------------------------------------------------#
clear

#Variables

declare RUTAFFMPEG=$1
declare RUTAVIDEOS=$2
declare RECORDTIME=$3
declare NAME="Audio"
declare CURRENTDIR=`pwd`
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones
gotDirectorio()
{
	if [ ! -d $1 ]; then 
		mkdir $1
	fi
}
#------------------------------------------------------------------------------------------------------------------------_

#Code

folder=$RUTAVIDEOS/$NAME
gotDirectorio $folder
list=$folder/mylist"-"`date +%H:%M`.txt

echo "Comenzando grabación ..."
echo -e "\aPuedes minimizar esta ventana, pues la grabación comenzará en 4 segundos..."
sleep 4
for (( i=0; i<2; i+=1)); do	
	file=$folder/`date +%H:%M:%S:%4N`.mp3
	cd $RUTAFFMPEG && ./ffmpeg -f alsa -i hw:0 -codec:a libmp3lame -qscale:a 4 -t $RECORDTIME $file && printf "file '"$file"'\n" >> $list
done
bash $CURRENTDIR/concat.sh $list $folder.mp3