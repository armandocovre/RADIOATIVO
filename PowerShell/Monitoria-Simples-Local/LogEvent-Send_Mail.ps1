<#
	.DESCRIPTION
        FILTRAR NO LOG DE EVENTO
        DISPARA EMAIL O RESULTADO DO ESTADO DO LOG DE EVENTO

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

#---------------------------------------------------------[LOG DE EVENTO]--------------------------------------------------------
# Log DE EVENTO | FILTRO
$output = Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" -AND $_.TimeCreated -gt [datetime]::today } |
        Select-Object -Property TimeCreated, Id, Task, OpcodeDisplayName, TaskDisplayName |
        Format-Table


#---------------------------------------------------------[CONFIGURAÇÃO SMTP]-----------------------------------------------------
# CONFIGURAÇÃO SMTP
$email_username = "username-1@domain.com";
$email_password = "password-email";
$email_smtp_host = "smtp.domain.com";
$email_smtp_port = "587";
$email_smtp_SSL = 1;
$email_from_address = "username-2@domain.com";
$email_subject = "ASSUNTO DO EMAIL NOTIFICAÇÃO";
$email_body = $output | fl | out-string;



#---------------------------------------------------------[DISPARO DE EMAIL]--------------------------------------------------------
# ENVIAR EMAIL COM CREDENCIAL
$smtp = new-object Net.Mail.SmtpClient($email_smtp_host, $email_smtp_port);
        $smtp.EnableSSL = $email_smtp_SSL;
        $smtp.Credentials = New-Object System.Net.NetworkCredential($email_username, $email_password);
        $smtp.Send($email_from_address,$email_from_address,$email_subject,$email_body);
        $message.Dispose();
        write-host "... E-Mail sent!" ;
