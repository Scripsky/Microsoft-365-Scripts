#install-module azuread
#import-module azuread

Connect-AzureAD

#install-module msonline
#import-module msonline

Connect-MsolService


$ids = import-csv -Path E:\id.csv

foreach ($id in $ids){
    Get-AzureADGroupMember -ObjectId $id.id | Out-File -FilePath E:\pmousers.csv -Append
}

$users = import-csv -Path E:\test.csv


foreach ($user in $users){
    $license = $null
    $license = (Get-MsolUser -UserPrincipalName $user.upn).licenses | Where-Object -Property AccountSkuId -EQ GTLCORP:PROJECTPROFESSIONAL -ErrorAction SilentlyContinue
    if ($license -ne $null){
        $user.upn | out-file E:\project.csv -Append
    }
}

foreach ($user in $users){
    $license = $null
    $license = (Get-MsolUser -UserPrincipalName $user.upn).licenses | Where-Object -Property AccountSkuId -EQ GTLCORP:VISIOCLIENT -ErrorAction SilentlyContinue
    if ($license -ne $null){
        $user.upn | out-file E:\visio.csv -Append
    }
}

