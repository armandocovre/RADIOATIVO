#domínio que você quer consultar
$procurar = "domain.com.br"
 
#servidor de DNS que utilizaremos para consulta do DNS
$DNSserver = "189.38.95.95"
 
#localiza os registros de MX do domínio
$MXs = Resolve-DnsName $procurar -Type MX -Server $DNSserver | Select-object -ExpandProperty NameExchange
 
#localiza o registro TXT para ajudar a ver o SPF
$TXT = Resolve-DnsName $procurar -Type TXT -Server $DNSserver | Select-object -ExpandProperty Strings
 
Write-Host Consultas utilizando = $DNSserver
Write-Host $procurar
Write-Host SPF = $TXT
 
foreach($MX in $MXs)
{
#Verifica se o registro de MX possui uma entrada A
$IPA = Resolve-DnsName $MX -Type A -Server $DNSserver #| Select-Object -ExpandProperty IP4Address
foreach($IP in $IPA.IP4Address)
{
 
#Verifica se o IP da entrada A possui um reverso tipo A
$PTR = Resolve-DnsName $IP -Type PTR -Server $DNSserver | Select-Object -ExpandProperty NameHost
 
#Verifica se o A do reverso é valido
If(Resolve-DnsName "$PTR" -type A -Server $DNSserver )
{
$ok = $IPA.Name, $IP, $PTR
$ok | Select-Object @{N="MX";E={$IPA.Name}}, @{N="IP";E={$IP}}, @{N="Reverso";E={$PTR}}, @{N="Status";E={"A Valido"}} -Unique
}
else
{
$falha = $IPA.Name, $IP, $PTR
$ok | Select-Object @{N="MX";E={$IPA.Name}}, @{N="IP";E={$IP}}, @{N="Reverso";E={$PTR}}, @{N="Status";E={"A Invalido"}} -Unique
}
}
 
}