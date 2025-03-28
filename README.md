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
Penjelasan:

Sama seperti tadi, cek apabila directory data dan file player.csv sudah ada. Kemudian, command meminta input email (read -p) dan password (read -s -p, agar input password tersembunyi). Setelah itu, command mencari kombinasi email dan password dalam file CSV menggunakan grep -q "^$email,.*,$password$" "$path". Jika ditemukan, login dianggap berhasil dan menampilkan "Berhasil login" dengan kode keluar 0; jika tidak, login gagal dan keluar dengan kode 1.

b. Tambahkan pada command agar format email yang dimasukkan benar dan password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka:

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
Penjelasan:

Menambahkan if-statement untuk mengecek apakah format email sudah benar. Jika belum maka akan meng-echo "Format email invalid" dan keluar dari script (exit 1)

c. Menjadikan sistem register agar tidak menambahkan email yang sudah ada pada data:

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
Penjelasan:

Menambahkan if-statement untuk meng-grep format email apakah sudah ada pada file player.csv atau belum.

d. Meng-hash password agar tidak gampang dilihat:

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

if [[ ${#password} -lt 8 || ! "$password" =~ [a-z] || ! "$password" =~ [A-Z] || ! "$password" =~ [0-9] ]]; then
    echo "Password minimal 8 karakter, 1 huruf kecil, 1 huruf besar, dan 1 angka"
    exit 1
fi

salt="s1s0pG4c0r"
hashed_password=$(echo "$salt$password" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_password" >> "$path"
echo "Registrasi berhasil"
exit 0
```
Penjelasan:

Meng-hash password agar tidak mudah diketahui dengan algoritma hashing sha256sum dan static salt "s1s0pG4c0r".

isi file login.sh:
```bash
#!/bin/bash

path="./data/player.csv"

mkdir -p data
touch "$path"

read -p "Masukkan email: " email
read -s -p "Masukkan password: " password

salt="s1s0pG4c0r"
hashed_password=$(echo "$salt$password" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$hashed_password$" "$path"; then
 echo "Berhasil login"
 exit 0
else
 echo "Gagal login"
 exit 1
fi
```
Penjelasan:

Menyesuaikan input password dengan algoritma hash dan salt yang sama dengan register agar bisa dicocokkan.

e. Membuat file yang bisa membaca persentase penggunaan CPU dan modelnya di directory scripts:
```bash
mkdir scripts && touch /scripts/core_monitor.sh && chmod +x /scripts/core_monitor.sh
```
isi file core_monitor.sh:
```bash
#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

cpu_model=$(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)

log_dir="$(dirname "$0")/../log"
log_file="$log_dir/core.log"

mkdir -p "$log_dir"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> $log_file
```
Penjelasan:

script menghitung persentase penggunaan CPU dengan mengambil nilai idle dari perintah top, mengolahnya dengan sed dan awk, lalu menguranginya dari 100%. Kemudian, script mendapatkan model CPU dari output lscpu. Selanjutnya, script menentukan lokasi log file (../log/core.log), membuat direktori jika belum ada, dan mencatat informasi penggunaan CPU (Core) dalam format waktu - penggunaan CPU - Model CPU ke dalam log file.

f. Membuat file yang bisa membaca persentase penggunaan RAM dan modelnya di directory scripts:
```bash
touch /scripts/core_monitor.sh && chmod +x /scripts/core_monitor.sh
```
isi file frag_monitor.sh:
```bash
#!/bin/bash

ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

total_ram=$(free -h | grep Mem | awk '{print $2}')
available_ram=$(free -h | grep Mem | awk '{print $7}')

log_dir="$(dirname "$0")/../log"
log_file="$log_dir/fragment.log"

mkdir -p "$log_dir"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$total_ram] - Details [Total: $total_ram, Available: $available_ram]" >> $log_file
```
Penjelasan:

Menghitung persentase penggunaan RAM dengan mengambil nilai total dan penggunaan memori (free), lalu mengolahnya dengan awk. Kemudian, script mendapatkan total RAM dan RAM yang tersedia dalam format yang lebih mudah dibaca (-h untuk human-readable). Setelah itu, script menentukan lokasi log file (../log/fragment.log), membuat direktori jika belum ada, dan mencatat informasi dalam format waktu - persentase penggunaan RAM - jumlah penggunaan RAM - detail ke dalam log file.

g. Membuat file manager.sh untuk mengatur jadwal pemantauan sistem di dalam directory scripts:
```bash
touch scripts/manager.sh && chmod +x scripts/manager.sh
```
isi file manager.sh:
```bash
#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../log"
mkdir -p "$LOG_DIR"

while true; do
    # Menu utama
    echo "========================"
    echo "1. Add CPU Monitoring"
    echo "2. Remove CPU Monitoring"
    echo "3. Add RAM Monitoring"
    echo "4. Remove RAM Monitoring"
    echo "5. View Active Jobs"
    echo "6. Exit"
    read -p "Choose an option: " choice
    echo "========================"

    case $choice in
        1)
            if crontab -l 2>/dev/null | grep -q "core_monitor.sh"; then
                echo "CPU monitoring is already active."
            else
                (crontab -l 2>/dev/null | grep -v "core_monitor.sh"; echo "* * * * * $SCRIPT_DIR/core_monitor.sh >> $LOG_DIR/core.log") | crontab -
                echo "CPU monitoring added."
            fi
            ;;
        2)
            crontab -l | grep -v "core_monitor.sh" | crontab -
            echo "CPU monitoring removed."
            ;;
        3)
            if crontab -l 2>/dev/null | grep -q "frag_monitor.sh"; then
                echo "RAM monitoring is already active."
            else
                (crontab -l 2>/dev/null | grep -v "frag_monitor.sh"; echo "* * * * * $SCRIPT_DIR/frag_monitor.sh >> $LOG_DIR/fragment.log") | crontab -
                echo "RAM monitoring added."
            fi
            ;;
        4)
            crontab -l | grep -v "frag_monitor.sh" | crontab -
            echo "RAM monitoring removed."
            ;;
        5)
            echo "Active CPU and RAM Monitoring Jobs:"
            crontab -l | grep -E "core_monitor.sh|frag_monitor.sh" || echo "No active monitoring jobs found."
            ;;
        6)
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
```
Penjelasan:

Di soal ini, saat demo dilakukan, opsi 1 dan 3 belum bisa berjalan dengan baik dan opsi 5 juga tidak menampilkan hasil yang diinginkan maka kami melakukan sedikit revisi pada bagian tersebut. Pertama, script ini memastikan bahwa directory log sudah ada jika belum maka akan membuat directory log untuk diisi hasil dari eksekusi file core_monitor.sh dan frag_monitor.sh. Lalu menampilkan pilihan untuk menambahkan (1 & 3) dan menghapus (2 & 4) pengaturan jadwal pemantauan sistem serta melihat pemantauan sistem yang aktif (5) dalam cronjob. Ketika ditambahkan script ini akan menjalankan script core_monitor.sh dan frag_monitor.sh dalam waktu yang ditentukan.

h. Membuat 2 log file yaitu core_log untuk penggunaan CPU dan fragment_log untuk penggunaan RAM di dalam directory log:

Untuk soal ini sudah kami terapkan pada soal-soal sebelumnya (e-g).

i. Membuat file terminal.sh untuk antarmuka utama yang menggabungkan semua komponen:
```bash
touch terminal.sh
```
isi terminal.sh:
```bash
#!/bin/bash

