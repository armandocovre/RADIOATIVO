<#
    DESCRIÇÃO
		01. REALIZA FILTRO PELO ID EVENT ESPECÍFICO (4740)
		02. NA DATA DE HOJE
		03. IRÁ LIMITAR NOS ÚLTIMOS 20000 LOG DE EVENTO
	
	AUTOR
		ARMANDO VAZ DE MOURA COVRE
		
	CONTATO
		ARMANDOMOURACOVRE@GMAIL.COM
	
	DATA DO DESENVOLVIMENTO
		10 DEZEMBRO 2018
	
	RESULTADO
		DATA E HORARIO GERADO PELO LOG DE EVENTO, USUÁRIO E COMPUTADOR
	
	DADOS PARA INFORMAR NO CONF DO ZABBIX
		UserParameter=USER_BLOCK_SEM_INTERVENCAO[*], %systemroot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -executionpolicy bypass -File C:\Zabbix\Scripts\USUARIO-BLOQUEADO-SEM-INTERVENCAO.ps1 $1
#>

############ INÍCIO DO SCRIPT ############
Param(
  [string]$select
)

# DATA E HORARIO GERADO PELO LOG DE EVENTO
if ( $select -eq 'DATA-HORARIO' )
{
$date = (get-date).adddays(-1)
Get-EventLog -LogName "Security" -After $date -Before $date -Newest 20000 | Where-Object {$_.eventID -eq 4740} | Select-Object Timegenerated  |Format-Table -HideTableHeaders
}

# USUÁRIO "BLOQUEADO"
if ( $select -eq 'NAME-BLOCK' )
{
$date = (get-date).adddays(-1)
Get-EventLog -LogName "Security" -After $date -Before $date -Newest 20000 | Where-Object {$_.eventID -eq 4740} | Select-Object @{Name='UserName';e={$_.ReplacementStrings[0]}}  |Format-Table -HideTableHeaders
}

# COMPUTADOR REMOTO QUE "BLOQUEOU"
if ( $select -eq 'COMPUTER-BLOCK' )
{
$date = (get-date).adddays(-1)
Get-EventLog -LogName "Security" -After $date -Before $date -Newest 20000 | Where-Object {$_.eventID -eq 4740} | Select-Object @{n='Computer';e={$_.ReplacementStrings[1]}}  |Format-Table -HideTableHeaders
}

# COMPUTADOR REMOTO QUE "BLOQUEOU"
if ( $select -eq 'TABLE-ALL' )
{
$date = (get-date).adddays(-1)
Get-EventLog -LogName "Security" -After $date -Before $date -Newest 20000 | Where-Object {$_.eventID -eq 4740} | Select-Object Timegenerated,@{Name='UserName';e={$_.ReplacementStrings[0]}},@{n='Computer';e={$_.ReplacementStrings[1]}}  |Format-Table -HideTableHeaders
}
############ FIM DO SCRIPT ############