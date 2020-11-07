#!/bin/bash

init 5

#Servidor
sudo apt-get update #Actualitzem el repositori de Ubuntu
sudo apt-get install apache2 #Instalem el servidor web
sudo systemctl status apache2 #Comprobació de l'estat del servidor web
locate initab
