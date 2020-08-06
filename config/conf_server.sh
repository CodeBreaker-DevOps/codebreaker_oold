#!/bin/bash

# Copyright (c) 2020 CodeBreaker.com.br
#
# Este script visa instalar os programas nesserários e realizar as configurações mínimas
# para a criação de um WebServer básico na distribuição RedHat CentOS.

clear						# limpar tela

# >> Atualizar repositórios do Linux <<
yum clean all					# Limpar os repositórios
yum makecache fast || yum makecache		# Limpar e compilar repositórios no CentOS 7 ou 8
yum update -y					# Verificar e instalar atualizações sem confirmação

# >> Instalação dos programas necessários
yum install firewalld				# instalar a segurança de rede FIREWALLD
yum install dialog -y				# instalar o gerenciamento de dialogos DIALOG
yum install git -y				# instalar o gerenciamento de repositórios GIT

# >> Instalação do LAMP (Linux, Apache, MySQL, PHP) - WebServer <<
yum install httpd -y				# instalar o Apache HTTPD
yum install mariadb-server -y			# instalar Banco de Dados MARIADB
yum install mariadb -y				# instalar Bando de Dados MARIADB
yum install php -y				# instalar acesso ao PHP
yum install php-mysql -y			# instalar acesso ao PHP com MYSQL
yum install php-mysqlnd -y			# instalar acesso ao PHP com MYSQL

# >> Atualizar repositórios do Linux
yum clean all					# Limpar os repositórios
yum makecache fast || yum makecache		# Limpar e configurar repositórios no CentOS 7 ou 8
yum update -y					# Verificar e instalar atualizações sem confirmação

clear						# limpar tela

# >> configuração do sistema de versionamento Git <<
git config --global user.name "CentOS Server"	# Atribuir nome de utilizador
git config --global user.email noreply		# Atribuir e-mail de utilizador

clear						# limpar os repositórios

# >> Configuração dos serviços <<
systemctl enable firewalld.service		# habilitar serviço ao reiniciar (FIREWALLD)
systemctl enable httpd.service			# habilitar serviço ao reiniciar (HTTPD)
service firewalld.service start			# iniciar serviço (FIREWALLD)
service httpd.service start			# iniciar serviço (HTTPD)

# >> Configuração do FireWall <<
firewall-cmd --permanent --add-port=80/tcp	# adicionar porta 80 no firewall
firewall-cmd --get-active-zones			# verificar zonas ativas no firewall
firewall-cmd --permanent --zone=public --add-port=80/tcp	# adicionar porta publica
firewall-cmd --get-active-zones			# verificar zonas ativas no firewall
firewall-cmd --reload && reboot			# reiniciar firewall e reiniciar
