#install-module msonline
#import-module msonline
Connect-MsolService

$users = import-csv -Path "PATHTOCSV"

foreach ($user in $users){
    $license = (Get-MsolUser -UserPrincipalName $user.COLUMNNAME).licenses | Where-Object -Property AccountSkuId -EQ LICNSENAME -ErrorAction SilentlyContinue
    if ($license -ne $null){
        $user.upn | out-file "PATHTOFILE" -Append
    }
}
