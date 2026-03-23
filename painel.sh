#!/data/data/com.termux/files/usr/bin/bash

while true
do
clear
echo "=============================="
echo "   PAINEL DE OTIMIZAÇÃO 🔧"
echo "=============================="
echo "1 - Limpar cache"
echo "2 - Ver uso de memória"
echo "3 - Limpar downloads .tmp"
echo "4 - Sair"
echo "=============================="
read -p "Escolha uma opção: " opcao

case $opcao in

1)
echo "Limpando cache..."
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null
echo "Concluído!"
sleep 2
;;

2)
echo "Uso de memória:"
free -h
sleep 3
;;

3)
echo "Limpando arquivos temporários..."
rm -rf /sdcard/Download/*.tmp
echo "Concluído!"
sleep 2
;;

4)
exit
;;

*)
echo "Opção inválida!"
sleep 2
;;

esac
done
