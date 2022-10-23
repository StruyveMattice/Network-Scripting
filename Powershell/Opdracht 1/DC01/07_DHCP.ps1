
#Installing DHCP Role
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools
$scope = Read-Host -Prompt "Scope Name"

if (-not (Get-DhcpServerv4Scope | ? { $_.Name -eq $scope })) {

#Adding DHCP Scope and Exclusion Range
Add-DhcpServerV4Scope -Name $scope -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Write-Host 'Scope Added'

Add-DhcpServerv4ExclusionRange -EndRange 192.168.1.10 -ScopeId 192.168.1.0 -StartRange 192.168.1.1
Write-Host 'Exclusion Range Added'

Set-DhcpServerV4OptionValue -DnsServer 192.168.1.2,192.168.1.3 -Router 192.168.1.1 -DnsDomain 'intranet.mijnschool.be'
Write-Host 'Added DNS Server and Router'

Set-DhcpServerv4Scope -ScopeId 192.168.1.0 -LeaseDuration 192:00:00 #8 Days
Write-Host 'Added Lease Duration'

Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.100 -ClientId "b8-e9-37-3e-55-86" -Name "School Printer" -Description "Reservation for Printer"
Write-Host 'Reservation Added'

#If you don’t have permission to authorize DHCP in AD, you can specify that your DHCP server can start without checking for domain authorization
#http://woshub.com/how-to-configure-dhcp-server-using-powershell/
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DHCPServer\Parameters" -Name DisableRogueDetection -Value 1 -Force

# Removing the Post-Installation Warning in Server Manager
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12" -Name ConfigurationState -Value 2

Write-Host 'Restarting Service...'
Restart-service dhcpserver
Write-Host 'Service Restarted'
}

else {
    Write-Host "This Scope Already Exists"
}



