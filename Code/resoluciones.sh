#!/bin/bash

#***************************************************************************************************************************
#										resoluciones.sh								  
#***************************************************************************************************************************

#---------------------------------------------------------------------------------------------------------------------------
#Script que muestra las resoluciones soportadas por todos los monitores conectados. También
#informa de la resoolución recomendada mediante un asterisco
#---------------------------------------------------------------------------------------------------------------------------


echo "  ---------------------------------------------------------------------------------------------------------------------"
echo "A continuación se mostrarán las resoluciones de las pantallas conectadas(la que lleva asterisco funciona actualmente):"

xrandr

echo "  ----------------------------------------------------------------------------------------------------------------------"
read -p "Presione una tecla para salir.... " enter


