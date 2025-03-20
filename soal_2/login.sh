#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -s -p "Masukkan password: " password

hashed_password=$(echo "$password" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$hashed_password$" "$path"; then
 echo "Berhasil login"
 exit 0
else
 echo "Gagal login"
 exit 1
fi
