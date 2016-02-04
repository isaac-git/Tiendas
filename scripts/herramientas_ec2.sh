echo " Instalación pip si no está instalado"
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python27 get-pip.py
echo " Instalación COMMAND LINE INTERFACE DE EC2"
sudo pip install awscli
echo " Instalación de ansible para el despligue remoto en PAAS "
sudo pip install paramiko PyYAML jinja2 httplib2 ansible
echo "Instalación de plugin de vagrant para el despliegue remoto en PAAS"
vagrant plugin install aws
