#!/bin/bash
echo "Iniciando acesso para compactação..."
#LEMBRE DE COLOCAR A SENHA NO SSH E SCP OU UTILIZE O SSH-COPY (https://www.hostinger.com.br/tutoriais/conexao-ssh-sem-senha)
ssh USUARIO@ftp.SEUSITE "tar -zcpf public_html_homolog.tar.gz public_html & "
echo "Compactação OK!"
echo "Iniciando Download..."
scp -o Cipher=arcfour USUARIO@ftp.SEUSITE:public_html_homolog.tar.gz /home/SEU_USER/site/public_html_homolog.tar.gz
echo "Download OK!"
echo "Iniciando extração do arquivo compactado"
tar -xzf /home/SEU_USER/site/public_html_homolog.tar.gz -C /home/SEU_USER/site/Homolog/
echo "Extração OK!"
echo "Iniciando processos do GIT"
cd /home/SEU_USER/site/Homolog/

git init

git config --local user.email "john.doe@dominio.com.br"

git config --local user.name "John Doe"

git config --list

git remote add origin git@gitlab.dominio.com.br:GRUPO/REPOSITORIO.git

git checkout -b homolog

git add .

git commit -m "Automatic Backup Script"

git push -f -u origin homolog
echo "Processo do GIT Finalizado"
echo "Remoção do arquivo baixado"
rm /home/SEU_USER/site/public_html_homolog.tar.gz
rm -rf /home/SEU_USER/site/Homolog/*
echo "FIM"
