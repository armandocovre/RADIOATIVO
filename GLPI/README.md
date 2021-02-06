## Windows large installation

### É um script VBS usado para:

Download do Instalador do Fusion Inventory para Windows
Remoção do OCS Inventory Agent
Realiza instalação ou upgrade do Fusion Inventory


## Deverá alterar na linha 105, alterar "EMPRESA" e informar URL do GLPI/Fusion Inventory
  SetupOptions = "/acceptlicense /add-firewall-exception /installtasks=full /runnow /execmode=Service /tag=EMPRESA /server='http://noc.domain.pt/plugins/fusioninventory/' /S"
