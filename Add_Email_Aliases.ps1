Install-Module ExchangeOnlineManagement
Connect-ExchangeOnline

$distros = Get-Content -Path "D:\distros\import.csv"
$shares  = Get-Content -Path "D:\shares\import.csv"
$users   = Get-Content -Path "D:\users\import.csv"
$groups  = Get-Content -Path "D:\groups\import.csv"

#Distribution List
foreach($distro in $distros){
    $edit = $distro.replace("@domain","")
    Set-DistributionGroup "$distro" -EmailAddresses @{Add="$edit@domain"}
    Get-DistributionGroup "$distro" | Select-Object -ExpandProperty EmailAddresses
}

#Shared Mailbox
foreach($share in $shares){
    $edit = $share.replace("@domain","")
    Set-Mailbox "$share" -EmailAddresses @{Add="$edit@domain"}
    Get-Mailbox "$share" | Select-Object -ExpandProperty EmailAddresses
}

#user
foreach($user in $users){
    $edit = $user.replace("@domain","")
    Set-Mailbox "$user" -EmailAddresses @{Add="$edit@domain"}
    Get-Mailbox "$user" | Select-Object -ExpandProperty EmailAddresses
}

#M365 Group
foreach($group in $groups){
    $edit = $group.replace("@domain","")
    Set-UnifiedGroup -Identity "$group" -EmailAddresses @{Add="$edit@domain"}
    Get-UnifiedGroup -Identity "$group" | Select-Object -ExpandProperty EmailAddresses
}
