## Como usar hub.docker.com ##

Deberemos realizar los siguientes pasos para desplegar nuestra aplicación en docker-hub:
- Registrarnos en [hub.docker.com](https://hub.docker.com/add/automated-build/github/orgs/?namespace=lorenmanu).

- Una vez registrados le daremos a **Create/Create Automated Build** en el repositorio del proyecto. Aquí tardará un poco ya que se estará construyendo la imagen.

- Una vez creada la imagen, nos tiene que permitir ver el **DockerFile** y el apartado **Docker Pull Command**.

![img5](https://www.dropbox.com/s/48m4nnlza084whp/img5.png?dl=1)

Para ejecutar la imagen en nuestra máquina anfitriona hay que realizar lo siguiente:

- Descargar la imagen:

```
docker pull lorenmanu/submodulo-lorenzo

```

![img7](https://www.dropbox.com/s/yl4i0e5ft3lmpld/img7.png?dl=1)

- Arrancarla:

```
sudo docker run i -t lorenmanu/submodulo-lorenzo /bin/bash

```
![img8](https://www.dropbox.com/s/jdwqgser8f9ve5a/img8.png?dl=1)

- Nos vamos al directorio de la app, obtenemos su dirección ip con el comando **ifconfig**, y finalmente la lanzaremos pa visualizarla en nuestro ordenador:

![img9](https://www.dropbox.com/s/h9vb2a8jvsz83qg/xexo.png?dl=1)
