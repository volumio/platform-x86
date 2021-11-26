#!/bin/bash
#
# This is still WIP, but working for Baytrail/ Cherrytrail with RT5640/RT5651/rt5672 codec
#
CODEC_RT5640="bytcr-rt5640"
CODEC_RT5651="bytcr-rt5651"
CODEC_RT5672="cht-bsw-rt5672"
CODEC_ES8316="bytcht-es8316"

for CODEC in $(ls /usr/share/alsa/ucm); do
  if [[ $CODEC == byt* ]] || [[ $CODEC == cht* ]]; then
    DAC=$(aplay -l | grep $CODEC)
    if [ ! -z "$DAC" ];then
      # Set headphones and speaker output, mixers enabled with
      # reasonable outputlevels (ucm defaults)
      # Headphones are set last and thus become default
      case "$CODEC" in
       $CODEC_RT5640 | $CODEC_RT5672)
          echo "${CODEC} detected"
          onoff=$(amixer -c0 get Headphone Jack|grep "Mono: Playback" |awk '{print $3}')
          if [ "${onoff}" = "[off]" ]; then
            echo "No headphones plugged in --> output to Speaker"
            /usr/bin/alsaucm -c ${CODEC} set _verb HiFi set _enadev Speaker
          else
            echo "Headphones plugged in --> output to Headphones"
            /usr/bin/alsaucm -c ${CODEC} set _verb HiFi set _enadev Headphones
          fi
          echo "Starting acpid.service for ${CODEC} jack detection"
          /bin/systemctl start acpid.service
          echo "${CODEC} initialised"
        ;;
        CODEC_RT5651 | CODEC_ES8316)
          echo "${CODEC} detected"
          echo "set initial output to headphones for $CODEC"
          /usr/bin/alsaucm -c ${CODEC} set _verb HiFi set _enadev Headphones
          echo "${CODEC} initialised"
        ;;
      esac
    fi
  fi
done



