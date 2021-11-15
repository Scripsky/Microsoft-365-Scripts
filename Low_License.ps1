$Mail        = 'user_management@gtl.net'
$password    = Get-Content 'C:\Scripts\Credentials\M365_Encrypted_Password.txt' | ConvertTo-SecureString
$credentials = New-Object System.Management.Automation.PsCredential($Mail, $password)
$Helpdesk    = 'helpdesk@gtl.net'

import-module msonline
Connect-MsolService -Credential $credentials

$e3ActiveUnits   = Get-MsolAccountSku | Where-Object -Property AccountSkuId -EQ GTLCORP:SPE_E3 | Select-Object -ExpandProperty ActiveUnits
$f3ActiveUnits   = Get-MsolAccountSku | Where-Object -Property AccountSkuId -EQ GTLCORP:SPE_F1 | Select-Object -ExpandProperty ActiveUnits
$e3ConsumedUnits = Get-MsolAccountSku | Where-Object -Property AccountSkuId -EQ GTLCORP:SPE_E3 | Select-Object -ExpandProperty ConsumedUnits
$f3ConsumedUnits = Get-MsolAccountSku | Where-Object -Property AccountSkuId -EQ GTLCORP:SPE_F1 | Select-Object -ExpandProperty ConsumedUnits

if (([int]$f3ConsumedUnits + 1) -ge [int]$f3ActiveUnits){
   
    Send-MailMessage -From 'User Management <user_management@gtl.net>' -To $Helpdesk `
    -Subject 'User Backup Report' -SmtpServer 'smtp.office365.com' -Port 587 -UseSsl `
    -Credential $Credentials -Body "There is only 1 F3 license left. Please order more or remove licenses from disabled users"
}

if (([int]$e3ConsumedUnits + 1) -ge [int]$e3ActiveUnits){
    
    Send-MailMessage -From 'User Management <user_management@gtl.net>' -To $Helpdesk `
    -Subject 'User Backup Report' -SmtpServer 'smtp.office365.com' -Port 587 -UseSsl `
    -Credential $Credentials -Body "There is only 1 E3 license left. Please order more or remove licenses from disabled users"
}