while true; do
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            ./register.sh
            ;;
        2)
            ./login.sh
            if [ $? -eq 0 ]; then
                ./scripts/manager.sh
            fi
            ;;
        3)
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
```
Penjelasan:

Isi dari script adalah perintah yang berisikan pilihan untuk register dan login. Jika user berhasil login maka ia akan mengeksekusi file manager.sh dan mendapatkan akses untuk mengatur sistem.

Output soal 2:

terminal.sh:

![Capture5](https://github.com/user-attachments/assets/e3b80139-5a56-401b-b4a8-7039e809cb8b)

manager.sh

![Capture6](https://github.com/user-attachments/assets/cacf5433-b78e-48db-b1d3-f078a612f432)

Opsi 5 (View Active Jobs) pada manager.sh:

![Capture7](https://github.com/user-attachments/assets/54daa58a-23a4-4201-931a-2648cf3869b0)

core.log:

![Capture8](https://github.com/user-attachments/assets/c42e983d-721a-40ec-bbf1-6d933029555c)

fragment.log:

![Capture9](https://github.com/user-attachments/assets/05af46c5-ac45-4e51-bd85-a7a042bbef3c)

player.csv:

![Capture10](https://github.com/user-attachments/assets/d767cfee-e8b4-4945-8fb1-ac82d5973701)

# Soal 3
Mengambil data dari API dan memperoleh JSON dari API yang digunakan di _Speak to Me_

 ```
