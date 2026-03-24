#!/bin/bash

clear
echo "=================================="
echo "   INSTALLER OPTIMIZER 🔥"
echo "=================================="

pkg update -y && pkg upgrade -y
pkg install -y bash

chmod +x *.sh

echo ""
echo "Iniciando..."
sleep 2

bash optimizer.sh
