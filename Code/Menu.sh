#!/bin/bash

#*****************************************************************************************************************************#
#									Menu: Script para las diferentes opciones  												  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#Uso de TPUT para la interfaz. 
#Podria utilizar "killall" con quit para matar todos los procesos salida brusca del sistema, sería sobre ffmpeg. Sacando PID  #																					  #
#-----------------------------------------------------------------------------------------------------------------------------#


while true; do
	# clear the screen
	tput clear
	 
	# Move cursor to screen location X,Y (top left is 0,0)
	tput cup 3 15
	 
	# Set a foreground colour using ANSI escape
	tput setaf 3
	echo "Indra SoftLabs"
	tput sgr0
	 
	tput cup 5 17
	# Set reverse video mode
	tput rev
	echo "M E N U -  P R I N C I P A L"
	tput sgr0
	 
	tput cup 7 15
	echo "1. Grabación de la estación"
	 
	tput cup 8 15
	echo "2. Generación de arhivos reproducibles"

	tput cup 9 15
	echo "3. Reproducción de la estación"
	 
	tput cup 10 15
	echo "4. Información"
	 
	tput cup 11 15
	echo "5. Salir"
	 
	# Set bold mode 
	tput bold
	tput cup 13 15
	read -p "Enter your choice [1-4] " opcion

case $opcion in
	1) bash Menu2.sh;;
	2) bash generacionArchivos.sh;;
	3) vlc;;
	4) uname -r;;
	5) echo "Adiós";
	   exit 1;;
*)	 
	tput clear
	tput sgr0
esac
done