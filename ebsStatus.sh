#!/bin/bash
#
# ebsStatus.sh - Programa feito para identificar dispositivos Khomp com status DOWN
#
# Autor: Anderson Freitas <tmsi.freitas@gmail.com>
# Site: http://www.dialplanreload.com/
# Repositorio: https://github.com/DialplanReload/ebsStatus
#
# Desenvolvido sob licensa GPL. 
# Fique a vontade para contribuir com a evolucao deste programa.
#
#-----------------------------------------------------------------------------------------------
# Modo de Uso
# Deve ser invocado o script na forma ./ebsStatus.sh NUMERO_DA_PLACA MAC_DA_PLACA
#
#

#
# EMAIL DE DESTINO
#
mail=tmsi.freitas@gmail.com

#
# ARQUIVO DE LOG
#
archive=/root/ebsStatus.log

date=$(date +%T...%F)
status=$(asterisk -rx "khomp summary" | egrep "\[\[ $1 \]\]|$2" | egrep "UP|DOWN" | awk '{print $10}'| head -n1)

if [ $status == "UP" ] ; then

	echo "$date   EBS $1 - $2 .......... $status" >> $archive

else

	echo "A PLACA $1 COM MAC ADDRESS $2 ESTA DOWN" | mailx -s "VERIFICAR EBS - STATUS DOWN" $mail 
	echo "$date   EBS $1 - $2 .......... $status" >> $archive

fi
