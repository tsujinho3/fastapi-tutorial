#!/bin/sh

# export COMPOSE_PROJECT_ID=$(date  '+%Y%m%d')
export COMPOSE_PROJECT_NAME=$(basename `pwd`)
# export COMPOSE_PROJECT_PORT=8000

export APP_NAME="python3"
# export DB_NAME="mysql"

export CONTAINER_USERNAME="rootless"
export CONTAINER_UID=$(id -u ${USER})
export CONTAINER_GID=$(id -g ${USER})


# lsof -i:${COMPOSE_PROJECT_PORT} > /dev/null

# if [ $? -eq 0 ]
# then
#     echo "port:${COMPOSE_PROJECT_PORT} is occupied." $1
#     echo "set another port number as COMPOSE_PROJECT_PORT."
#     exit 1
# fi

cd config

case $1 in
    -n | --no-build)
        OPT="-d"
    ;;
    *)
        OPT="--build -d --remove-orphans"
    ;;
esac

docker-compose up ${OPT}
# command: gunicorn project.wsgi:application --bind 0.0.0.0:8000
# docker-compose exec app gunicorn project.wsgi:application --bind 0.0.0.0:8000
docker-compose exec app /bin/zsh
# docker-compose down
docker-compose down -v
