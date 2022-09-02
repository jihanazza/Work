#!/bin/bash
    
sync () {
    cd ~/rom
    repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve-one -g default,-mips,-darwin,-notdefault
    git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b maple_cherish .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

build () {
     cd ~/rom
     . build/envsetup.sh
     export CCACHE_DIR=~/ccache
     export CCACHE_EXEC=$(which ccache)
     export USE_CCACHE=1
     ccache -M 50G
     ccache -z
     export BUILD_HOSTNAME=znxt
     export BUILD_USERNAME=znxt
     export TZ=Asia/Jakarta
     lunch cherish_maple-user
    #make sepolicy -j24
    #make bootimage -j24
    #make systemimage &
    #make installclean
    mka bacon -j30
}

compile () {
    sync
    echo "done."
    build
}

push_kernel () {
  cd ~/rom/kernel/sony/ms*
  git #push github HEAD:refs/heads/cherish-12
}

push_device () {
  cd ~/rom/device/sony/maple
  git #push github HEAD:cherish-12 -f
}

push_yoshino () {
  cd ~/rom/device/sony/yos*
  git #push github HEAD:cherish-12 -f
}

push_vendor () {
  cd ~/rom/vendor/sony/maple
  git #push github HEAD:cherish-12 -f
}

cd ~/rom
ls -lh
compile &
sleep 114m
kill %1
#push_kernel
#push_device
#push_yoshino
#push_vendor

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
