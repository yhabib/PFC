#!/bin/bash

#**********************************************************************************************************
#                       installationGuide.sh                         
#**********************************************************************************************************

#----------------------------------------------------------------------------------------------------------
#Información para la instalación
#----------------------------------------------------------------------------------------------------------

#Code

tput clear
   
# Movemos el cursor a la localización X,Y (la esquina izquierda es 0,0)
tput cup 3 55
   
# Configuramos el color del fondo a traves del condigo de escape ANSI
tput setaf 3
echo "Indra SoftLabs"
tput sgr0
   
  tput cup 5 45
  # Seleccionamos el modo de video "revertido"
  tput rev
  echo "G U I A   D E   I N S T A L A C I Ó N"
  tput sgr0
   
  tput cup 7 7
  echo "Este manual tiene como intención el de ofrecer algunas pautas para la instalación del software necesario."
   
  tput cup 10 7
  echo "A partir de tres entradas del submenu, se pueden realizar las siguientes acciones:"

  tput cup 11 8
  echo "1.Nos permite descargar todo el software necesario en el directorio que se le indique a través de un diálogo con"
  tput cup 12 9
  echo "el script."

  tput cup 14 8
  echo "2.Esta segunda entrada permite instalar el software necesario descargado previamente en otro equipo con conexión a"
  tput cup 15 9
  echo "internet. Para ello le especificacmos el directorio en el que están los paquetes descargados y el directorio sobre el"
  tput cup 16 9
  echo "quequeremos realizar la instalación, y este procederá con todos los pasos: configuración, compilación e instalación."
 

  tput cup 19 7
  echo "Por último esta estrad9a permite realizar todo el proceso, desde la descarga hasta la instalación automaticamente."
  tput cup 20 7
  echo "Es la indicada cuando tenemos un equipo con acceso a internet."


 # Seleccionamos modo "negrita"
  tput bold
  tput cup 23 15
  read -p "Presion 'q' para salir o 'x' para mostrar el manual de uso: " opcion

case $opcion in
  x) installationGuide.sh;;
  q) exit 1;;
  
*)   
  tput clear
  tput sgr0
esac
done