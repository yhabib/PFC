#!/bin/bash

#*****************************************************************************************************************
#										AudioRecord.ah								 
#******************************************************************************************************************

#------------------------------------------------------------------------------------------------------------------
#Script encargado de la grabación del audio generado por el micro.
#Se le pasan los parámetros necesarios:
#la ruta a las librerías y dependencias de FFMpeg,
#la ruta a donde se va a almacenar las grabaciones, y la duración de estas.
#-----------------------------------------------------------------------------------------------------------------

clear

#Variables
declare RUTAFFMPEG=$1
declare RUTAVIDEOS=$2
declare RECORDTIME=$3
declare NAME="Audio"
declare CURRENTDIR=`pwd`
#-----------------------------------------------------------------------------------------------------------------------------

#Funciones

#En caso de que exista la carpeta directamente entra en ella, en otro caso la crea y luego entra
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

cd $RUTAFFMPEG 
for (( i=0; i<10; i+=1)); do	
	file=$folder/`date +%H:%M:%S:%4N`.mp3
	./ffmpeg -f alsa -i hw:0 -codec:a libmp3lame -qscale:a 4 -t $RECORDTIME $file && printf "file '"$file"'\n" >> $list
done
echo "Se va a proceder a generar el archivo concatenado de las 15 instancias de audio" && sleep 5
bash $CURRENTDIR/concat.sh $list $folder.mp3
