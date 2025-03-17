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
Penjelasan command:
Command AWK ini digunakan untuk menghitung jumlah buku yang dibaca oleh Chris Hemsworth menggunakan pemisah(delimiter) berupa koma(,) (-F ','), Menghitung jumlah munculnya Chris Hemsworth pada kolom ke-2 (count[$2]++), dan if-statement jika Chris hemsworth membaca buku atau tidak.

Output:
![Capture](https://github.com/user-attachments/assets/74f3bde2-caa2-47a7-8f32-ef6d1f266dae)
![Capture1](https://github.com/user-attachments/assets/62afa596-c657-4707-8a01-39b19b861c19)
![Capture2](https://github.com/user-attachments/assets/0db3f4d4-f121-40ed-95a5-4e646e68e9eb)
![Capture3](https://github.com/user-attachments/assets/9d527364-3108-4eea-9234-805c76442a82)
# Soal 2
# Soal 3
# Soal 4

