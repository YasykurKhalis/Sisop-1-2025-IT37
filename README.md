# Anggota Kelompok
1. Ahmad Rabbani Fata (NRP : 5027241046)
2. Muhammad Huda Rabbani (NRP : 5027241098)
3. Yasykur Khalis Jati Maulana Yuwono (NRP : 5027241112)
# Soal 1
Download file reading_data.csv menggunakan command:
```bash
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv
```
a. Mencari jumlah buku yang dibaca Chris Hemsworth:
```bash
awk -F ',' '
{ count[$2]++ } 
END {
    if (count["Chris Hemsworth"] > 0) {
        print "Chris Hemsworth membaca", count["Chris Hemsworth"], "buku."
    } else {
        print "Chris Hemsworth tidak ditemukan dalam data."
    }
}' reading_data.csv
```
Penjelasan:

Command AWK ini digunakan untuk menghitung jumlah buku yang dibaca oleh Chris Hemsworth menggunakan pemisah(delimiter) berupa koma(,) (-F ','), Menghitung jumlah munculnya Chris Hemsworth pada kolom ke-2 (count[$2]++), dan if-statement jika Chris hemsworth membaca buku atau tidak.

Output:

![Capture](https://github.com/user-attachments/assets/74f3bde2-caa2-47a7-8f32-ef6d1f266dae)

b. Mencari rata-rata durasi membaca menggunakan Tablet:
```bash
awk -F ',' '
{
    count[$8]++;
    total[$8] = total[$8] + $6
}
END {
    if (count["Tablet"] > 0) {
        print "Rata-rata durasi membaca dengan Tablet adalah", total["Tablet"] / count["Tablet"], "menit.";
    } else {
        print "Tidak ada data membaca dengan Tablet.";
    }
}' reading_data.csv
```
Penjelasan:

Menghitung rata-rata durasi membaca menggunakan perangkat Tablet dengan membagi jumlah durasi membaca menggunakan Tablet (total[$8] = total[$8] + $6) dengan jumlah penggunaan Tablet (count[$8]++) dengan operasi matematika pembagian (total["Tablet"] / count["Tablet"]).

Output:

![Capture1](https://github.com/user-attachments/assets/62afa596-c657-4707-8a01-39b19b861c19)

c. Mencari nama dan judul buku dengan rating tertinggi:
```bash
awk -F ',' '
NR > 1 { 
    if ($7 > max_rating) { 
        max_rating = $7;
        name = $2;
        book = $3;
    } 
} 
END { 
    print "Pembaca dengan rating tertinggi:", name, "-", book, "-", max_rating;
}' reading_data.csv
```
Penjelasan:

Mencari rating tertinggi dari suatu buku dan mencocokkannya dengan nama serta judul buku yang dibaca menggunakan if-statement (if ($7 > max_rating))

Output:

![Capture2](https://github.com/user-attachments/assets/0db3f4d4-f121-40ed-95a5-4e646e68e9eb)

d. Menemukan genre yang paling sering dibaca di Asia setelah tahun 2023:
```bash
awk -F ',' 'NR > 1 && $9 == "Asia" && $5 > "2023-12-31" {genre_count[$4]++}
END {
    max_genre = ""
    max_count = 0
    for (genre in genre_count) {
        if (genre_count[genre] > max_count) {
            max_count = genre_count[genre]
            max_genre = genre
        }
    }
    print "Genre paling populer di Asia setelah 2023 adalah", max_genre, "dengan", max_count, "buku."
}' reading_data.csv
```
Penjelasan:

Mencari genre paling populer dengan melewati baris pertama karena hanya berupa penjelasan tiap kolom (NR > 1), lalu memfilter kolom ke-9 sehingga hanya Asia ($9 == "Asia"), serta memilih buku yang hanya diterbitkan setelah tahun 2023 dengan membandingkan format tanggal yang lebih baru dari tahun 2023($5 > "2023-12-31"), lalu menghitung jumlah kemunculan setiap genre (genre_count[$4]++). Menggunakan perulangan for loop untuk menentukan genre yang paling banyak muncul dan if-statement untuk memperbarui genre terpopuler.

Output:

![Capture3](https://github.com/user-attachments/assets/9d527364-3108-4eea-9234-805c76442a82)
# Soal 2
a. Buat file register.sh dan login.sh lalu ganti izin akses agar file bisa dieksekusi:
```bash
touch register.sh && touch login.sh && chmod +x register.sh && chmod +x login.sh
```
Isi file register.sh:
```bash
#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -p "Masukkan username: " username
read -s -p "Masukkan password: " password
echo

echo "$email,$username,$password" >> "$path"
echo "Registrasi berhasil"
exit 0
```
Penjelasan:

Melakukan registrasi player dengan menyimpan data ke dalam file player.csv. Pertama, command memastikan bahwa direktori data sudah ada dengan perintah mkdir -p data, lalu membuat file player.csv jika belum ada menggunakan touch "$path". Setelah itu, command mengambil tiga argumen input (email, username, dan password) dari command line, lalu menuliskannya ke dalam file player.csv dalam format CSV (email,username,password). Command menampilkan "Registrasi berhasil" jika format benar.


isi file login.sh:
```bash
#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -s -p "Masukkan password: " password

if grep -q "^$email,.*,$password$" "$path"; then
 echo "Berhasil login"
 exit 0
else
 echo "Gagal login"
 exit 1
fi
```


b. 

isi file register.sh:
```bash
#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -p "Masukkan username: " username
read -s -p "Masukkan password: " password
echo

if ! [[ "$email" =~ ^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$ ]]; then
    echo "Format email invalid"
    exit 1
fi

if [[ ${#password} -lt 8 || ! "$password" =~ [a-z] || ! "$password" =~ [A-Z] || ! "$password" =~ [0-9] ]]; then
    echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
    exit 1
fi

echo "$email,$username,$password" >> "$path"
echo "Registrasi berhasil"
exit 0
```
c.

isi file register.sh:
```bash
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

if [[ ${#password} -lt 8 || ! "$password" =~ [a-z] || ! "$password" =~ [A-Z] || ! "$password" =~ [0-9] ]]; >    echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
 echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
 exit 1
fi

echo "$email,$username,$password" >> "$path"
echo "Registrasi berhasil"
exit 0
```
d.
isi file register.sh:
```bash
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

if [[ ${#password} -lt 8 || ! "$password" =~ [a-z] || ! "$password" =~ [A-Z] || ! "$password" =~ [0-9] ]]; >    echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
 echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
 exit 1
fi

hashed_password=$(echo "$password" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_password" >> "$path"
echo "Registrasi berhasil"
exit 0
```

isi file login.sh:
```bash
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
```
# Soal 3
# Soal 4

