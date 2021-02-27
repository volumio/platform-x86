#!/bin/bash
#
# This is still WIP, but working for some devices!!
# Kernel patch may be needed for specific board quirks (sound/boards/intel)
# (check possibility to set 16bit as default, see bytcr-rt5640.c and HP X2 detachables as an example)
#
for D in $(ls /usr/share/alsa/ucm); do
  if [[ $D == byt* ]] || [[ $D == cht* ]]; then
    DAC=$(aplay -l | grep $D)
    if [ ! -z "$DAC" ];then
      if [ ! -e /usr/share/alsa/ucm/$D/firsttime.done ]; then
        echo 'bytcr-init: first time run...'
        # Set headphones and speaker output, mixers enabled with
	      # reasonable outputlevels (ucm defaults)
        # Headphones are set last and thus become default
        echo "bytcr-init.sh: set initial output to headphones for "$(basename "$D")
  	    case "$D" in
	        bytcr-rt5640)
            echo "rt5640 detected"
            /usr/bin/alsaucm -c bytcr-rt5640 set _verb HiFi set _enadev Speaker
            /usr/bin/alsaucm -c bytcr-rt5640 set _verb HiFi set _enadev Headphones
            echo "bytcr-init: first time run done"
            touch /usr/share/alsa/ucm/$D/firsttime.done
          ;;
	        bytcr-rt5651)
            echo "rt5651 detected"
            /usr/bin/alsaucm -c bytcr-rt5651 set _verb HiFi set _enadev Speaker
            /usr/bin/alsaucm -c bytcr-rt5651 set _verb HiFi set _enadev Headphones
            echo "bytcr-init: first time run done"
            touch /usr/share/alsa/ucm/$D/firsttime.done
	        ;;
	        bytcht-es8316)
            echo "es8316 detected"
            echo "bytcr-init.sh: set initial output to headphones"
	          # may have to experiment with asound.state to get reasonable levels as with the rt5651 above
	          /usr/bin/alsaucm -c bytcht-es8316 set _verb HiFi set _enadev Headphones
            echo "bytcr-init: first time run done"
            touch /usr/share/alsa/ucm/$D/firsttime.done
	        ;;
	      esac

      fi
    fi
  fi
done

