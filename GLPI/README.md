## Instalar FusionInventory via Endpoint - Microsoft 365

### Script VBS irá fazer:
* Download do Instalador do Fusion Inventory para Windows
* Remoção do OCS Inventory Agent
* Realiza instalação ou upgrade do Fusion Inventory



### FUSION INVENTORY + GLPI
Acesse no site oficial do Fusion Inventory e copie o script vbs (1.5 Large Installations)
> https://fusioninventory.org/documentation/agent/installation/windows/

> ALTERAR NA LINHA 68 E 105
> LINHA 68 -> Inorme versão para ser instalado.
> LINHA 105 ->  ALTERAR "EMPRESA" NO TAG E URL DO GLPI

Save o script vbs e disponibilize na URL publico com permissão para download


### PowerShell - Endpoint - Microsoft 365
Copie o script e disponibilize via script no Endpoint - Microsoft 365
