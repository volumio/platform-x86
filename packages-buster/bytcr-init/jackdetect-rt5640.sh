#!/bin/bash

case $1 in
  "jack/headphone HEADPHONE unplug")
    /usr/bin/alsaucm -c bytcr-rt5640 set _verb HiFi set _enadev Speaker
    ;;
  "jack/headphone HEADPHONE plug")
    /usr/bin/alsaucm -c bytcr-rt5640 set _verb HiFi set _enadev Headphones
    ;;
esac