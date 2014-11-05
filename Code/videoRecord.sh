#!/bin/bash

#******************************************************************************************************************
#											VideoRecord.sh 										
#******************************************************************************************************************

#------------------------------------------------------------------------------------------------------------------
#Script encargado de la grabación del video generado por una pantalla.
#Se le pasan los siguientes parámetros necesarios:
#la ruta a las librerías y dependencias de FFMpeg,
#la ruta a donde se va a almacenar las grabaciones,
#resolución del monitor, CRF, preset, tiempo de grabación,
#posición del monitor (respecto al principal), le numero de pantalla.									  
#-------------------------------------------------------------------------------------------------------------------

clear

#Varibales
declare RUTAFFMPEG=$1
declare RUTAVIDEOS=$2
declare RES=$3
declare FPS=$4
declare CRF=$5
declare PRESET=$6
declare RECORDTIME=$7
declare POS=$8
declare NP=$9
declare NAME="Pantalla"
declare CURRENTDIR=`pwd`
#------------------------------------------------------------------------------------------------------------------------------------

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
folder=$RUTAVIDEOS/$NAME$NP
gotDirectorio $folder
list=$folder/mylist"-"`date +%H:%M`.txt

echo "Comenzando grabación ..."
echo -e "\aPuedes minimizar esta ventana, pues la grabación comenzará en 4 segundos..."
sleep 4

cd $RUTAFFMPEG
for (( i=0; i<10; i+=1)); do	
	file=$folder/`date +%H:%M:%S:%4N`.mp4
	./ffmpeg -t $RECORDTIME -f x11grab -video_size $RES -framerate $FPS -i :0.0+$POS -vcodec libx264 -preset $PRESET -crf $CRF -y $file && printf "file '"$file"'\n" >> $list
done
echo "Se va a proceder a generar el archivo concatenado de las 15 instancias de audio" && sleep 5
bash $CURRENTDIR/concat.sh $list $folder.mp4