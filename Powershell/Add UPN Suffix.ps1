#Adding UPN Suffix
$upn = Read-Host -Prompt 'UPN Suffix'
Get-ADForest | Set-ADForest -UPNSuffixes @{add="$upn"}
Write-Host "Added $upn suffix"