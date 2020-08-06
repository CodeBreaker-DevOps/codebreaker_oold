#!/bin/bash

# Copyright (c)  2020 CodeBreaker.com.br
#
# Este Script visa configurar o Virtual Host no Apache utilizando a distribuição
# Linux RedHat CentOs.

# >> Fechar serviço do HTTPD <<
systemctl stop httpd.service

# >> Variáveis <<
DOMINIO=codebreaker.com.br
APACHE_HOME=/var/www
CODEBREAKER_PUBLIC=$APACHE_HOME/codebreaker/public_html


# >> Criação e configuração das pastas <<
mkdir -p $CODEBREAKER_PUBLIC
chown -R apache:apache $CODEBREAKER_PUBLIC
chmod -R 755 $APACHE_HOME
rm -Rf /etc/httpd/sites-available
rm -Rf /etc/httpd/sites-enabled
mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled

# >> Configuração do httpd.conf
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

# >> gerando o arquivo de configuração do Virtual Host <<

echo "<VirtualHost *:80>
	ServerName www.$DOMINIO
	ServerAlias $DOMINIO
	DocumentRoot $CODEBREAKER_PUBLIC
</VirtualHost>" > /etc/httpd/sites-available/$DOMINIO

# >> Criação do link simbolico <<
ln -s /etc/httpd/sites-avaliable/$DOMINIO /etc/httpd/sites-enabled/$DOMINIO

# >> Reiniciando servidor apache <<
systemctl start httpd.service
systemctl reload httpd.service

