#!/data/data/com.termux/files/usr/bin/bash

echo "Limpando cache..."

# Limpa cache geral (apps - limitado sem root)
rm -rf /data/data/*/cache/* 2>/dev/null

# Limpa arquivos temporários
rm -rf /sdcard/Download/*.tmp
rm -rf /sdcard/Android/data/*/cache/* 2>/dev/null

echo "Limpeza concluída!"

