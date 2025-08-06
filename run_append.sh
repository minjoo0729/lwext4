#!/usr/bin/env bash

cd ~/lwext4 || { echo "run from ~/lwext4"; exit 1; }

sizes=(1024 4096 16384 65536 1048576)      # 1K 4K 16K 64K 1M
rm ./results_append/*
rm ./append_*

for sz in "${sizes[@]}"; do
    img="append_${sz}.ext4"
    cp img_ori.ext4 "$img"                    

    ./build_generic/fs_test/lwext4-generic \
          -i "$img" -s "$sz" -c 1 -d 0 | tee "results_append/append_${sz}.log"

    echo "✔ ${sz}B append → results_append/append_${sz}.log"
done