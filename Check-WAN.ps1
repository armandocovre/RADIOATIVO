function Check-WanStatus { 
    begin { 
        try { 
            # SMTP Variables 
            $smtp = 'monza.unimedcg.com.br' 
            $to = 'monitoramento@unimedcg.com.br' 
            $from = 'armando.covre@unimedcg.com.br' 
            $subject = 'WAN-1 is Down' 

            # Wan Variables 
            #WAN1 - Primary IP Address 
            $wan1 = '182.73.114.40' 
            #WAN2 - IP Address 
            $wan2 = '122.154.3.97' 
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
