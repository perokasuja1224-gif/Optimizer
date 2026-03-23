#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/optimizer.log"

verde='\033[1;32m'
reset='\033[0m'

banner() {
clear
echo -e "${verde}"
figlet "OPTIMIZER"
echo "================================="
echo "     SYSTEM CONTROL PANEL"
echo "================================="
echo -e "${reset}"
}

notificar() {
termux-notification --title "Optimizer" --content "$1" 2>/dev/null
}

limpar_cache() {
echo "[`date`] Limpando cache..." >> $LOG
rm -rf /sdcard/Download/*.tmp 2>/dev/null
rm -rf /sdcard/*.log 2>/dev/null
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null
echo -e "${verde}✔ Cache limpo!${reset}"
sleep 1
}

monitor() {
while true
do
banner
echo -e "${verde}STATUS EM TEMPO REAL${reset}"
echo ""

RAM=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
echo "RAM: $RAM%"

echo ""
top -n 1 | head -5

echo ""
echo "[Q] Voltar"

read -t 2 -n 1 tecla
if [[ $tecla == "q" || $tecla == "Q" ]]; then
break
fi
done
}

apps_pesados() {
banner
echo -e "${verde}APPS PESADOS${reset}"
top -n 1 | head -10
sleep 3
}

modo_turbo() {
banner
echo -e "${verde}MODO TURBO ATIVADO${reset}"
limpar_cache
notificar "Modo TURBO ativado!"
sleep 2
}

modo_inteligente() {
banner
echo -e "${verde}MODO INTELIGENTE${reset}"
echo "Pressione Q para sair"

while true
do

RAM=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

echo "Uso de RAM: $RAM%"

if [ "$RAM" -ge 80 ]; then
echo "Otimizando..."

rm -rf /sdcard/Download/*.tmp 2>/dev/null
rm -rf /sdcard/*.log 2>/dev/null
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null

am kill-all 2>/dev/null

notificar "Otimização automática!"
fi

read -t 3 -n 1 tecla
if [[ $tecla == "q" || $tecla == "Q" ]]; then
break
fi

done
}

ver_logs() {
banner
cat $LOG
echo ""
read -p "Enter pra voltar"
}

menu() {
while true
do
banner

echo -e "${verde}1${reset} - Monitor"
echo -e "${verde}2${reset} - Limpar cache"
echo -e "${verde}3${reset} - Apps pesados"
echo -e "${verde}4${reset} - Modo TURBO"
echo -e "${verde}5${reset} - Modo inteligente"
echo -e "${verde}6${reset} - Ver logs"
echo -e "${verde}7${reset} - Sair"

echo ""
read -p ">> " op

case $op in
1) monitor ;;
2) limpar_cache ;;
3) apps_pesados ;;
4) modo_turbo ;;
5) modo_inteligente ;;
6) ver_logs ;;
7) exit ;;
*) echo "Erro"; sleep 1 ;;
esac

done
}

menu#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/optimizer.log"
AUTO_CLEAN_PID=""

notificar() {
termux-notification --title "Optimizer" --content "$1" 2>/dev/null
}

limpar_cache() {
echo "[`date`] Limpando cache..." >> $LOG
rm -rf /sdcard/Download/*.tmp 2>/dev/null
rm -rf /sdcard/*.log 2>/dev/null
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null
sleep 1
}

monitor() {
while true
do
clear
echo "===== STATUS ====="
free -h
echo ""
top -n 1 | head -10
echo ""
echo "CTRL+C pra voltar"
sleep 2
done
}

apps_pesados() {
clear
top -n 1 | head -10
sleep 3
}

modo_turbo() {
clear
echo "Modo TURBO..."
limpar_cache
notificar "Modo TURBO ativado!"
sleep 2
}

auto_clean() {
if [ ! -z "$AUTO_CLEAN_PID" ]; then
echo "Já está rodando!"
sleep 2
return
fi

(
while true
do
sleep 1800
limpar_cache
done
) &

AUTO_CLEAN_PID=$!
echo "Auto limpeza ativada!"
sleep 2
}

modo_inteligente() {

LIMITE=80

echo "Modo inteligente ativado..."

while true
do

USO=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

echo "Uso atual: $USO%"

if [ "$USO" -ge "$LIMITE" ]; then
echo "RAM alta! Otimizando..."

rm -rf /sdcard/Download/*.tmp 2>/dev/null
rm -rf /sdcard/*.log 2>/dev/null
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null

am kill-all 2>/dev/null

notificar "Otimização automática executada!"
sleep 5
fi

sleep 60
done
}

ver_logs() {
clear
cat $LOG
echo ""
read -p "Enter pra voltar"
}

menu() {
while true
do
clear
echo "===== OPTIMIZER ====="
echo "1 - Monitor"
echo "2 - Limpar cache"
echo "3 - Apps pesados"
echo "4 - Modo TURBO"
echo "5 - Auto limpeza (30min)"
echo "6 - Ver logs"
echo "7 - Modo inteligente"
echo "8 - Sair"

read -p "Escolha: " op

case $op in
1) monitor ;;
2) limpar_cache ;;
3) apps_pesados ;;
4) modo_turbo ;;
5) auto_clean ;;
6) ver_logs ;;
7) modo_inteligente ;;
8) exit ;;
*) echo "Opção inválida"; sleep 1 ;;
esac

done
}

menu