sudo apt install curl jq -y
```
Membuat File bernama dsotm.sh dengan command berikut
```
nano dsotm.sh
```
Membersihkan terminal
```
clear
```

```
speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}
```
Penjelasan:
Curl berfungsi untuk mengambil _word of affirmation_ dari api, sedangkan jq memastikan agar hanya _word of affirmation_ saja yang ditampilkan. Sedangkan While True berfungsi untuk looping setiap (sleep 1)

Menampilkan progress bar dengan panjang tetap dan sleep acak antara 0.1 - 1 detik
```
on_the_run() {
    local progress=0
    local bar_length=50
    while [ $progress -le 100 ]; do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        local filled=$((progress * bar_length / 100))
        printf "\r[%-${bar_length}s] %d%%" $(head -c $filled < /dev/zero | tr '\0' '#') $progress
        ((progress += RANDOM % 10 + 5))
    done
    echo "\nSelesai!"
}
```
Menampilkan waktu _real-time_ yang di update setiap detik sekaligus membersihkan terminal setiap kali di update
```
time_display() {
    while true; do
        clear
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}
```

Menampilkan simbol uang seperti _cmatrix_
```
money_matrix() {
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
    while true; do
        printf "\e[2J"
        for _ in $(seq 1 20); do
            line=""
            for _ in $(seq 1 40); do
                line+="${symbols[RANDOM % ${#symbols[@]}]} "
            done
            echo "$line"
        done
        sleep 0.1
    done
}
```
Menampilkan _list process_ yang sedang berjalan dan diurutkan bedasarkan _CPU Usage_
```
brain_damage() {
    while true; do
        clear
        ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10
        sleep 1
    done
}
```
```
display_help() {
    echo "Penggunaan: ./dsotm.sh --play=\"<Track>\""
    echo "Pilihan Track:"
    echo "  Speak to Me    - Kata-kata afirmasi"
    echo "  On the Run     - Progress bar"
    echo "  Time          - Jam real-time"
    echo "  Brain Damage  - Task manager sederhana"
    echo "  Money         - Animasi simbol mata uang"
}
```
Penjelasan:
Display Help berfungsi untuk memberikan panduan kepada pengguna, sekaligus memberikan daftar track yang bisa diputar

```
if [[ "$1" == "--play="* ]]; then
    track=${1#--play=}
    case "$track" in
        "Speak to Me") speak_to_me ;; 
        "On the Run") on_the_run ;; 
        "Time") time_display ;; 
        "Brain Damage") brain_damage ;; 
        "Money") money_matrix ;; 
        *) echo "Track tidak dikenali!"; display_help;;
    esac
else
    display_help
fi
```
Penjelasan:
Untuk memastikan bahwa pengguna memasukkan input yang benar, dan akan memanggil display help jika pengguna salah memasukkan input
# Soal 4
Download file pokemon_usage.csv dengan menggunakan command :
```bash
wget "https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ&export=download" -O pokemon_usage.csv
```
Membuat script pokemon_analysis.sh dengan menggunakan command :
```bash
nano pokemon_analysis.sh
```
A. Melihat summary dari data
```bash
if [[ "$2" == "--info" || "$2" == "-i" ]]
then
  echo " "
  echo "Summary of the data"
  HighestUsage=$(awk -F, 'NR>1 {print $1, $2}' $1 | sort -k2 -nr | head -n 1)
  HighestRawUsage=$(awk -F, 'NR>1 {print $1, $3}' $1 | sort -k3 -nr | head -n 1)
  echo "Highest Adjusted Usage: $HighestUsage"
  echo "Highest Raw Usage: $HighestRawUsage"
