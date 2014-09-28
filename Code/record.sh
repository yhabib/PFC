#!/bin/bash

#*****************************************************************************************************************************#
#									Record: Script para la configuración de la sesión 										  #	
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
declare -a array
declare RUTAFFMPEG
declare RUTAVIDEOS
declare RES1
declare RES2
declare FPS
declare CRF
declare PRESET
declare RECORDTIME
declare PLAYTIME 
declare POS1
declare POS2
declare waitingTime
#declare CURRENTDIR=`pwd`
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones
lanzarFFmpeg()
{
	gnome-terminal --tab -e "bash videoRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RES1 $FPS $CRF $PRESET $RECORDTIME $POS1 1" && gnome-terminal --tab -e "bash videoRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RES2  $FPS $CRF $PRESET $RECORDTIME $POS2 2"
	gnome-terminal --tab -e "bash audioRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RECORDTIME"
}

loadFile()
{
	i=0
	while read line; do
		array[i]=$line
		let "i+=1"
	done < $FILE
	RUTAFFMPEG=${array[0]} && RUTAVIDEOS=${array[1]}
	RES1=${array[2]} && RES2=${array[3]}
    POS1=${array[4]} && POS2=${array[5]}
    FPS=${array[6]} &&  CRF=${array[7]}
    PRESET=${array[8]} && RECORDTIME=${array[9]}
    PLAYTIME=${array[10]}
    cd ..
}

showConfig()
{
	echo "----------------------------------------------------------------------------"
	echo "La configuración escogida es:"
	echo "Ruta a los archivos FFmpeg: $RUTAFFMPEG"
	echo "Ruta al directorio de grabación deseado: $RUTAVIDEOS"
	echo "	Resolución pantalla principal: $RES1"
	echo "  	Resolución pantalla secundaria: $RES2"
	echo "	Tasa de refresco: $FPS fps"
	echo "	Seleccion el valor CRF: $CRF "
	echo "	Seleccion el preset: $PRESET"
	echo "	Duracion de las grabaciones: $RECORDTIME "
	echo "	Duración de las sesiones de video: $PLAYTIME minutos"
	echo "	Posiciones de los monitores: Principal: $POS1  Secundaria: $POS2"
	echo "----------------------------------------------------------------------------"

}

confirmacion()
{
	while true;  do
		echo;read -p "Está seguro de los valores introducidos o desea reiniciar el proceso? (s/n)" yn																																																															
		case $yn in
			s ) break;;
			n ) bash record.sh;;
		* ) echo "por favor responda sí(s) o no(n)";;
		esac
	done	
}

gotDirectorio()
{
	if [ ! -d $1 ]; then 
		mkdir $1
	fi
}
#------------------------------------------------------------------------------------------------------------------------_

#Code																																																																													
echo "Script basado en FFMPEG para la grabación de video y audio."
echo "Asistente par la creación de una sesión de grabación"
echo "Configuraciones disponibles" && cd Configuraciones && ls
read -p "Que configuración quiere utilizar??" FILE

loadFile $FILE
showConfig																																																																																																																																																															
confirmacion
gotDirectorio $RUTAVIDEOS
waitingTime=600
contador=$((PLAYTIME/10))

while [ $contador>0 ]; do
	dateDMY=$(date +%d%b%Y)
	dateHM=`date +%H:%M`
	gotDirectorio $RUTAVIDEOS/$dateDMY
	gotDirectorio $RUTAVIDEOS/$dateDMY/$dateHM
	lanzarFFmpeg && contador=$((contador-1))
	echo "Press 'Ctrl+C' to exit from the record, next record will start in $waitingTime" && sleep $waitingTime
	
done