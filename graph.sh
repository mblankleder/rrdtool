#!/bin/bash

# Parameters
RRD=$1
IMG=$2

hora_fecha=$(date +"%F %R")
hora_fin=$(date +%s)
hora_inicio=$((${hora_fin} - 3600))
hora_limites="--start ${hora_inicio} --end ${hora_fin}"

dia_fecha=$(date +"%A %F")
dia_fin=${hora_fin}
dia_inicio=$((${dia_fin} - 3600 * 24))
dia_limites="--start ${dia_inicio} --end ${dia_fin}"

semana_fecha=$(date "+semana %V %Y")
semana_fin=${hora_fin}
semana_inicio=$((${semana_fin} - 3600 * 24 * 7))
semana_limites="--start ${semana_inicio} --end ${semana_fin}"

mes_fecha=$(date "+%B %Y")
mes_fin=${hora_fin}
mes_inicio=$((${mes_fin} - 3600 * 24 * 28))
mes_limites="--start $((${mes_inicio} - 3600 * 24)) --end ${mes_fin} --x-grid DAY:1:WEEK:1:DAY:1:0:%e"

anio_fecha=$(date "+%Y")
anio_fin=${hora_fin}
anio_inicio=$((${anio_fin} - 3600 * 24 * 365))
anio_limites="--start ${anio_inicio} --end ${anio_fin}"

hora="$(perl -e 'print time, "\n" ')"

/usr/bin/rrdtool graph ../img/traf_$IMG ${hora_limites} --title Trafico:"${hora_fecha}" -h 200 -w 600 --upper-limit 3000 --lower-limit 0 --vertical-label Trafico DEF:TrafficIN=../rrds/$RRD:TrafficIN:AVERAGE DEF:TrafficOUT=../rrds/$RRD:TrafficOUT:AVERAGE CDEF:inbits=TrafficIN,8,* CDEF:outbits=TrafficOUT,8,* AREA:inbits#00FF00:"Entrante" GPRINT:inbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:inbits:MAX:"Max\:%8.1lf %s" GPRINT:inbits:MIN:"Min\:%8.1lf %s" GPRINT:inbits:AVERAGE:"Promedio\:%8.1lf %s \n"  LINE1:outbits#0000FF:"Saliente" GPRINT:outbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:outbits:MAX:"Max\:%8.1lf %s" GPRINT:outbits:MIN:"Min\:%8.1lf %s" GPRINT:outbits:AVERAGE:"Promedio\:%8.1lf %s"

/usr/bin/rrdtool graph ../img/traf_dia_$IMG ${dia_limites} --title Trafico:"${dia_fecha}" -h 200 -w 600 --upper-limit 3000 --lower-limit 0 --vertical-label Trafico DEF:TrafficIN=../rrds/$RRD:TrafficIN:AVERAGE DEF:TrafficOUT=../rrds/$RRD:TrafficOUT:AVERAGE CDEF:inbits=TrafficIN,8,* CDEF:outbits=TrafficOUT,8,* AREA:inbits#00FF00:"Entrante" GPRINT:inbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:inbits:MAX:"Max\:%8.1lf %s" GPRINT:inbits:MIN:"Min\:%8.1lf %s" GPRINT:inbits:AVERAGE:"Promedio\:%8.1lf %s \n"  LINE1:outbits#0000FF:"Saliente" GPRINT:outbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:outbits:MAX:"Max\:%8.1lf %s" GPRINT:outbits:MIN:"Min\:%8.1lf %s" GPRINT:outbits:AVERAGE:"Promedio\:%8.1lf %s"

/usr/bin/rrdtool graph ../img/traf_semana_$IMG ${semana_limites} --title Trafico:"${semana_fecha}" -h 200 -w 600 --upper-limit 3000 --lower-limit 0 --vertical-label Trafico DEF:TrafficIN=../rrds/$RRD:TrafficIN:AVERAGE DEF:TrafficOUT=../rrds/$RRD:TrafficOUT:AVERAGE CDEF:inbits=TrafficIN,8,* CDEF:outbits=TrafficOUT,8,* AREA:inbits#00FF00:"Entrante" GPRINT:inbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:inbits:MAX:"Max\:%8.1lf %s" GPRINT:inbits:MIN:"Min\:%8.1lf %s" GPRINT:inbits:AVERAGE:"Promedio\:%8.1lf %s \n"  LINE1:outbits#0000FF:"Saliente" GPRINT:outbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:outbits:MAX:"Max\:%8.1lf %s" GPRINT:outbits:MIN:"Min\:%8.1lf %s" GPRINT:outbits:AVERAGE:"Promedio\:%8.1lf %s"

/usr/bin/rrdtool graph ../img/traf_mes_$IMG ${mes_limites} --title Trafico:"${mes_fecha}" -h 200 -w 600 --upper-limit 3000 --lower-limit 0 --vertical-label Trafico DEF:TrafficIN=../rrds/$RRD:TrafficIN:AVERAGE DEF:TrafficOUT=../rrds/$RRD:TrafficOUT:AVERAGE CDEF:inbits=TrafficIN,8,* CDEF:outbits=TrafficOUT,8,* AREA:inbits#00FF00:"Entrante" GPRINT:inbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:inbits:MAX:"Max\:%8.1lf %s" GPRINT:inbits:MIN:"Min\:%8.1lf %s" GPRINT:inbits:AVERAGE:"Promedio\:%8.1lf %s \n"  LINE1:outbits#0000FF:"Saliente" GPRINT:outbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:outbits:MAX:"Max\:%8.1lf %s" GPRINT:outbits:MIN:"Min\:%8.1lf %s" GPRINT:outbits:AVERAGE:"Promedio\:%8.1lf %s"

/usr/bin/rrdtool graph ../img/traf_anio_$IMG ${anio_limites} --title Trafico:"${anio_fecha}" -h 200 -w 600 --upper-limit 3000 --lower-limit 0 --vertical-label Trafico DEF:TrafficIN=../rrds/$RRD:TrafficIN:AVERAGE DEF:TrafficOUT=../rrds/$RRD:TrafficOUT:AVERAGE CDEF:inbits=TrafficIN,8,* CDEF:outbits=TrafficOUT,8,* AREA:inbits#00FF00:"Entrante" GPRINT:inbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:inbits:MAX:"Max\:%8.1lf %s" GPRINT:inbits:MIN:"Min\:%8.1lf %s" GPRINT:inbits:AVERAGE:"Promedio\:%8.1lf %s \n"  LINE1:outbits#0000FF:"Saliente" GPRINT:outbits:LAST:"Actualmente\:%8.1lf %s" GPRINT:outbits:MAX:"Max\:%8.1lf %s" GPRINT:outbits:MIN:"Min\:%8.1lf %s" GPRINT:outbits:AVERAGE:"Promedio\:%8.1lf %s"

