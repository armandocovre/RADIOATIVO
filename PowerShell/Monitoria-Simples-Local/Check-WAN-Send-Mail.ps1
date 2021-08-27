function Check-WanStatus { 
    begin { 
        try { 
            # SMTP Variables 
            $smtp = 'email.domain.com.br' 
            $to = 'noc@domain.com.br' 
            $from = 'username@udomain.com.br' 
            $subject = 'WAN-1 is Down' 

            # Wan Variables 
            #WAN1 - Primary IP Address 
            $wan1 = 'XXX.XXX.XXX.XXX' 
            #WAN2 - IP Address 
            $wan2 = 'YYY.YYY.YYY.YYY' 
            #Getting Static IP from URL 
            $url = "http://checkip.dyndns.com"  
            $webclient = New-Object System.Net.WebClient 
        } 
        catch { 
        } 
    } 
    process { 
        try {
            $Ip = $webclient.DownloadString($url) 
            $Ip2 = $Ip.ToString() 
            $staticIP = $Ip2.Split(" ")[5].Replace("</body>","").Replace("</html>","") 
             
            if (  $staticIP -notmatch $wan1 ) 
                { 
                    Write-Output "WAN-1 {$wan1} is Down. The Current Static IP is : $wan2 ." 
                     
                    $body = "WAN-1 {$wan1} is Down." 
                    $body += "`n" 
                    $body += "`n" 
                    $body += "The Current Static IP is : $staticIP" 
                 
                    Send-MailMessage -SmtpServer $smtp -To $to -From $from -Subject $subject -Body $body -Priority 'High' -UseSsl 

                } 
             
            else  
                { 
                    Write-Output "All is Well" 
                } 
        } 
        catch { 
        } 
    } 
    end { 
        try { 
        } 
        catch { 
        } 
    } 
} 
 
Check-WanStatus  
