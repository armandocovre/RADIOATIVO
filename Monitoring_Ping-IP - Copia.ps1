$ServerName = "192.168.1.1"
foreach ($Server in $ServerName)
{
if (test-Connection -ComputerName $Server -Count 2 -Quiet )

    {
write-Host "servidor $Server esta ativo e pigando" -ForegroundColor Green
    }

    else
    {
Write-Warning "servidor $Server nao esta pingando favor verificar"
    Send-MailMessage -From "monitoramento@unimedcg.com.br" -Subject "Link de Publicacao" -To "eduardo.brito@easynet.com.br" -Body "Link de Publicacao" -SmtpServer monza.unimedcg.com.br
    }
}