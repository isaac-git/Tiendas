[![Build Status](https://travis-ci.org/lorenmanu/submodulo-lorenzo.svg?branch=master)](https://travis-ci.org/lorenmanu/submodulo-lorenzo)

[![Build Status](https://snap-ci.com/lorenmanu/submodulo-lorenzo/branch/master/build_image)](https://snap-ci.com/lorenmanu/submodulo-lorenzo/branch/master)

[![Heroku](https://www.herokucdn.com/deploy/button.png)](https://myclient.herokuapp.com/)

[![EC2](https://www.dropbox.com/s/st4etj28pyu11lb/aws-ec2_logo_small.jpg?dl=1)](http://ec2-52-11-219-71.us-west-2.compute.amazonaws.com)


## **Proyecto de IV(infraestructura Virtual) junto con DAI(DESARROLLO DE APLICACIONES DE INTERNET** ##

Autor: Lorenzo Manuel Rosas Rodríguez

### Breve Descripción/Introducción Tiendas
El proyecto consiste en una aplicación sencilla de Tiendas, la cual se pretende ir desarrollando más posteriormente. Permite añadir zonas( estas zonas se visualizarán usando "google easy maps") y dentro de cada zona se puede añadir las tiendas que tiene asociadas. Para poder añadir y visualizar tanto las tiendas como las zonas se necesita estar registrado, por lo que la aplicación también permite loguearse y registrarse. Además de estas funcionalidades, nuestra aplicación también muestra una gráfica indicando las visitas de cada tienda.

El proyecto se ha realizado usando Django, impartido en la asignatura de Desarrollo de Aplicaciones de Internet(DAI).

### Infraestructura en CLOUD

Se ha realizado en la nube(cloud) la infraestructura necesaria para la aplicación. Para ello ha sido necesario la instalación de diferentes librerías y su provisionamiento. Se ha trabajado servidores web, bases de datos, y aplicación web donde interactúan varios usuarios.

### Herramienta de Construcción
Aquí he usado el archivo con nos proporciona Django denominado **manage.py**, el cual sirve para:

- Realizar tareas de contrucción: entendemos por herramientas de construcción crear la base de datos, realizar insercciones en ella....
- Realizar tests de la aplicación: el cual lo utilizaremos para la integración continua.

**Nota**: el uso de este archivo lo podremos ver fundamentalmente en **snap-ci** y en **travis**.

Además del uso de este archivo se añade una serie de archivos, los cuales se encuentran en la carpeta **scripts**, y son:

- [docker_install_and_run](https://github.com/lorenmanu/Tiendas/blob/master/scripts/docker_install_and_run.sh): descarga el docker de la aplicación y lo ejecuta.
- [heroku_desploy.sh](https://github.com/lorenmanu/Tiendas/blob/master/scripts/heroku_deploy.sh): despliega la aplicación usando como **IAAS** heroku.
- [run_app.sh](https://github.com/lorenmanu/Tiendas/blob/master/scripts/run_app.sh): ejecuta nuestra aplicación en el puerto **80**:
- [herramientas_ec2](https://github.com/lorenmanu/Tiendas/blob/master/scripts/herramientas_ec2.sh): instala las herramientas necesarias para que nuestra aplicación se despliegue en ec2 usando **vagrant** y **ansible**.

### Ejecución local de la aplicación

Para ejecutar la aplicación de manera local, si ser desplegada en nigún **IAAS** y **PAASS**, bastará con:

- Clonar el repositorio donde se localiza la aplicación:
```
git clone https://github.com/lorenmanu/Tiendas.git
cd Tiendas

```

- Actualizar las base de datos:
```
python manage.py makemigrations
python manage.py migrate

```

- Creación de un usuario que pueda acceder a la base de datos de la aplicación por si quiere eliminar o incorporar datos usando la interfaz web de gestión de a base de datos de Django, referencia [aquí](https://docs.djangoproject.com/es/1.9/ref/django-admin/):

```
python manage.py createsuperuser

```

- Ejecutar la aplicación en local:

```
python manage.py runserver

```

### Testeo de la aplicación

Para realizar el testeo de la aplicación, es decir, la ejecución de los tests, me he servido de la funcionalidad entre otras que nos proporciona el archivo **manage.py**, en concreto se pone en la terminal dentro del directorio en el cual está el archivo:

```
sudo python manage.py test

```

Esta orden ejecutará los tests que indiquemos dentro de la carpeta de nuestra aplicación, en concreto en **apps/tiendas/tests.py**.
