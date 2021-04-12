#!/bin/bash
#
# This is still WIP, but working for Baytrail with RT5640 codec
# Kernel patch may be needed for specific board quirks (sound/boards/intel)
# (check possibility to set 16bit as default, see bytcr-rt5640.c and HP X2 detachables as an example)
#
for D in $(ls /usr/share/alsa/ucm); do
  if [[ $D == byt* ]] || [[ $D == cht* ]]; then
    DAC=$(aplay -l | grep $D)
    if [ ! -z "$DAC" ];then
      # Set headphones and speaker output, mixers enabled with
      # reasonable outputlevels (ucm defaults)
      # Headphones are set last and thus become default
      case "$D" in
        bytcr-rt5640)
          echo "${D} detected"
          echo "Setting initial output for "$(basename "${D}")
          onoff=$(amixer -c0 get Headphone Jack|grep "Mono: Playback" |awk '{print $3}')
          if [ "${onoff}" = "[off]" ]; then
            echo "No headphones plugged in --> output to Speaker"
            /usr/bin/alsaucm -c ${D} set _verb HiFi set _enadev Speaker
          else
            echo "Headphones plugged in --> output to Headphones"
            /usr/bin/alsaucm -c ${D} set _verb HiFi set _enadev Headphones
          fi
          echo "starting acpid.service for jack detection"
          /bin/systemctl start acpid.service
          echo "${D} initialised"
        ;;
        bytcr-rt5651 | bytcht-es8316)
          echo "${D} detected"
          echo "set initial output to headphones for "$(basename "$D")
          /usr/bin/alsaucm -c ${D} set _verb HiFi set _enadev Headphones
          echo "${D} initialised"
        ;;
      esac
    fi
  fi
done

