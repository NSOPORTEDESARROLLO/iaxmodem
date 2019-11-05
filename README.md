## Iaxmodem Container:

Este docker contiene el Iaxmodem. Si se necesita mas de un modem se debe ejecutar contenedores por separado especificando el archivo de configuracion mediante la vaariable "CONF"


## Volumenes:

* /var/log/iaxmodem: Donde se almacenan los logs
* /etc/iaxmodem: Archivos de configuracion 

## Variables:

* CONF: Indique el nombre del archivo de configuracion, si no se especifica alguno entonces se creara uno por defecto llamado: iaxmodem-cfg.ttyIAX


## Archivo de configuracion de Eejemplo:

device		/dev/ttyIAX <br>
owner		uucp:uucp <br>
mode		660 <br>
port		4570 <br>
refresh		300 <br>
server		127.0.0.1 <br>
peername	iaxmodem <br>
secret		password <br>
cidname		John Doe <br>
cidnumber	8005551212 <br>
codec		slinear <br>

