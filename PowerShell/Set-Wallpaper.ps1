<#
	.DESCRIPTION
        ALTERAR PAPEL DE PAREDE DA ÁREA DE TRABALHO VIA AZUREAD/ENDPOINT

	.PARAMETER
        COLOCAR WALLPAPER NO SERVIDOR WEB
        PARA REALIZAR DOWNLOAD NO PC CLIENTE
		
	.OUTPUTS
		IMPOE WALLPAPER NOS UTILIZADORES

	.NOTES
		Version:        1.0
		Author:         ARMANDO COVRE - ARMANDOMOURACOVRE@GMAIL.COM
		Creation Date:  JULHO - 2021
#>

#---------------------------------------------------------[START SCRIPT]--------------------------------------------------------

$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"


$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"

$StatusValue = "1"


$url = "https://noc.company.com/wallpaper.png"
$DesktopImageValue = "C:\Windows\wallpaper.png"
$directory = "C:\Windows\"


If ((Test-Path -Path $directory) -eq $false)
{
	New-Item -Path $directory -ItemType directory
}

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $DesktopImageValue)



if (!(Test-Path $RegKeyPath))
{
	Write-Host "Creating registry path $($RegKeyPath)."
	New-Item -Path $RegKeyPath -Force | Out-Null
}


New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null

RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True

#---------------------------------------------------------[END SCRIPT]--------------------------------------------------------