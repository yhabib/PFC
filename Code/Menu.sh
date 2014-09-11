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
	echo "2. Reproducción de la estación"
	 
	tput cup 9 15
	echo "3. Información"
	 
	tput cup 10 15
	echo "4. Salir"
	 
	# Set bold mode 
	tput bold
	tput cup 12 15
	read -p "Enter your choice [1-4] " opcion

case $opcion in
	1) bash Menu2.sh;;
	2) df;;
	3) uname -r;;
	4) echo "Adiós";
	   exit 1;;
*)	 
	tput clear
	tput sgr0
esac
done