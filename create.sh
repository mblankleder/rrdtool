#!/bin/bash

## for 5 min
# step=${step:="300"}

## for 1 min
step=${step:="60"}
minsamples=${minsamples:="720"}

avgsamps () {
  avg=$(($1 / $2))
  if [ ${avg} -lt 1 ]
  then
    avg=1
  fi
  echo ${avg}
}
archives () {
  arch=$(($1 / $2))
  if [[ $(($2 * ${arch} * $3)) -lt $4 ]]
  then
    arch=$((${arch} + 1))
  fi
  echo ${arch}
}

yearsamps=$((31622400 / ${step}))
yearavgs=$(avgsamps ${yearsamps} ${minsamples})
yeararchives=$(archives ${yearsamps} ${yearavgs} ${step} 31622400)

heartbeat=$((${step} * 2))
hoursamps=$((3600 / ${step}))
houravgs=$(avgsamps ${hoursamps} ${minsamples})
hourarchives=$(archives ${hoursamps} ${houravgs} ${step} 3600)
daysamps=$((86400 / ${step}))
dayavgs=$(avgsamps ${daysamps} ${minsamples})
dayarchives=$(archives ${daysamps} ${dayavgs} ${step} 86400)
weeksamps=$((604800 / ${step}))
weekavgs=$(avgsamps ${weeksamps} ${minsamples})
weekarchives=$(archives ${weeksamps} ${weekavgs} ${step} 604800)
monthsamps=$((2678400 / ${step}))
monthavgs=$(avgsamps ${monthsamps} ${minsamples})
montharchives=$(archives ${monthsamps} ${monthavgs} ${step} 2678400)
yearsamps=$((31622400 / ${step}))
yearavgs=$(avgsamps ${yearsamps} ${minsamples})
yeararchives=$(archives ${yearsamps} ${yearavgs} ${step} 31622400)

hourrra="RRA:AVERAGE:0.5:${houravgs}:${hourarchives}"
dayrra="RRA:AVERAGE:0.5:${dayavgs}:${dayarchives}"
weekrra="RRA:AVERAGE:0.5:${weekavgs}:${weekarchives}"
monthrra="RRA:AVERAGE:0.5:${monthavgs}:${montharchives}"
yearrra="RRA:AVERAGE:0.5:${yearavgs}:${yeararchives}"
allrras="${hourrra} ${dayrra} ${weekrra} ${monthrra} ${yearrra}"
#"RRA:AVERAGE:0.2:1:2880"   # 2880 = 10 days of 5 min intervals
#"RRA:AVERAGE:0.1:12:8760"  # 8760 = 365 days of 1 hour intervals

# Traffic - 1 min
/usr/bin/rrdtool create traff_name.rrd --step ${step} DS:TrafficIN:COUNTER:${heartbeat}:0:U DS:TrafficOUT:COUNTER:${heartbeat}:0:U ${allrras}
