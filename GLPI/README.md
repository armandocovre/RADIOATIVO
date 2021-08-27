# Instalar FusionInventory via Endpoint - Microsoft 365

## Script VBS irá fazer:
* Download do Instalador do Fusion Inventory para Windows
* Remoção do OCS Inventory Agent
* Realiza instalação ou upgrade do Fusion Inventory


## FUSION INVENTORY + GLPI
Acesse no site oficial do Fusion Inventory e copie o script vbs (1.5 Large Installations). Save o script vbs e disponibilize na URL publico com permissão para download.
> https://fusioninventory.org/documentation/agent/installation/windows/

ALTERAR 2 LINHAS:
* LINHA 68 -> Informe versão para ser instalado.
* LINHA 105 ->  ALTERAR "EMPRESA" NO TAG E URL DO GLPI


## PowerShell - Endpoint - Microsoft 365
Copie o script e disponibilize via script no Endpoint - Microsoft 365
* Script PowerShell irá descarregar e instalar o fusioninventory.