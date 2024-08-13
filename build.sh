#!/bin/bash

# 檢查 Python 虛擬環境是否存在
if [ ! -d "venv" ]; then
    echo "虛擬環境不存在，正在創建..."
    python3 -m venv venv
fi

# 啟動虛擬環境
echo "啟動虛擬環境..."
source venv/bin/activate

# 安裝所需的 Python 套件
echo "安裝依賴套件..."
pip install --upgrade pip
pip install -r requirements.txt

# 設定環境變數（可選）
echo "載入 .env 檔案..."
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# 運行應用程式
echo "啟動應用程式..."
python llm_line_bot/app.py