```
Penjelasan :

Kode ini mengecek apakah argumen ke-2 sesuai, dan jika sesuai maka akan dijalan kode selanjutnya yaitu AWK untuk mengambil kolom 1 dan 2 yg berisi nama Pokemon dan juga Usage%, kemudian hasilnya di pipe untuk di sortir berdasarkan Usage% tertinggi, dna terakhir, akan diambil hasil yg paling atas. AWK diatas menggunakan "," sebagai pemisah kolom dan diberikan "NR>1" agar baris ke-1 alias baris yg berisi Nama Pokemon, Usage% , dsb tidak ikut kesortir. Kemudian hasil dari kode ini akan dimasukkan ke dalam variabel yang sudah dibuat, kemudian hasilnya pun akan di echo.

Output :

![image](https://github.com/user-attachments/assets/85b87d22-bcdb-473d-908b-f5e116ae0cf0)

B. Mengurutkan Pokemon berdasarkan data kolom
```bash
elif [[ "$2" == "--sort" || "$2" == "-s" ]]
then
  if [ -z "$3" ]
  then
    echo " "
    echo "Error: argument is empty"
    exit 1
  fi
  echo " "

  field=$3
  case $field in
    "name"|"Name"|"NAME") sortfield=1 ;;
    "usage"|"Usage"|"USAGE") sortfield=2 ;;
    "rawusage"|"Rawusage"|"RawUsage"|"RAWUSAGE") sortfield=3 ;;
    "hp"|"Hp"|"HP") sortfield=6 ;;
    "atk"|"Atk"|"ATK") sortfield=7 ;;
    "def"|"Def"|"DEF") sortfield=8 ;;
    "spatk"|"Spatk"|"SpAtk"|"SPATK") sortfield=9 ;;
    "spdef"|"Spdef"|"SpDef"|"SPDEF") sortfield=10 ;;
    "speed"|"Speed"|"SPEED") sortfield=11 ;;
    *) echo "Column invalid"; exit 1 ;;
  esac

  echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
  if [ "$sortfield" == 1 ]
  then
    awk -F, 'NR>1' $1 | sort -t, -k$sortfield
  else
    awk -F, 'NR>1' $1 | sort -t, -k$sortfield -nr
  fi
```
Penjelasan :

Kode ini mengecek apakah argumen ke-2 sesuai, dan jika sesuai maka akan dijalan kode selanjutnya yaitu switch case sebagai pilihan yang nantinya pilihan yang sesuai akan mencari berdasarkan kolom yang sesuai juga. Disini jika argumen ke-2 tidak sesuai makan akan menampilkan error. Disini ada variabel field sebagai argumen ke-3 yang menjadi penentu berdasarkan apa sortir yang dilakukan. Pada fungsi ini juga menggunakan AWK yang kurang lebih awalnya sama dengan yang awal, kemudian hasilnya akan di sortir secara _**descending**_ untuk semua angka dan secara _**alphabetical**_ untuk nama. 

Output : ( Sort Name )

![image](https://github.com/user-attachments/assets/8fa64961-8e61-45ba-86db-471a47a47317)


C. Mencari nama Pokemon tertentu
```bash
# Mencari Nama Pokemon
elif [[ "$2" == "--grep" || "$2" == "-g" ]]
then
  if [ -z "$3" ]
  then
    echo " "
    echo -e "Error: argument is empty"
    exit 1
  fi

  name=$3
  if awk -F, -v name="$name" 'tolower($1) ~ tolower(name)' $1 | grep -q .
  then
    awk -F, -v name="$name" 'tolower($1) ~ tolower(name)' $1 | sort -t, -k2 -nr
  else
    echo "Name not found"
  fi
```
Penjelasan :

Kode ini mengecek apakah argumen ke-2 sesuai, dan jika sesuai maka akan dijalan kode selanjutnya yaitu AWK untuk mencari nama Pokemon tanpa memperhatikan kapitalisasi dan hasilnya akan di pipe untuk mengecek apakah ada hasil yang sesuai, jika ditemukan maka akan di sortir persis sesuai dengan format csv. Jika nama tidak ditemukan maka akan menampilkan error dimana nama tidak ditemukan.

Output :

![image](https://github.com/user-attachments/assets/fb055c7b-10e0-429d-95d0-9c035da5e252)


D. Mencari Pokemon berdasarkan filter nama type
```bash
# Mencari Nama Pokemon Berdasarkan Filter
elif [[ "$2" == "--filter" || "$2" == "-f" ]]
then
  if [ -z "$3" ]
  then
    echo " "
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    echo "Error: argument is empty"
    exit 1
  fi

  type=$3
  if awk -F, -v type="$type" 'tolower($4) ~ tolower(type) || tolower($5) ~ tolower(type)' $1 | grep -q .
  then
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    awk -F, -v type="$type" 'tolower($4) ~ tolower(type) || tolower($5) ~ tolower(type)' $1 | sort -t, -k2 -nr
  else
    echo "Type not found"
  fi
