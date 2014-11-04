#!/bin/bash

#**********************************************************************************************************
#                       userGuide.sh                         #
#**********************************************************************************************************

#----------------------------------------------------------------------------------------------------------
#Información de uso
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
  echo "G U I A   D E   U S O"
  tput sgr0
   
  tput cup 7 7
  echo "Este manual tiene como intención el de ofrecer algunas pautas de uso para el prototipo desarrollado."
   
  tput cup 8 7
  echo "A través de las diferentes entradas del menu principal se puede acceder a las diferentes funcionalidades del programa."


  tput cup 10 7
  echo "La primera entrada  del menú podemos realizar las siguientes tareas:"

  tput cup 11 9
  echo "1. Se lanza el asistente para la creación de una nueva configuración de grabación. Entre los parámetros a introducir,"
  tput cup 12 10
  echo "destacar los relativos a las posiciones de los monitores, recordar el principal viene asociado con el valor 0, mientras"
  tput cup 13 10
  echo "que el secundario tomará el valor de la resolución horizonta del primario, si está conectado a la derecha de este, si"
  tput cup 14 10
  echo "si estuviese a la izquierda sería el mismo valor pero negativo. Por otro lado, los valores de codificación se recomienda"  
  tput cup 15 10
  echo "emplear 18 para el CRF y ultrafast para el preset. Más posibilidades se encuentran en el documento 4 Manual de Usario " 

  tput cup 16 9
  echo "2. Se lanza el reproductor en el cual solo habrá que seleccionar la configuración que deseemos emplear en la grabación"
  tput cup 17 10
  echo "de la sesión que vamos a iniciar. El proceso se realiza las veces necesarias para poder grabar el tiempo establecido en"
  tput cup 18 10
  echo "el archivo. Si se desea detenerlo, solo hace falta pulsar Cntrl+C en la ventana del menu."
 

  tput cup 20 7
  echo "La segunda entrada es la encargada de lanzar el script que generará los archivos finales codificacos, concatenados y"
  tput cup 21 7
  echo "superpuestos. A traves de un diálogo con el usuario se accede a la sesión con la que se va a trabajar."


  tput cup 22 7
  echo "La tercera entrada permite reproducir una sesión grabada mediante dos instancias, por lo que se pueden ver y escuchar"
  tput cup 23 7
  echo "todos los flujos audiovisuales grabados."  
  

  tput cup 25 7
  echo "La cuarta entrada permite la descarga e instalación de todo el software necesario, puede encontrar más información de"
  tput cup 26 7
  echo "esta entrada seleccionando la opción 4 del menu."


  tput cup 28 7
  echo "Por último las dos últimas entradas permiten mostrar esta información, al igual que la relacionada con la instalación"
  tput cup 29 7
  echo "del software o las licencias. También la opción para abandonar el presente programa."



 # Seleccionamos modo "negrita"
  tput bold
  tput cup 32 15
  read -p "Presion 'q' para salir o 'x' para mostrar el manual de instalación: " opcion

case $opcion in
  x) bash installationGuide.sh;;
  q) exit 1;;
  
*)   
  tput clear
  tput sgr0
esac
done