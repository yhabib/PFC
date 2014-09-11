#!/bin/bash

#*****************************************************************************************************************************#
#								Resoluciones: Mostrar resoluciones de las pantallas conectadas 								  #	
#*****************************************************************************************************************************#

#-----------------------------------------------------------------------------------------------------------------------------#
#Uso de TPUT para la interfaz. 
#Podria utilizar "killall" con quit para matar todos los procesos salida brusca del sistema, sería sobre ffmpeg. Sacando PID  #																					  #
#-----------------------------------------------------------------------------------------------------------------------------#


echo "  ----------------------------------------------------------------------------------------------------------------------"
echo "A continuación se mostrarán las resoluciones de las pantallas conectadas(la que lleva asterisco funciona actualmente):"
xrandr

echo "  -----------------------------------------------------------------------------------------------------------------------"
read -p "Presione una tecla para salir.... " enter


