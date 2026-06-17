@echo off
setlocal
cd /d "%~dp0"
start "" http://127.0.0.1:4173/chatvault-local.html
python -m http.server 4173 --directory "%~dp0"
