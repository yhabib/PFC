#!/bin/bash

#*****************************************************************************************************************************
#														record.SH										  #
#*****************************************************************************************************************************

#-----------------------------------------------------------------------------------------------------------------------------
#Script encargado de lanzar cada una de las isntancias de grabación, para ello a través de un diálogo con el usuario le
#pide que seleccione una configuración de grabación.										    
#Se creará una carpeta para la sesion total, luego otra para cada dia de grabación y un más pequeña en función del tamaño	  
#final de los archivos																										  
#-----------------------------------------------------------------------------------------------------------------------------

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
declare SESSIONTIME 
declare POS1
declare POS2
declare waitingTime
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones

#Lanza las 3 instancias necesarias de FFmpeg
lanzarFFmpeg()
{
	gnome-terminal --tab -e "bash videoRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RES1 $FPS $CRF $PRESET $RECORDTIME $POS1 1" && gnome-terminal --tab -e "bash videoRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RES2  $FPS $CRF $PRESET $RECORDTIME $POS2 2"
	gnome-terminal --tab -e "bash audioRecord.sh $RUTAFFMPEG $RUTAVIDEOS/$dateDMY/$dateHM $RECORDTIME"
}

#Carga los parámetros de configuración de una sesión almacenados en un .txt
#Lee este recursivamente y otorga su valor a la variable 
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
    SESSIONTIME=${array[10]}
    cd ..
}

#Muestra la configuración actual para la sesión de grabación
showConfig()
{
	echo
	tput sgr0
	tput setaf 5
	echo "----------------------------------------------------------------------------"
	echo " La configuración escogida es:"
	echo "	Ruta a los archivos FFmpeg: $RUTAFFMPEG"
	echo "	Ruta al directorio de grabación deseado: $RUTAVIDEOS"
	echo "	Resolución pantalla principal: $RES1"
	echo "  	Resolución pantalla secundaria: $RES2"
	echo "	Tasa de refresco: $FPS fps"
	echo "	Seleccion el valor CRF: $CRF "
	echo "	Seleccion el preset: $PRESET"
	echo "	Duracion de las grabaciones: $RECORDTIME "
	echo "	Duración de las sesiones de video: $SESSIONTIME minutos"
	echo "	Posiciones de los monitores: Principal: $POS1  Secundaria: $POS2"
	echo "----------------------------------------------------------------------------"
}

#Método para la confiramación de que todos los valores son correctos
confirmacion()
{
	tput sgr0
	tput bold
	while true;  do
		echo;read -p "Está seguro de los valores introducidos o desea reiniciar el proceso? (s/n)" yn																																																															
		case $yn in
			s ) break;;
			n ) bash record.sh;;
		* ) echo "por favor responda sí(s) o no(n)";;
		esac
	done	
}

#En caso de que exista la carpeta directamente entra en ella, en otro caso la crea y luego entra
gotDirectorio()
{
	if [ ! -d $1 ]; then 
		mkdir $1
	fi
}
#------------------------------------------------------------------------------------------------------------------------

#Code	
tput sgr0
tput cup 1 1																																																																												
echo "Script basado en FFMPEG para la grabación de video y audio"

tput cup 2 2
echo "A continuación se muestran las configuracióne disponibles:" && cd Configuraciones
tput cup 3 4
ls
tput cup 5 1
read -p "¿Qué configuración desea utilizar? " FILE

loadFile $FILE
showConfig																																																																																																																																																															
confirmacion
gotDirectorio $RUTAVIDEOS
waitingTime=600
contador=$((SESSIONTIME/10))

while [ $contador>0 ]; do
	dateDMY=$(date +%d%b%Y)
	dateHM=`date +%H:%M`
	gotDirectorio $RUTAVIDEOS/$dateDMY
	gotDirectorio $RUTAVIDEOS/$dateDMY/$dateHM
	lanzarFFmpeg && contador=$((contador-1))
	echo "Press 'Ctrl+C' to exit from the record, next record will start in $waitingTime" && sleep $waitingTime
	
done