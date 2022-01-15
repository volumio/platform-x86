#!/bin/bash

for card in /sys/class/sound/card*; do
  cardno=$(cat $card/number)
  chip=$(amixer -c $cardno info | grep "Mixer name" | awk -F": " '{print (substr($2, 2, length($2) - 2))}')
  cardname=$(cat /proc/asound/cards | grep "$(cat $card/number) \[$(cat $card/id)" | awk -F" - " '{print $2}')
  case $cardname in
    "HDA Intel PCH"|"HDA Intel"|"HDA ATI SB"|"HD-Audio Generic"|"HDA C-Media")
      case $chip in
        "Realtek ALC283")
        # not all HDA Intel PCH/ ALC283 have spdif out ==> mixer may be missing
          mixer_exists=$(amixer -c 0 | grep "IE958,16")
          if [ ! "x$mixer_exists" == "x" ]; then
            /usr/bin/amixer -c $cardno set IEC958,16 unmute
          fi
          /usr/bin/amixer -c $cardno set Master "75%" unmute
          ;;
        "Realtek ALC887-VD"|"Realtek ALC888-VD"|"Realtek ALC889A")
          /usr/bin/amixer -c $cardno set IEC958 unmute
          ;;
        "Realtek ALC270"|"Realtek ALC892"|"Realtek ALC898"|"Realtek ALC1220"|"C-Media Generic")
          /usr/bin/amixer -c $cardno set Surround,0 mute
          /usr/bin/amixer -c $cardno set Center,0 mute
          /usr/bin/amixer -c $cardno set LFE,0 mute
          /usr/bin/amixer -c $cardno set IEC958,16 unmute
          /usr/bin/amixer -c $cardno set Front "92%" unmute
          /usr/bin/amixer -c $cardno set Headphone "92%" unmute
          /usr/bin/amixer -c $cardno set Master "75%" unmute
          ;;
        "Realtek ALC668")
          /usr/bin/amixer -c $cardno set Headphone "92%" unmute
          /usr/bin/amixer -c $cardno set Speaker "92%" unmute
          /usr/bin/amixer -c $cardno set Master "75%" unmute
          ;;
        "IDT 92HD81B1X5")
          /usr/bin/amixer -c $cardno set Headphone "92%" unmute
          /usr/bin/amixer -c $cardno set Speaker "92%" unmute
          /usr/bin/amixer -c $cardno set Master  "75%" unmute
          ;;
      esac
  esac
done
exit 0
