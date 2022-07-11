#!/bin/bash

if [[ $1 = "-h" ]]; then
    echo "USAGE             :   ./resize_image.sh [OPTIONS] [compression_rate]"
    echo "                      the script should be run in the working directory"
    echo "                      where are the images to be resized."
    echo "                      The resized images are ine the same directory with r[rate] prefix."
    echo "" 
    echo ""
    echo "SYNOPSIS          :   Resize jpg or png files with imageMagik"
    echo ""
    echo "OPTIONS           :"
    echo "  -h              :   help"
    echo ""
    echo "  compression_rate:   similar to \"-resize\" convert option. Percentage."
    echo "                      Default 50%."
    exit 0
fi

read -p "Taux de compression (%) [default 50%]: " input
echo $input
if [[ -z $input ]]; then
    taux=50
elif [[ $input -ge 100 || $input -le 0 ]]; then
    echo "It must be an integer between 0 and 100"
    exit 1
else
    taux=$input
fi

images_files=$(ls $(pwd) | grep 'jpg\|png')

for file in $images_files ; do
  echo $taux
  newname='r'$taux'_'$file
  echo $newname
  convert $file -resize %$taux $newname
done

exit 0