```
Penjelasan :

Kode ini mengecek apakah argumen ke-2 sesuai, dan jika sesuai maka akan dijalan kode selanjutnya yaitu AWK untuk mencari nama Pokemon berdasarkan filter yang diinginkan sehingga di kode nya mencari di kolom ke-4 dan juga ke-5. Kode ini kurang lebih sama dengan kode diatas. Jika type tidak ditemukan maka akan menampilkan type tidak ditemukan.

Output : ( Filter Dark )

![image](https://github.com/user-attachments/assets/857885fa-860f-411c-bd48-3d7968a1f195)


E. Error Handling

Untuk error handling sudah dimasukkan di kode-kode diatas yaitu fungsi else akan menampilkan error, dan jika flagnya yang tidak sesuai maka fungsi help akan otomatis berjalan

F. Help screen yang menarik
```bash
# Help
elif [[ "$1" == "-h" || "$1" == "--help" || "$2" == "-h" || "$2" == "--help" ]]
then
  :
else
  :
fi

# Help Screen Messages
if [[ "$1" == "-h" || "$1" == "--help" || "$2" == "-h" || "$2" == "--help" || -z "$2" || ! "$2" =~ ^(--info|-i|--sort|-s|--grep|-g|--filter|-f)$ ]]
then
  echo " "
  echo -e "\e[33m                                   ,\\                               \e[0m"
  echo -e "\e[33m     _.----.        ____         ,'  _\\   ___    ___     ____        \e[0m"
  echo -e "\e[33m _,-'       \`.     |    |  /\`.   \\,-'    |   \\  /   |   |    \\  |\`.  \e[0m"
  echo -e "\e[33m \\      __    \\    '-.  | /   \`.  ___    |    \\/    |   '-.   \\ |  | \e[0m"
  echo -e "\e[33m  \\.    \\ \\   |  __  |  |/    ,','_  \`.  |          | __  |    \\|  | \e[0m"
  echo -e "\e[33m    \\    \\/   /,' _\`.|      ,' / / / /   |          ,' _\`.|     |  | \e[0m"
  echo -e "\e[33m     \\     ,-'/  /   \\    ,'   | \\/ / ,\`.|         /  /   \\  |     | \e[0m"
  echo -e "\e[33m      \\    \\ |   \\_/  |   \`-.  \\    \`'  /|  |    ||   \\_/  | |\\    | \e[0m"
  echo -e "\e[33m       \\    \\ \\      /       \`-.\`.___,-' |  |\\  /| \\      /  | |   | \e[0m"
  echo -e "\e[33m        \\    \\ \`.__,'|  |\`-._    |      |__| \\/ |  \`.__,'|  | |   | \e[0m"
  echo -e "\e[33m         \\_.-'       |__|    \`-._ |              '-.|     '-.| |   | \e[0m"
  echo -e "\e[33m                                 \`'                            '-._| \e[0m"
  echo "-----------------------------------------------------------------------------------------"
  echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv [options]"
  echo "Options:"
  echo "  -h, --help               Show this help screen messages"
  echo "  -i, --info               Show the highest adjusted and raw usage"
  echo "  -s, --sort               Sort the data by the specified column/field"
  echo "    name                   Sort by Pokemon Name"
  echo "    usage                  Sort by Adjusted Usage"
  echo "    rawusage               Sort by Raw Usage"
  echo "    hp                     Sort by HP"
  echo "    atk                    Sort by Attack"
  echo "    def                    Sort by Defense"
  echo "    spatk                  Sort by Special Attack"
  echo "    spdef                  Sort by Special Defense"
  echo "    speed                  Sort by Speed"
  echo "  -g, --grep <name>        Search for a spesific Pokemon and sorted by usage"
  echo "  -f, --filter <type>      Search for a spesific type of Pokemon and sorted by usage"
  echo  "-----------------------------------------------------------------------------------------"
  exit 0
fi
```
Penjelasan :

Kode ini mengecek apakah argumen ke-2 sesuai, dan jika sesuai maka akan ditampilkan messages screen ini. Flag yg salah juga akan menampilkan help screen ini. Pada help screen ini juga ditampilkan banyak info mengenai format command dan juga command-command yang tersedia bagi pengguna. Agar lebih menarik pada help screen ini terdapat tulisan Pokemon.

Output :

![image](https://github.com/user-attachments/assets/44605cbd-d483-4118-b3d7-2ec96d6a4269)

