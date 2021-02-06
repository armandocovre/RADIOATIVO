@ECHO off
cls
cd "\Program Files (x86)\VMware\VMware Workstation\"
vmrun -T ws start "C:\Users\Armando Moura Covre\Documents\Virtual Machines\ZBX-Grafana\ZBX-Grafana.vmx" nogui
cls
echo .
echo .
echo .
echo Executado o START da maquina virtual Zabbix e Grafana
timeout 10 /NOBREAK > NUL
cls

echo .
echo .
echo Aguarde que ira abrir o navegador em 10 segundos
ping -n 10 192.168.1.124 > nul
start firefox.exe "http://192.168.1.124:3000"