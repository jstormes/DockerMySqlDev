# PowerShell Script to start a temporary MySql server.
# This script starts a MySql docker container, then starts a
# bash shell in the container.
#
# When the user exits the bash shell it stops the container.
#
#
$CONTAINER_NAME = "mysql-dev"
$MYSQL_ROOT_PASSWORD = "mypassword"
$MYSQL_DATABASE_NAME = "employees"
$EXTERNAL_MYSQL_PORT = "4001"
$DOCKER_HUB_IMAGE = "mariadb"  # Other Options include "mariadb", "mysql:5.5"

if (-Not (Get-Command "docker" -errorAction SilentlyContinue))
{
    echo "Docker not installed, the 'docker' command is required to run this scrip."
    exit
}

$project_root = (get-item $PSScriptRoot ).parent.FullName

docker run --detach --rm --name=$CONTAINER_NAME -h $CONTAINER_NAME -v $project_root/:/opt/project -w /opt/project `
    -p ${EXTERNAL_MYSQL_PORT}:3306 `
    -e="MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" -e="MYSQL_DATABASE_NAME=$MYSQL_DATABASE_NAME" `
    -e="EXTERNAL_MYSQL_PORT=$EXTERNAL_MYSQL_PORT" -e="CONTAINER_NAME=$CONTAINER_NAME" $DOCKER_HUB_IMAGE
docker exec -it $CONTAINER_NAME bash -c 'exec bash /opt/project/bin/bashrc'
docker stop $CONTAINER_NAME
