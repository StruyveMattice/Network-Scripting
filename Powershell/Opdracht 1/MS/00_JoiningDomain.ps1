#Adding the DC02 to the domain
$hostname = "MS"

#Connecting to DC02
$session = New-PSSession -ComputerName $hostname -Credential "INTRANET\Administrator"

Invoke-Command -Session $session -ScriptBlock {
    #Joining the domain
    Add-Computer -Domain "intranet.mijnschool.be" -Credential (Get-Credential "INTRANET\Administrator") -Restart
    Write-Host "Welcome to intranet.mijnschool.be"
}