# lemp-docker
A LEMP stack docker container for Laravel/Symfony like apps. 

For use this conainer edit the **.env** file with the name of your project, the ports of nginx server, xdebug and the path of your workspace. by default a mysql database "default" will be created with "root" as user and "default" as password, you can change it in the same **.env** file.

```bash
APP_NAME=**project name**
MYSQL_DATABASE=default
MYSQL_ROOT_PASSWORD=default
MYSQL_PORT=3306
NGINX_PORT=80
XDEBUG_PORT=9005
XDEBUG_REMOTE_HOST=#docker.for.win.localhost (Windows users) or host.docker.internal (MacOS users)
WORK_DIRECTORY=#/path/to/work/directory
```

For enter to the container use:

```bash
docker exec -it <container_name> bash 
```

By default, you will be in the /var/www/html forlder in the container, now you can create a project, for example for create a symfony project use:

```bash
composer create-project symfony/skeleton .
```

and it will be mirrored on the **project** folder.

Just go to your web browser at localhost:80 & enjoy!
