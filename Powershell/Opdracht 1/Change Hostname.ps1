[string]$hostname = Read-Host -Prompt 'Hostname?'

Rename-Computer -NewName $hostname -Restart -Confirm:$false
Write-Host "Hostname has been changed to $hostname"