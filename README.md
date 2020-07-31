# lemp-docker
A LEMP stack docker container for Laravel/Symfony like apps. 

For use this edit the **.env** file with the name of your project and the path of your workspace. by default a mysql database "default" will be created with "root" as user and "default" as password, you can change it in the same **.env** file.

```bash
APP_NAME=**project name**
MYSQL_DATABASE=default
MYSQL_ROOT_PASSWORD=default
WORK_DIRECTORY=**/path/to/work/directory**
```

For create a new symfony project use:

```bash
docker-compose exec php composer create-project symfony/skeleton .
```

Or Laravel:

```bash
docker-compose exec php composer create-project --prefer-dist laravel/laravel .
```

Both examples will be created on the **src** folder.

Just go to your web browser at localhost:80 & enjoy!
