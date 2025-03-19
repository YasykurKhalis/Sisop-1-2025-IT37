#!/bin/bash

# Menampilkan Summary Data
if [[ "$2" == "--info" || "$2" == "-i" ]]
then
  echo " "
  echo "Summary of the data"
  HighestUsage=$(awk -F, 'NR>1 {print $1, $2}' $1 | sort -k2 -nr | head -n 1)
  HighestRawUsage=$(awk -F, 'NR>1 {print $1, $3}' $1 | sort -k3 -nr | head -n 1)
  echo "Highest Adjusted Usage: $HighestUsage"
  echo "Highest Raw Usage: $HighestRawUsage"

# Mengurutkan Pokemon
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

# Validasi Flag
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
