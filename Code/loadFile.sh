#!/bin/bash

#*********************************************************************************************************************
# 												loadFile.sh		PRUEBA		 	
#*********************************************************************************************************************

#---------------------------------------------------------------------------------------------------------------------
#Script encargado de cargar los parámetros de configuración de una sesión almacenados en un .txt
#Lee este recursivamente y otorga su valor a la variable 
#---------------------------------------------------------------------------------------------------------------------

#Variables
declare FILE
declare RES1
declare RES2
declare CRF
declare PRESET
declare FPS
declare RECORDTIME
declare POS1
declare POS2
#---------------------------------------------------------------------------------------------

#Code
while read line; do 
    RES1=$line
    RES2=$line
    POS1=$line
    POS2=$line
    CRF=$line
    PRESET=$line
    FPS=$line
    RECORDTIME=$line
    POS1=$line
    POS2=$line
done < $FILE

#declare RES1=1280x1024
#declare RES2=1366x768
#declare FPS=10
#declare RECORDTIME=00:01:00
#declare POS1=0
#declare POS2=1280