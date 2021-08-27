<#
	.DESCRIPTION
        VERIFICA SE O ESPAÇO DE DISCO ESTÁ BAIXO
        DISCO BAIXO, DISPARAR EMAIL
        DESTINATARIO ESPECÍFICOS


	.PARAMETER
        UTILIZAR COM SCHEDULED TASK
        EXECUTAR 1 VEZ POR DIA
        PREFERENCIA FORA DE HORA
		

	.OUTPUTS
		RECEBE STATUS VIA EMAIL


	.NOTES
		Version:        1.0
		Author:         ARMANDO COVRE - ARMANDOMOURACOVRE@GMAIL.COM
		Creation Date:  FEVEREIRO - 2021

#>

#---------------------------------------------------------[EMAIL]--------------------------------------------------------


# INFORMAR DISCO PARA CHECK 
# $null or empty para checar todos os discos locais
# NÃO FUNCIONA COM DISCO EM REDE

# $drives = @("C","D");
#$drives = $null;
$drives = @("C");
 
# TAMANHO MÍNIMO DO DISCO PARA ALERTA
$minSize = 5GB;
 
# CONFIGURAÇÃO SMTP
$email_username = "username-1@domain.com";
$email_password = "password-email";
$email_smtp_host = "smtp.domain.com";
$email_smtp_port = "587";
$email_smtp_SSL = 1;
$email_from_address = "username-2@domain.com";


#---------------------------------------------------------[START SCRIPT]--------------------------------------------------------
 
 
if ($drives -eq $null -Or $drives -lt 1) {
    $localVolumes = Get-WMIObject win32_volume;
    $drives = @();
    foreach ($vol in $localVolumes) {
        if ($vol.DriveType -eq 3 -And $vol.DriveLetter -ne $null ) {
            $drives += $vol.DriveLetter[0];
        }
    }
}
foreach ($d in $drives) {
    Write-Host ("`r`n");
    Write-Host ("Checking drive " + $d + " ...");
    $disk = Get-PSDrive $d;
    if ($disk.Free -lt $minSize) {
        Write-Host ("Drive " + $d + " has less than " + $minSize `
            + " bytes free (" + $disk.free + "): sending e-mail...");
        
        $message = new-object Net.Mail.MailMessage;
        $message.From = $email_from_address;
        foreach ($to in $email_to_addressArray) {
            $message.To.Add($to);
        }
        $message.Subject =  ("WARNING: " + $env:computername + " drive "+ $d);
#        $message.Subject += (" tem menos que " + $minSize + " bytes free ");
#        $message.Subject += ("(" + $disk.Free + ")");
        $message.Body =     "MENSAGEM AUTOMATICA, `r`n`r`n";
        $message.Body +=    "Ola, ";
        $message.Body +=    "disparo pelo Powershell script ";
        $message.Body +=    ("para te informar que " + $env:computername + " drive " + $d + " ");
        $message.Body +=    "esta rodando com pouco espaco de disco. `r`n`r`n";
        $message.Body +=    "--------------------------------------------------------------";
        $message.Body +=    "`r`n";
        $message.Body +=    ("SERVIDOR: " + $env:computername + " `r`n");
        $message.Body +=    "IP DO SERVIDOR LOCAL: ";
        $ipAddresses = Get-NetIPAddress -AddressFamily IPv4;
        foreach ($ip in $ipAddresses) {
            if ($ip.IPAddress -like "127.0.0.1") {
                continue;
            }
            $message.Body += ($ip.IPAddress + " ");
        }
        $message.Body +=    "`r`n";
        $message.Body +=    ("Used space on drive " + $d + ": " + $disk.Used + " bytes. `r`n");
        $message.Body +=    ("Free space on drive " + $d + ": " + $disk.Free + " bytes. `r`n");
        $message.Body +=    "--------------------------------------------------------------";
        $message.Body +=    "`r`n`r`n";
        $message.Body +=    "Este aviso ira disparar quando o espaco livre for menor ";
        $message.Body +=    ("que " + $minSize + " bytes `r`n`r`n");
        $message.Body +=    "Atenciosamente, `r`n`r`n";
        $message.Body +=    "-- `r`n";
        $message.Body +=    "NOC - POWERSHELL - SCRIPT`r`n";
                $message.Body +=        "https://docs.microsoft.com/pt-pt/powershell/";
 
        $smtp = new-object Net.Mail.SmtpClient($email_smtp_host, $email_smtp_port);
        $smtp.EnableSSL = $email_smtp_SSL;
        $smtp.Credentials = New-Object System.Net.NetworkCredential($email_username, $email_password);
        $smtp.send($message);
        $message.Dispose();
        write-host "... E-Mail enviado!" ; 
    }
    else {
        Write-Host ("Drive " + $d + " has more than " + $minSize + " bytes free: nothing to do.");
    }
}