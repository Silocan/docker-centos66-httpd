#!/bin/bash

echo "=> Variables d'environnement"
echo "APP_ENV : ${APP_ENV}"
echo "PORT : ${PORT}"
echo "VHOST : ${VHOST}"
echo "WWW : ${WWW}"
echo ""

echo "=> Initialisation du vhost"
mkdir /etc/httpd/conf.d/vhosts
sed -i.bak s/'${APP_ENV}'/"${APP_ENV}"/g /tmp/template.conf
sed -i.bak s/'${PORT}'/"${PORT}"/g /tmp/template.conf
sed -i.bak s/'${VHOST}'/"${VHOST}"/g /tmp/template.conf
sed -i.bak s+'${WWW}'+${WWW}+g /tmp/template.conf
echo ""

echo "=> Lecture du fichier de conf:"
cat /tmp/template.conf
echo ""

cp /tmp/template.conf /etc/httpd/conf.d/${VHOST}.conf

echo "=> Démarrage du serveur web"
#httpd -D FOREGROUND
service httpd start
tail -f /var/log/httpd/${VHOST}_error.log
