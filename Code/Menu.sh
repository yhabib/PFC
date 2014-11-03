#!/bin/bash

#**********************************************************************************************************
#												Menu.sh 												  #
#**********************************************************************************************************

#----------------------------------------------------------------------------------------------------------
#Script maestro para el manejo del sotware. Este es lanzado a partir del comando "bash Menu.sh"
#----------------------------------------------------------------------------------------------------------

#Code
while true; do
	# Limpieamos las X
	tput clear
	 
	# Movemos el cursor a la localización X,Y (la esquina izquierda es 0,0)
	tput cup 3 15
	 
	# Configuramos el color del fondo a traves del condigo de escape ANSI
	tput setaf 3
	echo "Indra SoftLabs"
	tput sgr0
	 
	tput cup 5 17
	# Seleccionamos el modo de video "revertido"
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
	echo "4. Instalación software"
	 
	tput cup 11 15
	echo "5. Información"
	 
	tput cup 12 15
	echo "6. Salir"
	 
	# Seleccionamos modo "negrita"
	tput bold
	tput cup 14 15
	read -p "Enter your choice [1-6] " opcion

case $opcion in
	1) bash Menu2.sh;;
	2) bash generacionArchivos.sh;;
	3) bash reproduccion.sh;;
	4) bash Menu4.sh;;
	5) bash menu3.sh;;
	6) echo "Adiós";
	   exit 1;;
*)	 
	tput clear
	tput sgr0
esac
done