#!/bin/bash

#**********************************************************************************************************
#                           credits.sh                         
#**********************************************************************************************************

#----------------------------------------------------------------------------------------------------------
#Créditos y licencias de uso
#----------------------------------------------------------------------------------------------------------

#Code

tput clear
   
# Movemos el cursor a la localización X,Y (la esquina izquierda es 0,0)
tput cup 3 55
   
# Configuramos el color del fondo a traves del condigo de escape ANSI
tput setaf 3
echo "Indra SoftLabs"
tput sgr0
   
  tput cup 5 50
  # Seleccionamos el modo de video "revertido"
  tput rev
  echo "L I C E N C I A S  D E  U S O"
  tput sgr0
   
  tput cup 7 7
  echo "Este proyecto fue desarrollado por Yúsef Habib Fernández para la empresa Indra Software Labs,"
  tput cup 8 7
  echo "como Proyecto Final de Carrera para la obtenición del título de Ingeniero Supeior de Telecomunicación"
  tput cup 9 7
  echo "el cual fue ofertado a través de la Cátedra Indra de la Universidad de Ovideo."
 

  tput cup 11 7
  echo "Todos los programas que son necesarios han sido liberados bajo licencia GNU GPL por lo que se garantiza la libertad"
  tput cup 12 7
  echo "para compartir y modificar el software cubierto por ella, asegurando la liberta de este software para todos los usuarios"
  tput cup 13 7
  echo "ya sean inviduos o empresas."


 # Seleccionamos modo "negrita"
  tput bold
  tput cup 16 15
  read -p "Presion 'q' para salir o 'x' para mostrar instalacion: " opcion

case $opcion in
  q) exit 1;;
  
*)   
  tput clear
  tput sgr0
esac
done