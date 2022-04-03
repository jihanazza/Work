#!/bin/bash
cd /cirrus/rom
    
sync () {
    rm -rf .repo/local_manifests
    pick=$(pwd)
    echo "ENCRYPTED[f37472653ca421cc7160118b7acb835ca17030ad9d095cbf9ce87a106b241c9216a15666e8589f33dcb82f63c771d55c]" > /.repo/local_manifests/pick.sh
    ls .repo/local_manifests
    #repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve-one -g default,-mips,-darwin,-notdefault
    git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b $ROM_PROJECT .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

compile () {
    sync
    echo "done"
}

ls -lh
compile

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
