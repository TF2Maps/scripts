#! /bin/bash

pushd $(mktemp -d)

echo "Downloading zip..."
wget -q $1

echo "Opening zip..."
unzip $(basename $1)

# Move all files here
echo "Moving files..."
find . -type f -name \*.bsp -exec mv -t . {} +

# Compress
echo "Compressing..."
bzip2 -z -k -9 *.bsp

# Upload in parallel
echo "Uploading files..."
/usr/bin/s3cmd put -P *.bz2 s3://tf2maps-maps/maps/ &
scp *.bsp us.tf2maps.net:/home/tf/tf/maps/ &
scp *.bsp eu.tf2maps.net:/home/tf/tf/maps/ &

wait

echo "Done!"

popd
