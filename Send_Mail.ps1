# Log Event
$output = Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" -AND $_.TimeCreated -gt [datetime]::today } |
        Select-Object -Property TimeCreated, Id, Task, OpcodeDisplayName, TaskDisplayName |
        Format-Table

# Configuration email
$email_username = "manager@lmit.pt";
$email_password = "1q2w3e4r5t";
$email_smtp_host = "smtp.gmail.com";
$email_smtp_port = "587";
$email_smtp_SSL = 1;
$email_from_address = "armando.covre@lmit.pt";
$email_subject = "Task Scheduler - Copy_dump_to_bucket-NEW";
$email_body = $output | fl | out-string;

# Send Email with credential
$smtp = new-object Net.Mail.SmtpClient($email_smtp_host, $email_smtp_port);
        $smtp.EnableSSL = $email_smtp_SSL;
        $smtp.Credentials = New-Object System.Net.NetworkCredential($email_username, $email_password);
        $smtp.Send($email_from_address,$email_from_address,$email_subject,$email_body);
        $message.Dispose();
        write-host "... E-Mail sent!" ;