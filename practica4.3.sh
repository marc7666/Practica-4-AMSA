#!/bin/bash

init 5

#Servidor
sudo su - #Validació de root per evitar introduir tot el rato la constrassenya
apt-get update #Actualitzem el repositori de Ubuntu
apt-get install apache2 #Instalem el servidor web
sudo systemctl status apache2 #Comprobació de l'estat del servidor web
locate initab
