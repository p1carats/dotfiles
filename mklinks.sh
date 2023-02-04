#!/bin/sh

src_dir=$(dirname "$(readlink -f "$0")")
dist_dir=$HOME/.config

for folder in "$src_dir"/*/; do
    ln -s "$folder" "$dist_dir"
done
