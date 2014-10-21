R#!/bin/bash

#*****************************************************************************************************************************#
#									saveSession: Script para la configuración de la sesión 										  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#La interfaz recopila la informaciń necesaria para la sesión de grabación, esto es: el nº de pantallas, la inclusión o no del #
#audio, el tiempo de grabación,...										    #
#Se creará una carpeta para la sesion total, luego otra para cada dia de grabación y un más puqueña en función del tamaño	  #
#final de los archivos																										  #
#El bucle para obtener los datos de los monitores, en caso de que se seleccione mas de uno , ga ha de identicar la posición   #
#relativa del monitor respecto al original, derecha o izquierda. Este array solo me interesan las posiciones 1,2 en caso de q #
#3 monitores. Valores posibles i,d--> ÑLuego opero. Trabajar con strings  para la posion del monitor hacer una funcion.#
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
declare FPS
declare RECORDTIME
declare PLAYTIME
declare CURRENTDIR=`pwd`
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones
gotDirectorio()
{
	if [ ! -d $1 ]; then 
		mkdir $1 
	fi
	cd $1	
}

confirmacion()
{
	while true;  do
		echo;read -p "¿Está seguro de los valores introducidos o desea reiniciar el proceso? (s/n) " yn
		case $yn in
			s ) break;;
			n ) cd $CURRENTDIR; bash saveSession.sh;;
		* ) echo "por favor responda sí(s) o no(n)";;
		esac
	done	
}
#Método para poder grabar la sesion en unarchivo de configuracion para posteriores usos.
#grabarConf()

showConfig()
{
	echo "----------------------------------------------------------------------------"
	echo "La configuración escogida es:"
	echo "Nombre de la sesión:  $SESSION"
	echo "Ruta a los archivos FFmpeg:  $RUTAFFMPEG"
	echo "Ruta al directorio de grabación deseado:  $RUTAVIDEOS"
	echo "	Resolución pantalla principal: $RES1"
	echo "  	Resolución pantalla secundaria: $RES2"
	echo "	Tasa de refresco: $FPS fps"
	echo "	Duracion de la grabacion: $RECORDTIME "
	echo "	Duración de las sesiones de video: $PLAYTIME minutos"
	echo "	Posiciones de los monitores: Principal: $POS1  Secundaria: $POS2"
	echo "----------------------------------------------------------------------------"
}

grabacion()
{
	echo $RUTAFFMPEG > $SESSION
	echo $RUTAVIDEOS >> $SESSION
	echo $RES1 >> $SESSION
	echo $RES2 >> $SESSION 
	echo $POS1 >> $SESSION
	echo $POS2 >> $SESSION
	echo $FPS >> $SESSION
	echo $RECORDTIME >> $SESSION
	echo $PLAYTIME>> $SESSION
}
#-----------------------------------------------------------------------------------

echo "Script basado en FFMPEG para la configuración de una nueva sesión de video."
echo "Asistente par la creación de una sesión de grabación"
echo
echo "Configuración de la sesión de grabación: "
read -p "Nombre de la sesión: " SESSION
echo "Directorio actual -> " `pwd`
read -p "Ruta a los archivos FFmpeg: " RUTAFFMPEG
read -p "Ruta al directorio de grabación deseado: " RUTAVIDEOS
echo "	-Selección de la(s) resolucion(es) de las pantallas "
gnome-terminal --tab -e "bash resoluciones.sh"
read -p "Resolución pantalla principal: " RES1
read -p "Resolución pantalla secundaria: " RES2
read -p "	-¿Frecuencia de refresco?(10fps es lo óptimo): " FPS
read -p "	-Duración de la sesión de grabación(hh:mm:ss): " RECORDTIME
read -p "	-Duración de los videos generados (minutos): " PLAYTIME

POS1=0
OIFS=$IFS && IFS='x' read -a array <<< "$RES1" && POS2=${array[0]} && IFS=$OIFS
SESSION=$SESSION.txt

showConfig
confirmacion
grabacion


