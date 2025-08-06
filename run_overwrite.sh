#!/usr/bin/env bash
# run_overwrite.sh  –  Task-1 i-2(Sequential overwrite) 자동 실행
#   준비: base.ext4 는 1GiB, 4 KiB 블록, 저널링 off 로 이미 포맷돼 있어야 함
#         (예: dd if=/dev/zero of=base.ext4 bs=1M count=1024 && lwext4-mkfs -b 4096 -j 0 base.ext4)

set -e
cd ~/lwext4 || { echo "~/lwext4 디렉터리에서 실행하세요"; exit 1; }

sizes=(1024 4096 16384 65536 1048576)   # 1K 4K 16K 64K 1M
mkdir -p results_overwrite
rm -f overwrite_*.ext4 results_overwrite/*

for sz in "${sizes[@]}"; do
    img="overwrite_${sz}.ext4"
    cp img_ori.ext4 "$img"                                  

    ./build_generic/fs_test/lwext4-generic \
        -i "$img" -s "$sz" -c 1 -d 0 | tee "results_overwrite/overwrite_${sz}.log"

    echo "✔ ${sz}B overwrite → results_overwrite/overwrite_${sz}.log"
done
