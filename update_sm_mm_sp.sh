#! /bin/bash

tf_install_dir=/home/tf/tf
tf_user=tf

# Install Metamod
temp_dir=$(mktemp -d)
pushd $temp_dir

metamod_latest=$(curl --silent https://www.metamodsource.net/downloads.php | grep -iPo "(?<=href=\').*mmsource-.*-linux.tar.gz" | sort | tail -1)
wget $metamod_latest
tar -xzf $(basename $metamod_latest) --directory $tf_install_dir

popd
rm -rf $temp_dir


# Install Sourcemod
temp_dir=$(mktemp -d)
pushd $temp_dir

sourcemod_latest=$(curl --silent https://www.sourcemod.net/downloads.php?branch=stable | grep -iPo "(?<=href=\').*sourcemod-.*-linux.tar.gz" | sort | tail -1)
wget $sourcemod_latest
tar -xzf $(basename $sourcemod_latest) --exclude='addons/sourcemod/plugins' --exclude='addons/sourcemod/configs' --directory $tf_install_dir

popd
rm -rf $temp_dir


# Install Source Python
temp_dir=$(mktemp -d)
pushd $temp_dir

source_python_latest=$(curl --silent http://downloads.sourcepython.com/ | grep -iPo '(?<=href=\").*source-python-tf2.*.zip' | uniq)
wget http://downloads.sourcepython.com/${source_python_latest}
unzip $(basename $source_python_latest) -d $tf_install_dir

popd
rm -rf $temp_dir

chown -R $tf_user:$tf_user $tf_install_dir