#!/bin/bash

#*****************************************************************************************************************************#
#									Record: Script para la configuración de la sesión 										  #	
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
declare RES1=1280x1024
declare RES2=1366x768
declare FPS=10
declare RECORDTIME=00:01:00
declare POS1=0
declare POS2=1280
declare path=~/Proyecto/Records/Sesion1
#------------------------------------------------------------------------------------------------------------------------------------

#Funciones

lanzarFFplay()
{
	cd ~/bin && gnome-terminal --tab -e "./ffplay $1" 
}
#-----------------------------------------------------------------------------------

echo "Script basado en FFMreproduccion"
cd ~/Proyecto/Records
echo "Sesiones disponibles" && ls
read -p "Sesion?" sesion
cd $sesion

for f in * ; do lanzarFFplay $path/"$f" ; done

