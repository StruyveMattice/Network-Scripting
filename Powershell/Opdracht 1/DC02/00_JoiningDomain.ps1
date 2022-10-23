#Adding the DC02 to the domain
$hostname = "DC02"

#Connecting to DC02
$session = New-PSSession -ComputerName $hostname -Credential "INTRANET\Administrator"

Invoke-Command -Session $session -ScriptBlock {
    #Installing ADDS
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

    #Joining the domain
    Install-ADDSDomainController `
        -CreateDnsDelegation:$false `
        -DatabasePath "C:\Windows\NTDS" `
        -DomainName "intranet.mijnschool.be" `
        -InstallDns:$true `
        -LogPath "C:\Windows\NTDS" `
        -NoGlobalCatalog:$false `
        -SiteName "Waregem" `
        -SysvolPath 'C:\Windows\SYSVOL' `
        -NoRebootOnCompletion:$true `
        -Force:$true `
        -Credential (Get-Credential "INTRANET\Administrator") `
        -Confirm:$false 
    Write-Host "Welcome to intranet.mijnschool.be"
}