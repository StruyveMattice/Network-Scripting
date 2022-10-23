#Adding UPN Suffix

#Requesting UPN
$upn = Read-Host -Prompt 'UPN Suffix'

#Adding UPN
Get-ADForest | Set-ADForest -UPNSuffixes @{add="$upn"}
Write-Host "Added $upn suffix"