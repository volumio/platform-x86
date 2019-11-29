#!/bin/bash

for D in $(ls /usr/share/alsa/ucm); do
  if [[ $D == byt* ]] || [[ $D == cht* ]]; then
    DAC=$(aplay -l | grep $D)
    if [ ! -z "$DAC" ];then
      echo "$DAC located"
      if [ ! -e /usr/share/alsa/ucm/$D/firsttime.done ]; then
        echo 'bytcr-init: first time run...'
        
	  	case "$D" in
			bytcr-rt5651) echo 'rt5651 detected'
			  # This device needs a initial asound.state with headphone output set and mixers enabled with
			  # reasonable outputlevels.
        	  cp /usr/share/alsa/ucm/$D/asound.state /var/lib/alsa
			  /usr/sbin/alsactl restore      
        	  echo "bytcr-init.sh: set initial output to headphones for "$(basename "$D")
	          /usr/bin/alsaucm -c $D set _verb HiFi set _enadev Headphones
			;;

			bytcr-es8316) echo 'es8316 detected'
			  # may have to experiment with asound.state to get reasonable levels as with the rt5651 above
	          /usr/bin/alsaucm -c $D set _verb HiFi set _enadev Headphones
			;;
		esac

        echo "bytcr-init: first time run done"
        touch /usr/share/alsa/ucm/$D/firsttime.done
      fi
    fi
  fi
done

