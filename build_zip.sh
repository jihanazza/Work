#!/bin/bash

com () {
    #tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
    tar "-I zstd -1 -T2" -cf $1.tar.zst $1
}

get_ccache () {
  cd ~
  time com ccache 1
  time rclone copy ccache.tar.* znxtproject:ccache/kernel/$ROM_PROJECT -P
  time rm ccache.tar.*
  ls -lh
}

system () {
  cd ~/rom/out/target/product/maple_dsds/system/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/CherishOS/$ROM_PROJECT/system/etc -P
}

product () {
  cd ~/rom/out/target/product/maple_dsds/system/product/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/CherishOS/$ROM_PROJECT/system/product/etc -P
}

system-ext () {
  cd ~/rom/out/target/product/maple_dsds/system/system-ext/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/CherishOS/$ROM_PROJECT/system/system-ext/etc -P
}

vendor () {
  cd ~/rom/out/target/product/maple_dsds/system/vendor/etc
  ls -lh
  time com selinux 1
  time rclone copy selinux.tar.* znxtproject:rom/CherishOS/$ROM_PROJECT/system/vendor/etc -P
}

root () {
  cd ~/rom/out/target/product/maple_dsds/recovery/root
  ls -lh
  time rclone copy sepolicy znxtproject:rom/CherishOS/$ROM_PROJECT/system/ -P
}

get_selinux () {
  system
  product
  system-ext
  vendor
  root
}

get_out () {
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
     lunch nad_maple_dsds-user
    make installclean
  time com out 9
  time rclone copy out.tar.* znxtproject:ccache/kernel/$ROM_PROJECT -P
  time rm out.tar.*
  ls -lh
}

#get_selinux
get_ccache
get_out

# Lets see machine specifications and environments
  df -h
  free -h
  nproc
  cat /etc/os*
