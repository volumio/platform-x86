#!/bin/bash

for D in $(ls /usr/share/alsa/ucm); do
  if [[ $D == byt* ]] || [[ $D == cht* ]]; then
    DAC=$(aplay -l | grep $D)
    if [ ! -z "$DAC" ];then
      echo "$DAC located"
      if [ ! -e /usr/share/alsa/ucm/$D/firsttime.done ]; then
        echo "bytcr-init: first time run..."
        if [ $D == 'bytcr-rt5651' ]; then
# This device needs a initial asound.state with headphone output set and mixers enabled with reasonable outputlevels.
          cp /usr/share/alsa/ucm/$D/asound.state /var/lib/alsa
		  /usr/sbin/alsactl restore
        fi
        echo "bytcr-init.sh: set initial output to headphones for "$(basename "$D")
        /usr/bin/alsaucm -c $D set _verb HiFi set _enadev Headphones
        echo "bytcr-init: first time run done"
        touch /usr/share/alsa/ucm/$D/firsttime.done
      fi
    fi
  fi
done

