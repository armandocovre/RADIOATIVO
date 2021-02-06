#https://myaccount.google.com/lesssecureapps
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "armando.covre@lmit.pt"
$Password = "lmit.c0vr3"

$to = "armando.covre@lmit.pt"
#$cc = "user2@domain.com"
$subject = "STATUS copy_sql_to_bucket"
$body = "STATUS copy_sql_to_bucket"
#$attachment = "C:\test.txt"

$message = New-Object System.Net.Mail.MailMessage
$message.subject = $subject
$message.body = $body
$message.to.add($to)
#$message.cc.add($cc)
$message.from = $username
#$message.attachments.add($attachment)

$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$smtp.send($message)
write-host "Mail Sent"
