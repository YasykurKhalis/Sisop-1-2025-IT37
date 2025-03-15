#!/bin/bash

# Help Screen
if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$2" == "-h" ] || [ "$2" == "--help" ]; then
    echo -e "\e[33m                                   ,'\                               \e[0m"
    echo -e "\e[33m     _.----.        ____         ,'  _\   ___    ___     ____        \e[0m"
    echo -e "\e[33m _,-'       \.     |    |  /\.   \\,-'    |   \\  /   |   |    \\  |\`.  \e[0m"
    echo -e "\e[33m \\      __    \\    '-.  | /   \`.  ___    |    \\/    |   '-.   \\ |  | \e[0m"
    echo -e "\e[33m  \\.    \\ \\   |  __  |  |/    ,','_  \`.  |          | __  |    \\|  | \e[0m"
    echo -e "\e[33m    \\    \\/   /,' _\.|      ,' / / / /   |          ,' _\.|     |  | \e[0m"
    echo -e "\e[33m     \\     ,-'/  /   \\    ,'   | \\/ / ,\`.|         /  /   \\  |     | \e[0m"
    echo -e "\e[33m      \\    \\ |   \\_/  |   \-.  \\    \'  /|  |    ||   \\_/  | |\\    | \e[0m"
    echo -e "\e[33m       \\    \\ \\      /       \-.\._,-' |  |\\  /| \\      /  | |   | \e[0m"
    echo -e "\e[33m        \\    \\ \.__,'|  |\-._    \|      |__| \\/ |  \.,'|  | |   | \e[0m"
    echo -e "\e[33m         \\.-'       ||    \`-. |              '-.|     '-.| |   | \e[0m"
    echo -e "\e[33m                                 \`'                            '-._| \e[0m"
    echo -e "\e[90m---------------------------------------------------------"    
    echo -e "\e[31mType: ./pokemon_analysis.sh pokemon_usage.csv\e[0m [\e[32moptions\e[0m]"
    echo -e "\e[32mOptions\e[0m:"
    echo "  --info               Show summary of the data"
    echo "  --sort <column>      Sort the data by specified column"
    echo "  --grep <name>        Search for a specific Pokemon by name and sorted by Usage(descending)"
    echo "  --filter <type>      Filter Pokemon by type and sorted by Usage(descending)"
    echo "  -h, --help           Show this help screen"
    echo -e "\e[90m---------------------------------------------------------"
    exit 0
fi

# Main Script Logic

if [ "$2" == "--info" ]; then
    echo ""
    echo "Summary of $1"
    highest_usage=$(awk -F, 'NR>1 {print $1, $2}' $1 | sort -k2 -nr | head -n 1)
    highest_raw=$(awk -F, 'NR>1 {print $1, $3}' $1 | sort -k3 -nr | head -n 1)
    echo -e "Highest Adjusted Usage: \e[32m$highest_usage\e[0m"
    echo -e "Highest Raw Usage: \e[32m$highest_raw"
fi

# Column Maker
function display_table {
    awk -F, 'BEGIN { printf "%-20s %-10s %-8s %-10s %-10s %-4s %-4s %-4s %-6s %-6s %-6s\n", "Pokemon", "Usage%", "RawUsage", "Type1", "Type2", "HP", "Atk", "Def", "SpAtk", "SpDef", "Speed" } {printf "%-20s %-10s %-8s %-10s %-10s %-4s %-4s %-4s %-6s %-6s %-6s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11 }'
}

# Sorting
if [ "$2" == "--sort" ]; then
  if [ -z "$3" ]; then
    echo " "
    echo -e "\e[31mError: Argumemt is empty."
    exit 1
  fi
    echo " "
    column=$3
    case $column in
        "usage") sort_column=2 ;;
        "rawusage") sort_column=3 ;;
        "name") sort_column=1 ;;
        "Pokemon") sort_column=1 ;;
        "pokemon") sort_column=1 ;;
        "POKEMON") sort_column=1 ;;
        "Name") sort_column=1 ;;
        "NAME") sort_column=1 ;;
        "hp") sort_column=4 ;;
        "HP") sort_column=4 ;;
        "Hp") sort_column=4 ;;
        "atk") sort_column=5 ;;
        "Atk") sort_column=5 ;;
        "ATK") sort_column=5 ;;
        "def") sort_column=6 ;;
        "spatk") sort_column=7 ;;
        "spdef") sort_column=8 ;;
        "speed") sort_column=9 ;;
        *) echo -e "\e[31mColumn \e[36m$3 \e[31minvalid!"; exit 1 ;;
    esac
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    if [ "$sort_column" -eq 1 ]; then
    awk -F, 'NR>1' "$1" | sort -t, -k$sort_column
    else
    awk -F, 'NR>1' "$1" | sort -t, -k$sort_column -nr  
 fi
fi

# Grep <name>
if [ "$2" == "--grep" ]; then
  if [ -z "$3" ]; then
    echo " "
    echo -e "\e[31mError: Argument is empty."
    exit 1
  fi
    name=$3
    echo " "
    if awk -F, -v nama="$name" '$1 ~ nama' "$1" | grep -q .; then
       awk -F, -v nama="$name" '$1 ~ nama' "$1" | sort -t, -k2 -nr
    else
       echo -e "\e[31mName \e[36m$3 \e[31mnot found" 
  fi
fi

# Filter <type>
if [ "$2" == "--filter" ]; then
  if [ -z "$3" ]; then
    echo " "
    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    echo -e "\e[31mError: Argument is empty."
    exit 1
  fi
    type=$3
    echo ""
    if awk -F, -v tipe="$type" '$4 == tipe || $5 == tipe' "$1" | grep -q .; then
       echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
       awk -F, -v tipe="$type" '($4 == tipe || $5 == tipe)' "$1" | sort -t, -k2 -nr
    else
       echo -e "\e[31mType \e[36m$3 \e[31mnot found"
    fi
fi

