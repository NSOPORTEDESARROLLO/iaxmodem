FROM    debian:buster   AS  builder
MAINTAINER Christopher Naranjo <cnaranjo@nsoporte.com>


#Actualizar repositorios
RUN     apt-get update;apt-get -y upgrade

#Software necesario para compilar 
RUN     apt-get -y install wget build-essential libtiff5-dev; \
        wget "https://sourceforge.net/projects/iaxmodem/files/iaxmodem/iaxmodem-1.3.0.tar.gz/download" \
         -O /usr/src/iaxmodem-1.3.0.tar.gz; \
          tar -xzvf /usr/src/iaxmodem-1.3.0.tar.gz -C /usr/src

#Compilando software
WORKDIR  /usr/src/iaxmodem-1.3.0/lib/libiax2
RUN     ./configure --prefix=/opt/iaxmodem;make;make install
WORKDIR   /usr/src/iaxmodem-1.3.0/lib/spandsp
RUN     ./configure --prefix=/opt/iaxmodem;make;make install
WORKDIR  /usr/src/iaxmodem-1.3.0
RUN      ./configure;make;cp -rfvp iaxmodem /opt/iaxmodem/bin/; \
         ln -s /opt/iaxmodem/bin/iaxmodem /usr/bin/; \
         mkdir /opt/iaxmodem/samples; \
         cp config.ttyIAX /opt/iaxmodem/samples/; \
         cp iaxmodem-cfg.ttyIAX /opt/iaxmodem/samples/


#Crear contenedor con las libreias minimas
FROM debian:buster

#Copiar archivos 
COPY --from=builder /opt/iaxmodem /opt/iaxmodem

#Optimizaciones para el contenedor 
WORKDIR /opt/iaxmodem

#Actualizar repositorios
RUN     apt-get update;apt-get -y upgrade; \
        apt-get -y install  libtiff5; \
        ln -s /opt/iaxmodem/bin/iaxmodem /usr/bin/; \
        mkdir -p /var/log/iaxmodem; \
        mkdir /etc/iaxmodem


#Incio 
COPY    files/ns-start /usr/bin/

RUN     chmod +x /usr/bin/ns-start


ENTRYPOINT [ "/usr/bin/ns-start" ]