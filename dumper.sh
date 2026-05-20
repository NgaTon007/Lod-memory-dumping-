#!/usr/bin/env bash

# ==========================================================
#        LORD OF DARKNESS - ELITE MEMORY DUMPER
# ==========================================================
#  Advanced Runtime Memory Extraction Framework
#  Dynamic Threat Intelligence Scanner
#  Author : Lod of darkness 
#  UI/UX Redesign : Nga ton (Red Edition)
# ==========================================================

# ================= COLORS =================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# UI

line() {
printf "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

center() {
printf "%*s\n" $(((${#1}+$(tput cols))/2)) "$1"
}

#  BANNER 

clear

echo -e "${RED}"
echo " ██╗      ██████╗ ██████╗ ██████╗ "
echo " ██║     ██╔═══██╗██╔══██╗██╔══██╗"
echo " ██║     ██║   ██║██████╔╝██║  ██║"
echo " ██║     ██║   ██║██╔══██╗██║  ██║"
echo " ███████╗╚██████╔╝██║  ██║██████╔╝"
echo " ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ "
echo "   ██████╗ ███████╗"
echo "  ██╔═══██╗██╔════╝"
echo "  ██║   ██║█████╗  "
echo "  ██║   ██║██╔══╝  "
echo "  ╚██████╔╝██║     "
echo "   ╚═════╝ ╚═╝     "
echo " ██████╗  █████╗ ██████╗ ██╗  ██╗███╗   ██╗███████╗███████╗███████╗"
echo " ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝████╗  ██║██╔════╝██╔════╝██╔════╝"
echo " ██║  ██║███████║██████╔╝█████═╝ ██╔██╗ ██║█████╗  ███████╗███████╗"
echo " ██║  ██║██╔══██║██╔══██╗██╔═██╗ ██║╚██╗██║██╔══╝  ╚════██║╚════██║"
echo " ██████╔╝██║  ██║██║  ██║██║ ╚██╗██║ ╚████║███████╗███████║███████║"
echo " ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝"
echo -e "${NC}"

echo
echo -e "${RED}${BOLD}                ▓▒░ DARK MEMORY EXTRACTION ENGINE ░▒▓${NC}"
echo
line
echo -e "${CYAN}              [ Dynamic Runtime RAM Extraction ]${NC}"
echo -e "${YELLOW}                [ Threat Intelligence Engine ]${NC}"
echo -e "${GREEN}                    [ Termux / Linux ]${NC}"
line
echo

#DEPENDENCIES

if ! command -v gdb &> /dev/null; then
echo -e "${YELLOW}[!] Installing GDB...${NC}"
pkg install gdb -y
fi

echo -e "${GREEN}[✓] Dependencies Verified${NC}"
echo

#  INPUT 

echo -e "${CYAN}┌──[ ENTER TARGET FILE NAME ]${NC}"
read -p "└─➤ " TARGET_NAME

if [ -z "$TARGET_NAME" ]; then
echo -e "${RED}[X] Empty target name!${NC}"
exit 1
fi

echo
echo -e "${CYAN}[•] Searching storage for target...${NC}"


mapfile -t FOUND_FILES < <(find ~ /sdcard -type f -name "$TARGET_NAME" 2>/dev/null)

TARGET_PATH=""

if [ ${#FOUND_FILES[@]} -eq 0 ]; then

echo
echo -e "${RED}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${NC}"
echo -e "${RED}┃                  TARGET NOT FOUND                          ┃${NC}"
echo -e "${RED}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"

exit 1

elif [ ${#FOUND_FILES[@]} -gt 1 ]; then

echo
echo -e "${YELLOW}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${NC}"
echo -e "${YELLOW}┃                  MULTIPLE FILES FOUND                      ┃${NC}"
echo -e "${YELLOW}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"

for i in "${!FOUND_FILES[@]}"; do
echo -e "${GREEN}[$((i+1))]${NC} ${FOUND_FILES[$i]}"
done

while true; do

echo
read -p "Select file number: " CHOICE

if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le ${#FOUND_FILES[@]} ]; then
TARGET_PATH="${FOUND_FILES[$((CHOICE-1))]}"
break
else
echo -e "${RED}[X] Invalid selection${NC}"
fi

done

else

TARGET_PATH="${FOUND_FILES[0]}"

fi

echo
echo -e "${GREEN}[✓] Target Locked:${NC}"
echo -e "${WHITE}$TARGET_PATH${NC}"
echo

chmod +x "$TARGET_PATH"

#  MEMORY DUMP 

echo -e "${CYAN}[•] Launching Runtime Memory Extraction Engine...${NC}"

cat << EOF > .gdb_commands
catch syscall 203
run
generate-core-file ram_dump.core
quit
y
EOF

gdb -batch -x .gdb_commands --args "$TARGET_PATH" &> /dev/null

rm .gdb_commands

if [ ! -f "ram_dump.core" ]; then

echo
echo -e "${RED}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${NC}"
echo -e "${RED}┃                MEMORY DUMP FAILED                          ┃${NC}"
echo -e "${RED}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"

exit 1
fi

echo
echo -e "${GREEN}[✓] Runtime Memory Dump Successful${NC}"

# ANALYSIS 

echo
echo -e "${CYAN}[•] Scanning RAM Payload...${NC}"

# CRITICAL

TOKENS=$(strings ram_dump.core | grep -Eo "[0-9]{8,10}:[A-Za-z0-9_-]{35}")
WEBHOOKS=$(strings ram_dump.core | grep -iE "discord(app)?\.com/api/webhooks")
SECRETS=$(strings ram_dump.core | grep -iE "api[_-]?key|secret|token")

# SUSPICIOUS

URLS=$(strings ram_dump.core | grep -iE "http://|https://")
IPS=$(strings ram_dump.core | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -u)
BOTS=$(strings ram_dump.core | grep -iE "telegram|bot")

# CLEAN 

SAFE=$(strings ram_dump.core | grep -iE "google|android|github" | head)

echo


if [ ! -z "$TOKENS" ] || [ ! -z "$WEBHOOKS" ] || [ ! -z "$SECRETS" ]; then

echo -e "${RED}"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃                 CRITICAL THREATS DETECTED                  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

if [ ! -z "$TOKENS" ]; then
echo -e "${RED}${BOLD}[ TELEGRAM BOT TOKENS ]${NC}"

while read -r line; do
echo -e "${WHITE}➤${NC} ${RED}$line${NC}"
done <<< "$TOKENS"

echo
fi

if [ ! -z "$WEBHOOKS" ]; then
echo -e "${RED}${BOLD}[ DISCORD WEBHOOKS ]${NC}"

while read -r line; do
echo -e "${WHITE}➤${NC} ${RED}$line${NC}"
done <<< "$WEBHOOKS"

echo
fi

if [ ! -z "$SECRETS" ]; then
echo -e "${RED}${BOLD}[ API SECRETS / TOKENS ]${NC}"

while read -r line; do
trimmed=$(echo "$line" | cut -c1-80)
echo -e "${WHITE}➤${NC} ${RED}$trimmed${NC}"
done <<< "$SECRETS"

echo
fi

fi

# YELLOW BOX - SUSPICIOUS

if [ ! -z "$URLS" ] || [ ! -z "$IPS" ] || [ ! -z "$BOTS" ]; then

echo -e "${YELLOW}"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃                SUSPICIOUS INDICATORS FOUND                 ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

if [ ! -z "$URLS" ]; then

echo -e "${YELLOW}${BOLD}[ URLS / HOSTS ]${NC}"

while read -r line; do
trimmed=$(echo "$line" | cut -c1-90)
echo -e "${WHITE}➤${NC} ${YELLOW}$trimmed${NC}"
done <<< "$URLS"

echo
fi

if [ ! -z "$IPS" ]; then

echo -e "${YELLOW}${BOLD}[ IP ADDRESSES ]${NC}"

while read -r line; do
echo -e "${WHITE}➤${NC} ${YELLOW}$line${NC}"
done <<< "$IPS"

echo
fi

if [ ! -z "$BOTS" ]; then

echo -e "${YELLOW}${BOLD}[ BOT INDICATORS ]${NC}"

while read -r line; do
trimmed=$(echo "$line" | cut -c1-80)
echo -e "${WHITE}➤${NC} ${YELLOW}$trimmed${NC}"
done <<< "$BOTS"

echo
fi

fi

# GREEN BOX - SAFE
if [ ! -z "$SAFE" ]; then

echo -e "${GREEN}"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃                   SAFE / NORMAL DATA                       ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

while read -r line; do
trimmed=$(echo "$line" | cut -c1-90)
echo -e "${WHITE}➤${NC} ${GREEN}$trimmed${NC}"
done <<< "$SAFE"

echo
fi

# FINAL VERDICT

line

if [ ! -z "$TOKENS" ] || [ ! -z "$WEBHOOKS" ]; then

echo
echo -e "${RED}${BOLD}"
echo " ██████╗  █████╗ ███╗   ██╗██████╗ ███████╗██████╗  ██████╗ ██╗   ██╗███████╗"
echo " ██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔═══██╗██║   ██║██╔════╝"
echo " ██║  ██║███████║██╔██╗ ██║██║     █████╗  ██████╔╝██║   ██║██║   ██║███████╗"
echo " ██║  ██║██╔══██║██║╚██╗██║██║ ███╗██╔══╝  ██╔══██╗██║   ██║██║   ██║╚════██║"
echo " ██████╔╝██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║╚██████╔╝╚██████╔╝███████║"
echo " ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝"
echo -e "${NC}"

echo -e "${RED}${BOLD}[ FINAL VERDICT ] : HIGHLY DANGEROUS MEMORY PAYLOAD DETECTED${NC}"

elif [ ! -z "$URLS" ] || [ ! -z "$IPS" ]; then

echo
echo -e "${YELLOW}${BOLD}[ FINAL VERDICT ] : SUSPICIOUS MEMORY ACTIVITY DETECTED${NC}"

else

echo
echo -e "${GREEN}${BOLD}[ FINAL VERDICT ] : CLEAN / LOW RISK${NC}"

fi

line

# MOST IMPORTANT DATA

if [ ! -z "$TOKENS" ]; then

echo
echo -e "${RED}"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃                  MOST CRITICAL FINDING                     ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

while read -r line; do
echo -e "${RED}${BOLD}➤ TELEGRAM BOT TOKEN:${NC} ${WHITE}$line${NC}"
done <<< "$TOKENS"

fi

# CLEANUP 

rm -f ram_dump.core

echo
echo -e "${GREEN}[✓] Temporary files cleaned${NC}"
echo -e "${GREEN}[✓] Scan completed successfully${NC}"
echo
