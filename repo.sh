#!/bin/bash
    
sync () {
    cd ~/rom
    repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b $ROM_PROJECT -g default,-mips,-darwin,-notdefault
    echo "$manifest" > ~/rom/.repo/local_manifests/room_service.xml
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
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
     #export SELINUX_IGNORE_NEVERALLOWS=true
     #export USE_GAPPS=true
     #export NAD_BUILD_TYPE=OFFICIAL
     #export USE_PIXEL_CHARGING=true
     lunch lineage_maple_dsds-user
    #make sepolicy -j24
    #make bootimage -j24
    #make systemimage
    make bacon -j30
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
  cd ~/rom/device/sony/maple_dsds
  git #push github HEAD:cherish-12 -f
}

push_yoshino () {
  cd ~/rom/device/sony/yos*
  git #push github HEAD:cherish-12 -f
}

push_vendor () {
  cd ~/rom/vendor/sony/maple_dsds
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
