Para desplegar la aplicación haciendo uso de **Vagrantfile** y  **Ansible** se tiene que realizar los siguientes pasos:

- Instalar el cliente de **Command Line Interface** de Amazon, el cual me permitirá realizar tareas de gestión de mi perfil de usuario. Se puede consultar la documentación oficial, concretamente en el [apartado](http://docs.aws.amazon.com/es_es/cli/latest/userguide/installing.html).

- Una vez instalado en nuestro ordenador, procederemos a configurarlo, para ello debemos poner en la terminal:

```
aws configure

```

Este comando nos pedirá que rellenemos una serie de primitivas, la cual permitirán a **Command Line Interface** conectarse a nuestro perfil de Amazon. No se muestra pantallazo, debido a razones de seguridad.


De la siguiente imagen, pasamos a mostrar como rellenar los campos que nos piden el anterior comando:

- Nos dirigimos a nuestro perfil de Amazon( lo que viene siendo loguearse como en cualquier plataforma). Una vez dentro seleccionamos a nuestro nombre de perfil y le damos al apartado **Security Credentials**.

![img15](https://www.dropbox.com/s/gygkl6oneu1hwrg/img15.png?dl=1)

- Una vez dentro, nos vamos al apartado **Users**:

![img16](https://www.dropbox.com/s/8y7vo3cddw4iluw/img16.png?dl=1)

- Le damos a la pestaña **Create New User**:

![img17](https://www.dropbox.com/s/jc09db3cn307ggn/img17.png?dl=1)

- Una vez dada nos pedirá que rellenemos una seria de campos:

![img18](https://www.dropbox.com/s/tao3m85ray0x8as/img18.png?dl=1)

- Cuando pinchamos en crear, se nos permitirá descargar un archivo **.csv**, deberemos guardarlo ya que contiene los campos necesarios para **aws configure**, ahora lo veremos.

- Si todos los pasos anteriores se ha realizado correctamente debe salirnos ya el usuario, en mi caso yo he creado un usuario denominado **lorenmanu**:

![img19](https://www.dropbox.com/s/r4mjdiqro8jxx7g/img19.png?dl=1)

- Tenemos que darle los permisos necesarios al usuario para que pueda trabajar con nuestro perfil, esto lo haremos en el apartado **Permissions**. Dentro de este apartado se deberá dar a **Attach Policy** para darle permisos. Se nos ofrece una gran variedad de permisos que le podemos dar al usuario, en mi caso he optado por **AmazonEC2FullAccess**, ya que es que me permite trabajar en versión gratuita:

![img20](https://www.dropbox.com/s/bgyoifrn3skbli7/img20.png?dl=1)


- Recuperamos el archivos **.csv**, lo abrimos, y de ahí cogeremos los campos:

```
access_key_id

secret_access_key

```

- Ya podemos volver a usar **aws configure**, y rellenar los campos necesarios. Los dos campos del paso anterior son los importantes, en los otros dos que se nos pedirán rellenar:

- **region**: aquí ponemos la región en la cúal estará nuestra instancia, en mi caso **us-west-2**.
- **text_format**: aquí le di a **enter**, no es relevante de momento.

- Una vez especificado **Command Line Interface**, configuramos la conexión ssh con nuestra instacia, la cual crearemos en el Vagrantfile, para ello deberemos crear un archivo **.pem**. La documentación oficial de Amazon nos explica como realizarlo, concretamente [aquí](http://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-using-param.html). En mi caso me ha valido con seguir la siguiente sintaxis:

```
aws ec2 create-key-pair --key-name my-key-pair

```

![img9](https://www.dropbox.com/s/43ebfj2a5385b7e/img9.png?dl=1)

- Creamos un **Security Groups**, el cual usuará para atender peticiones. El apartado de la documentación oficial de Amazon de como crearlo se puede ver [aquí](http://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-ec2-sg.html). También hay que añadirle una serie de reglas para indicarle los puertos por los cuales va a atender(esta en el mismo apartado de la documentación oficial), en concreto yo he realizado los siguiente:


![img8](https://www.dropbox.com/s/1haw0v9opo6wfmx/img8.png?dl=1)



- Una vez realizado esto, modificamos nuestro **Vangranfile**, tiendo en cuenta:

 - Los datos del archivo **.csv** anterior.:

```
aws.access_key_id

aws.secret_access_key

```

 - Localización de nuestro sistema operativo:

```
aws.ami

```

 - Regíon de nuestra instancia:

```
aws.region



```

 - El nombre de nuestro archivo **.pem**:

```

keypair_name

```

 - El **security_groups** que se encargará de atender nuestras peticiones:

```
security_groups

```

 - El tipo de nuestra instancia, ** importante mirar las que son gratis o no**.

```
instance_type

```
 - El nombre del usuario de nuestra máquina:

```
override.ssh.username

```

**Nota**: Usuario por el cual se conectará por ssh, por defecto es **ubuntu** en EC2.


 - Por lo que podemos ver nuestro VangrantFile tendrá la siguiente estructura:


```
#-*- mode: ruby -*-
#vi: set ft=ruby :

Vagrant.require_plugin 'vagrant-aws'
Vagrant.require_plugin 'vagrant-omnibus'


Vagrant.configure('2') do |config|
    config.vm.box = "dummy"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    config.vm.hostname = "Tiendas"

    config.vm.provider :aws do |aws, override|
        aws.access_key_id = ENV['ACCESS_KEY_ID']
        aws.secret_access_key = ENV['SECRET_ACCESS_KEY']
        override.ssh.private_key_path = ENV['PRIVATE_KEY_PATH']
        aws.keypair_name = "credenciales"
        aws.region = "us-west-2"
        aws.tags = {
          'Name' => 'Tiendas',
          'Team' => 'Tiendas',
          'Status' => 'active'
        }
        override.ssh.username = "ubuntu"

        aws.region_config "us-west-2" do |region|
          region.ami = 'ami-35143705'
          region.instance_type = 't2.micro'
          region.keypair_name = "credenciales"
          region.security_groups = "launch-wizard-3"
        end

        config.vm.provision "ansible" do |ansible|
          ansible.sudo = true
          ansible.playbook = "iv.yml"
          ansible.verbose = "v"
          ansible.host_key_checking = false
        end
    end
end


```

Si se tiene alguna duda, se puede consultar el siguiente [enlacen](https://github.com/mitchellh/vagrant-aws).


 - Como podemos ver, para desplegar la aplicación estamos usando **ansible**, este se encarga de instalar todos los paquetes necesarios, descargar nuestra aplicación de nuestro repositorio y ejecutarla, concretamente mi archivo **.yml** es el siguiente:

```
- hosts: default
  remote_user: ubuntu
  sudo: true
  tasks:
  - name: Actualizar sistema
    apt: update_cache=yes upgrade=dist
  - name: Instalar python-setuptools
    apt: name=python-setuptools state=present
  - name: Instalar build-essential
    apt: name=build-essential state=present
  - name: Instalar pip
    apt: name=python-pip state=present
  - name: Instalar git
    apt: name=git state=present
  - name: Ins Pyp
    apt: pkg=python-pip state=present
  - name: Instalar python-dev
    apt: pkg=python-dev state=present
  - name: Instalar libpq-dev
    apt: pkg=libpq-dev state=present
  - name: Instalar python-psycopg2
    apt: pkg=python-psycopg2 state=present
  - name: Obtener aplicacion de git
    git: repo=https://github.com/lorenmanu/Tiendai.git  dest=Tiendai clone=yes force=yes
  - name: Permisos de ejecucion
    command: chmod -R +x Tiendai
  - name: Instalar libreria para pillow
    command: sudo apt-get -y build-dep python-imaging --fix-missing
  - name: Instalar pillow
    command: sudo easy_install Pillow
  - name: Instalar requisitos
    command: sudo pip install -r Tiendai/requirements.txt
  - name: ejecutar
    command: nohup sudo python Tiendai/manage.py runserver 0.0.0.0:80

```

 - Ya solo nos queda desplegar nuestra aplicación, para ello pondremos en nuestra terminal en el directorio donde está el **Vagrantfile**

```

vagrant up --provider=aws

```

**Nota** en **--provider** estamos indicando el proveedor, en mi caso Amazon, si fuera azure deberíamos poner **azure**.


- Finalmente nuestra aplicación estará desplegada:

![img21](https://www.dropbox.com/s/w6s217d4pld9o0j/img24.png?dl=1)


**Aclaraciones ==> Security Groups**:

En el apartado **Security Groups** hay que tener en cuenta las peticiones que se van atender y las que se enviará, en concreto para mi aplicación permitiré que se pueda conectar a ella usando **ssh** y atender petiiones por internet, por lo que en el en la parte **Inbound** tendrá:

![img6](https://www.dropbox.com/s/lyu7nn1cg1326cr/img6.png?dl=1)

![img7](https://www.dropbox.com/s/5df40rptlt296ic/img7.png?dl=1)

La creación del **Security Groups** ya la hemos visto antes, para añadirle reglas de los puertos que va a antender y por donde los va a dirigir la podemos hacer de la misma manera con la cual la hemos creado, usando **Command Line Interface ==> CLI**.

```
aws ec2 authorize-security-group-ingress --group-name my-sg --protocol tcp --port 3389 --cidr 203.0.113.0/24

```

En **---port** indicamos el puerto y en **--cidr** a donde se dirigirán.

**Aclaraciones ==> ENV['NOMBRE-PRIMITIVA']**

Como se puede ver en el archivo **Vagrantfile** hago uso de **ENV['NOMBRE-PRIMITIVA']**, esto se debe a que aprovecho la posibilidad que me da **Vagrant** de pasar parámetros al archivo para introducir los credenciales de **Amazon**. Las variables se introducen cuando creemos o destruyamos la instancia singuiendo la siguiente sintaxis:

```
variable n=valor vagrant up/destroy --provider=aws
----------------------------------------------------
//Referencia en Vagrantfile

ENV['n']

```