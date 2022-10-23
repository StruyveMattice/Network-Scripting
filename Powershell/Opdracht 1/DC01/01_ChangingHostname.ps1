#Change Hostname

#Requesting Hostname
[string]$hostname = Read-Host -Prompt 'Hostname?'

#Changing the hostname and restarting the machine
try 
{
    Rename-Computer -NewName $hostname -Restart -Confirm:$false
    Write-Host "Hostname has been changed to $hostname"
}

catch 
{
    "Something Went Wrong"
}
