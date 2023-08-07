#!/bin/bash

#Check the redirect directory if the bz2 file exists
#if not compress and output there
#if it does do nothing

search_dir=/home/tf/tf/custom/maptests/maps/
for entry in "$search_dir"*
do
	filename=$(basename "$entry")
	extension="${filename##*.}"
	filename="${filename%.*}"

	FILE=/var/www/html/maps/$filename.bsp.bz2
	if test -f "$FILE"; then
		echo "$FILE exists, ignoring."
	else
		#bz2 creates file in /custom and in the redirect folder
		echo "$FILE does not exist, compressing and moving."
		bzip2 -zk /home/tf/tf/custom/maptests/maps/$filename.bsp
		mv /home/tf/tf/custom/maptests/maps/$filename.bsp.bz2 /var/www/html/maps/
	fi
done
