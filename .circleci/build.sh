#!/bin/bash
# Functions
function tginit() {
  export telegramsh="telegram/telegram"
}

function tgsay() {
  $telegramsh -t $token -c $mchat_id -H \
      "$(
          for POST in "${@}"; do
              echo "${POST}"
          done
      )"
}

function abort() {
    tgsay "$1"
    exit 1
}

function tgsendzip() {
  dev=$(cat lastdevice)
  mv out/target/product/*/SHRP*.zip telegram/ || export uploadimg=1
  if [ "$uploadimg" == "1" ]; then
    mv out/target/product/*/recovery.img telegram/
    cd telegram/
    ./telegram -t $token -c $mchat_id -f "recovery.img" "$dev build finished!"
    rm -rf recovery.img
    export uploadimg=0
  else
    cd telegram/
    ZIP=$(ls SHRP*.zip)
    ./telegram -t $token -c $mchat_id -f "$ZIP" "$dev build finished!"
    rm -rf "$ZIP"
    cd ..
  fi
}

# Run it by default
tginit
