#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -p "Masukkan username: " username
read -s -p "Masukkan password: " password
echo

if ! [[ "$email" =~ ^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$ ]]; then
    echo "Format email invalid"
    exit 1
fi

if grep -q "^$email," "$path"; then
    echo "Email sudah terdaftar"
    exit 1
fi

if [[ ${#password} -lt 8 || ! "$password" =~ [a-z] || ! "$password" =~ [A-Z] || ! "$password" =~ [0-9] ]]; then
    echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
    exit 1
fi

salt="s1s0pG4c0r"
hashed_password=$(echo "$salt$password" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_password" >> "$path"
echo "Registrasi berhasil"
exit 0
