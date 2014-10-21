#!/bin/bash

#*****************************************************************************************************************************#
#									VideoRecord: Script para la grabación de video  										  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#Se obtienen los parámetros relevantes para la grabacion de una instancia de video. Estos son: la resolucion de la pantalla,  #
#la posición de esta, los frames por segundo*, el nombre de la grabación, el tiempo de grabación* y el número de pantalla.    #
#El nombre de cada archivo se formará con el nombre de la sesión*, el numero de la pantalla y la hora con preciosion de ms.   #
#Los parámetros con *, son iguales a todas las instancias.	
#Ejecutar el script con un bucle while, hasta que se cancele los procesos con CTRL+C		

#Para la grabcion del segundo, tercer,...monitor. Necesito saber su posicion relativa respecto al principal, y a partir de ahi
# le sumo o le resto a -i :0.0 +X.0, la posicion en X donde quiero que grabe luego esto le suma la resolución.		
#If greater than, me permitirá saber si hay mas de un monitor en ese caso hay que desplazar la grabacion.
#Me crea una carpeta con un contador y hora y minutos, guarda la instancia de grabacion y vuelve a la carpeta record.											  
#-----------------------------------------------------------------------------------------------------------------------------#
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