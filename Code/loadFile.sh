#!/bin/bash


#Variables

declare FILE
declare RES1
declare RES2
declare FPS
declare RECORDTIME
declare POS1
declare POS2
#---------------------------------------------------------------------------------------------

while read line; do 
    RES1=$line
    RES2=$line
    FPS=$line
    RECORDTIME=$line
    POS1=$line
    POS2=$line
done < $FILE

declare RES1=1280x1024
declare RES2=1366x768
declare FPS=10
declare RECORDTIME=00:01:00
declare POS1=0
declare POS2=1280