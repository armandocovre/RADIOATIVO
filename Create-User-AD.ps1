Import-Csv “C:\Documents\Users.csv” |

ForEach-Object
        {
        $Name = $_.Name
        $Type = $_.Type
        $Departamento = $_.Departamento
        $Login = $_.Login
        $FN = $_.FN
        $LN = $_.LN

        New-ADUser -Name $Name -GivenName $FN -Surname $LN -DisplayName $FN” “$LN -Description $Departamento -Path “OU=Users_Novos,DC=unimedcg,DC=com,DC=br” -PasswordNeverExpires $true -AccountPassword (ConvertTo-SecureString -AsPlainText “unimedcg@2018” -Force) -CannotChangePassword 1 -ChangePasswordAtLogon 0 -Enabled 1 -UserPrincipal -Name $Login”@unimedcg.com.br” -SamAccountName $Login 
        }