<#
Version: 1.0
Author: Armando Covre (armandomouracovre@gmail.com)
Script: InstallFusionInventoryGLPI.ps1
Description:
Download e instalação do agent para comunicar com glpi
Release notes:
Adicionar no Intunes para forçar a instalação em todos os dispositivos join com azuread
#>
(New-Object System.Net.WebClient).DownloadFile("https://ticket.company.com/download/agent-glpi.vbs","agent-glpi.vbs");(New-Object -com Shell.Application).ShellExecute("agent-glpi.vbs");