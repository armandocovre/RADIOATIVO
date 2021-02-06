$ServerName = "177.67.62.1","177.67.62.2","177.67.62.3","177.67.62.4","177.67.62.5","177.67.62.10","177.67.62.11","177.67.62.13","177.67.62.19","177.67.62.30","177.67.62.62","177.67.62.63","177.67.62.64","177.67.62.65","177.67.62.66","177.67.62.67","177.67.62.6","177.67.62.68","177.67.62.69","172.16.103.30","177.67.62.70","177.67.62.71","177.67.62.72","177.67.62.75","177.67.62.76","177.67.62.80","172.16.103.13","177.67.62.81","177.67.62.82","177.67.62.90","177.67.62.120","177.67.62.121","177.67.62.127","177.67.62.128","177.67.62.129","177.67.62.130","177.67.62.131","177.67.62.191","177.67.62.254"
foreach ($Server in $ServerName)
{
if (test-Connection -ComputerName $Server -Count 2 -Quiet )

    {
write-Host "servidor $Server esta ativo e pigando" -ForegroundColor Green
    }

    else
    {
Write-Warning "servidor $Server nao esta pingando favor verificar"
    #Send-MailMessage -From "monitoramento@unimedcg.com.br" -Subject "Link de Publicacao" -To "armando.covre@unimedcg.com.br" -Body "Link de Publicacao" -SmtpServer monza.unimedcg.com.br
    }
}