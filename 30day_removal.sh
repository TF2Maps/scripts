#!/bin/bash

#removes bsp and bz2 files that are older than 30 days
#ONLY if they reside in tf/custom/maptests/maps
#ignore other files on the fastdl if they do not have a bsp there


#find ./ad_bunker_b3.bsp -maxdepth 1 -type f -mtime +30 -print
#find /home/tf/tf/custom/maptests/maps/ -name ad_bunker_b3.bsp -mtime +30 -print

search_dir=/home/tf/tf/custom/maptests/maps/
for entry in "$search_dir"*
do
        filename=$(basename "$entry")
        extension="${filename##*.}"
        filename="${filename%.*}"

        MAP_DIR=/home/tf/tf/custom/maptests/maps/
        if [[ $(find "$MAP_DIR" -name "$filename".bsp -mtime +30 -print) ]]; then
		echo "$filename is older than 30 days, removing from maps folder and fastdl."
		rm /home/tf/tf/custom/maptests/maps/$filename.bsp
		rm /var/www/html/maps/$filename.bsp.bz2
	fi

done
