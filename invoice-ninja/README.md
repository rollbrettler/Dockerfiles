Dockerfile for Invoice Ninja
===========

With this Dockerfile you can build a Docker image for [Invoice Ninja](https://github.com/hillelcoren/invoice-ninja)


## How to use

This image build is based on the docker image of [tutum-docker-php](https://github.com/tutumcloud/tutum-docker-php) so it does not provide a mysql server. To use the image there are several ways.

### Use a Remote Database host

run the image from the repository

`docker run -d --name invoice-ninja -e "DATBASE_TYPE=mysql"  -e "DATBASE_HOST=db"  -e "DATBASE_NAME=ninja"  -e "DATBASE_USER=ninja"  -e "DATBASE_PASSWORD=ninja" -p 80:80 rollbrettler/invoice-ninja`

These are the default environment variables. Change the values to your server credentials.

### Use a docker mysql container

You first need to initialize the database container with a name. 

`docker run --name some-db-name -e MYSQL_ROOT_PASSWORD=root -P -d mysql`

After that, you need to connect to your mysql container and execute the sql that is recommended by invoice ninja developers. You find a copy in this repository (**database-setup.sql**)

Now you can start your invoice docker container

`docker run -d --name invoice-ninja --link some-db-name:db -p 80:80 rollbrettler/invoice-ninja`

Thats it your Invoice Ninja container is running.

## How to build

1. Clone the whole repo to your local machine
2. update the submodules with `git submodule foreach git pull`
3. change the directory to invoice-ninja src `cd invoice-ninja/invoice-ninja` 
4. install the dependencies of Invoice Ninja `composer install` and `bower install`
5. change back to root of repository `cd ../../`
6. use docker build to build the image `docker build -t="invoice-ninja" invoice-ninja/`

Your image is now ready to use on your local machine