Install-Module MSOnline
Install-Module AzureAD
Import-Module AzureAD


Connect-MsolService


Get-MsolUser -All | where {$_.isLicensed -eq $true -and $_.BlockCredential -eq $true} | select userprincipalname,islicensed,Licenses,UsageLocation