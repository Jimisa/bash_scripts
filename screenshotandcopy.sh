#!/bin/bash

if [[ $1 = "-h" ]]; then
    echo "USAGE             :   ./screenshotandcopy.sh [DIRECTORY]"
    echo "                      the script is intended to be triggered with a keyboard shortcut"
    echo "                      in order to speed up screen copy in a markdown documentation writing"
    echo "                      It uses Deepin to create a screenshot saved in Desktop, move and rename"
    echo "                      in the _media folder of the working markdown (docsify) documentation folder." 
    echo "                      In addition, it will format the markdown string refering to the freshly screenshot"
    echo "                      and copy in clipboard for instant use."
    echo ""
    echo ""
    echo "SYNOPSIS          :   Take a screenshot and CRTL+V to insert MD formatted link in your documentation."
    echo ""
    echo "OPTIONS           :"
    echo "       -h         :   help"
    echo ""
    echo "       DIRECTORY  :   it must be the relative path leading to the docsify working sub-directory.sh"
    echo "                      ex: cours/python if destination folder is ~/docsify/docs/cours/python/_media"
    echo ""
    exit 0
fi

relfilepath=_media/
absfilepath=$HOME/Documents/Docsify/docs/$1/$relfilepath
desktoppath=$HOME/Bureau

# show error with a file in the desktop directory
if [[ ! -d $absfilepath ]]; then 
  touch $desktoppath/wrong_destination_path
  exit 1
fi

# take a screenshot (not working on Ubuntu > 18.10)
deepin-screenshot

# more than one argument
if [[ $# -gt 1 ]]; then
  touch $desktoppath/too_much_arguments
  exit 1
fi

# It must be only one deepin file in source folder
nbresult=$(ls $desktoppath | grep Deepin | wc -l)
if [[ $nbresult -ne 1 ]]; then 
  touch $desktoppath/no-or-more-than-one-file-found
  exit 1
fi

# rename the screenshot, move it to destination folder, copy the formatted string in clipboard for instant use
filename=screenshot_$(date +%s)
file=$(find $desktoppath -maxdepth 1 -cmin -1 -name "*Deepin*" -exec mv '{}' $absfilepath/$filename.png \;)
echo "![screenshot]("$relfilepath$filename".png)" | xclip -sel clip
