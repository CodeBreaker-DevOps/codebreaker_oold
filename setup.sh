#!/bin/bash

# Copyright (c) 2020 CodeBreaker.com.br
#
# Este script visa instalar e configurar o projeto CodeBreaker, servindo como um Gerenciador
# de Módulos, capaz de instalar facilmente módulos (projetos web em PHP) em um servidor Linux
# baseado na distribuição RedHat CentOS.

# Preparando ambiente de configuração

clear				# limpar tela

yum clean all
yum makecache fast
yum makecache
yum update -y

yum install firewalld		# instalar a segurança de rede FIREWALLD
yum install dialog -y		# instalar o gerenciamento de caixas de dialogo DIALOG
yum install git -y		# instalar o gerenciamento de repositórios GIT

# Instalação do LAMP (Linux, Apache, MySQL, PHP)
yum install httpd -y		# instalar o Apache HTTPD
yum install mariadb-server -y	# instalar Banco de Dados MARIADB
yum install mariadb -y		# instalar Bando de Dados MARIADB
yum install php -y		# instalar acesso ao PHP
yum install php-mysql -y	# instalar acesso ao PHP com MYSQL
yum install php-mysqlnd -y	# instalar acesso ao PHP com MYSQL

yum clean all
yum makecache fast
yum makecache
yum update

clear

# configurar o Git
git config --global user.name "CentOS Server"
git config --global user.email noreply

clear
systemctl enable firewalld.service
systemctl enable httpd.service
service firewalld.service start
service httpd.service start


firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --get-active-zones
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --get-active-zones
firewall-cmd --reload
