<#
  .DESCRIPTION
        TEMPLATE DE DISPARO DE EMAIL
    

  .OUTPUTS
    ENVIAR INFORMAÇÕES NECESSÁRIAS POR EMAIL.


  .NOTES
    Version:        1.0
    Author:         ARMANDO COVRE - ARMANDOMOURACOVRE@GMAIL.COM
    Creation Date:  FEVEREIRO - 2021

#>

#---------------------------------------------------------[SCRIPT TESTE]-----------------------------------------------------
$output_1 = Test-Connection google.com | Select-Object -Property IPV4ADDRESS



Function Get-DiskSize {
      $Disks = @()
      $DiskObjects = Get-WmiObject -namespace "root/cimv2" -query "SELECT Name, Capacity, FreeSpace FROM Win32_Volume"
      $DiskObjects | % {
        $Disk = New-Object PSObject -Property @{
          Name           = $_.Name
          Capacity       = [math]::Round($_.Capacity / 1073741824, 2)
          FreeSpace      = [math]::Round($_.FreeSpace / 1073741824, 2)
          FreePercentage = [math]::Round($_.FreeSpace / $_.Capacity * 100, 1)
        }
        $Disks += $Disk
      }
      Write-Output $Disks | Sort-Object Name
    }
$output_2 = Get-DiskSize |
    ft Name,@{L='Capacity (GB)';E={$_.Capacity}},@{L='FreeSpace (GB)';E={$_.FreeSpace}},@{L='FreePercentage (%)';E={$_.FreePercentage}}

#---------------------------------------------------------[CONFIGURAÇÃO DATA]-----------------------------------------------------
$Date = Get-Date
$CutoffDate = $Date.AddDays(-100)


#---------------------------------------------------------[CONFIGURAÇÃO SMTP]-----------------------------------------------------
# CONFIGURAÇÃO SMTP, LOGIN, PASSWORD, PORTA E SERVIDOR
$email_username = "username@gmail.com"
$email_password = "xg2mC49xzLpNRMevVnxsmiNqXEd6ka3T4CgU8WeTiyohVxwYXK"
$email_smtp_host = "smtp.gmail.com"
$email_smtp_port = "587"
$email_smtp_SSL = 1
$email_from = "user@gmail.com"


#---------------------------------------------------------[CONFIGURAÇÃO CORPO DO EMAIL]-----------------------------------------------------
# CONFIGURAÇÃO ASSUNTO E CORPO DO EMAIL
$email_subject = "ASSUNTO LOG DE EVENTO E DISCO";
$email_body = "STATUS - $Date `r`n";
$email_body += "--------------------------------- `r`n`r`n";
$email_body += $output_1 | out-string;
$email_body += "LINHA 3";
$email_body += $output_2 | out-string;


#---------------------------------------------------------[DISPARO DE EMAIL]--------------------------------------------------------
# ENVIAR EMAIL COM CREDENCIAL
$smtp = new-object Net.Mail.SmtpClient($email_smtp_host, $email_smtp_port);
        $smtp.EnableSSL = $email_smtp_SSL;
        $smtp.Credentials = New-Object System.Net.NetworkCredential($email_username, $email_password);
        $smtp.Send($email_username,$email_from,$email_subject,$email_body);
####        $message.Dispose();
        write-host "... E-Mail sent!" ;
