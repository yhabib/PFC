#!/bin/bash

#***************************************************************************************************************************
#											saveSession.sh								
#***************************************************************************************************************************

#-----------------------------------------------------------------------------------------------------------------------------#
#Script encargado de recopilar toda la información necesaria para la creación de una nueva configuración. Se realiza a través
#de un asistente que pide cada uno de los parámetros a introducir.
#-----------------------------------------------------------------------------------------------------------------------------#

clear

#Variables
declare SESSION
declare RUTAFFMPEG
declare RUTAVIDEOS
declare RES1
declare RES2
declare POS1
declare POS2
declare CRF
declare PRESET
declare FPS
declare RECORDTIME
declare SESSIONTIME
declare CURRENTDIR=`pwd`
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones

#En caso de que exista la carpeta directamente entra en ella, en otro caso la crea y luego entra
gotDirectorio()
{
	if [ ! -d $1 ]; then 
		mkdir $1 
	fi
	cd $1	
}

#Método para la confiramación de que todos los valores son correctos
confirmacion()
{
	tput sgr0
	tput bold
	while true;  do
		echo;read -p "¿Está seguro de los valores introducidos o desea reiniciar el proceso? (s/n) " yn
		case $yn in
			s ) break;;
			n ) cd $CURRENTDIR; bash saveSession.sh;;
		* ) echo "por favor responda sí(s) o no(n)";;
		esac
	done	
}

#Muestra la configuración actual para la sesión de grabación
showConfig()
{
	tput sgr0
	tput setaf 5
	echo "----------------------------------------------------------------------------"
	echo " La configuración escogida es:"
	echo "	Nombre de la sesión:  $SESSION"
	echo "	Ruta a los archivos FFmpeg:  $RUTAFFMPEG"
	echo "	Ruta al directorio de grabación deseado:  $RUTAVIDEOS"
	echo "	Resolución pantalla principal: $RES1"
	echo "	Resolución pantalla secundaria: $RES2"
	echo "	Posición pantalla principal: $POS1"
	echo "	Posición pantalla secundaria: $POS2"
	echo "	Tasa de refresco: $FPS fps"	
	echo "	Valor de CRF: $CRF"
	echo "	Valor de preset: $PRESET"
	echo "	Duracion de la grabacion: $RECORDTIME "
	echo "	Duración de las sesiones de video: $SESSIONTIME minutos"
	echo "	Posiciones de los monitores: Principal: $POS1  Secundaria: $POS2"
	echo "----------------------------------------------------------------------------"
}

#Se encarga de grabar en un archivo .txt las opciones de configuración, cada una en una linea nueva.
grabacion()
{
	echo $RUTAFFMPEG > $SESSION
	echo $RUTAVIDEOS >> $SESSION
	echo $RES1 >> $SESSION
	echo $RES2 >> $SESSION 
	echo $POS1 >> $SESSION
	echo $POS2 >> $SESSION
	echo $FPS >> $SESSION
	echo $CRF >> $SESSION
	echo $PRESET >> $SESSION
	echo $RECORDTIME >> $SESSION
	echo $SESSIONTIME>> $SESSION
}
#-----------------------------------------------------------------------------------

#Code
tput cup 1 1
echo "Asistente para la creación de una sesión de grabación"

tput cup 3 2
tput sgr0
echo "Introduzca los siguientes parámetros:"
tput cup 5 3
read -p "Nombre de la sesión: " SESSION
tput cup 6 3
read -p "Ruta a los archivos FFmpeg: " RUTAFFMPEG
tput cup 7 3
read -p "Ruta al directorio de grabación deseado: " RUTAVIDEOS
tput cup 8 3
echo "Selección de las resoluciones y posiciones de las pantallas: "
gnome-terminal --tab -e "bash resoluciones.sh"
tput cup 9 3
read -p "	-Resolución pantalla principal: " RES1
tput cup 10 3
read -p "	-Resolución pantalla secundaria: " RES2
tput cup 11 3
read -p "	-Posición pantalla principal: " POS1
tput cup 12 3
read -p "	-Posición pantalla secundaria: " POS2
tput cup 13 3
read -p "-Frecuencia de refresco(10fps es lo óptimo): " FPS
tput cup 14 3
read -p "-Indique valor de CRF: " CRF
tput cup 15 3
read -p "-Indique valor de preset: " PRESET
tput cup 16 3
read -p "Duración de la sesión de grabación(hh:mm:ss): " RECORDTIME
tput cup 17 3
read -p "Duración de los videos generados (minutos): " SESSIONTIME
echo

POS1=0
OIFS=$IFS && IFS='x' read -a array <<< "$RES1" && POS2=${array[0]} && IFS=$OIFS
SESSION=$SESSION.txt

showConfig
confirmacion
grabacion


