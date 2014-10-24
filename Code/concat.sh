#!/bin/bash

#*****************************************************************************************************************************
#											concat.sh									  
#*****************************************************************************************************************************

#-----------------------------------------------------------------------------------------------------------------------------
#Este script se encarga de concatenar todos los archivos que vienen reflejados en el "directorio". 
#Este es un .txt, en el que previamente se han grabado todos los archivos generados. Por lo que el script
#accede a este documento y va concatenando todas las entradas que va encontrando.
#-----------------------------------------------------------------------------------------------------------------------------

clear

#Variables
declare directorio=$1
declare folder=$2
#-----------------------------------------------------------------------------------------------------------------------------

#Code
cd directorio
ffmpeg -f concat -i $directorio -c copy $folder
