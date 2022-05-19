#!/bin/bash
cd /cirrus/rom
    
sync () {
    #rm -rf .repo/local_manifests
    #repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve-one -g default,-mips,-darwin,-notdefault
    #git clone https://github.com/ariffjenong/local_manifest.git --depth=1 -b $ROM_PROJECT .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
}

compile () {
    sync
    echo "done."
}

push_kernel () {
  cd /cirrus/rom/kernel/sony/ms*
  git push github HEAD:refs/heads/cherish-12
}

push_device () {
  cd /cirrus/rom/device/sony/maple_dsds
  git push github HEAD:cherish-12 -f
}

push_yoshino () {
  cd /cirrus/rom/device/sony/yos*
  git push github HEAD:cherish-12 -f
}

push_vendor () {
  cd /cirrus/rom/vendor/sony/maple_dsds
  git push github HEAD:cherish-12 -f
}

patch () {
  cd device/sony/maple_dsds
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/applyPatches.sh
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/workaround_egl_lib_symbols.patch
  git add . && git commit -m 'apply path'
}

ls -lh
#compile
push_kernel
push_device
push_yoshino
push_vendor
#patch

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
