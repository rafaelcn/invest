FROM    hhvm/hhvm-proxygen:latest
LABEL   maintainer="Rafael Campos Nunes <rafaelnunes@engineer.com>"

RUN     apt-get update && apt-get install mysql-server -y

RUN     rm -rf /var/www
ADD     ./public/ /var/www/public/

EXPOSE  80
