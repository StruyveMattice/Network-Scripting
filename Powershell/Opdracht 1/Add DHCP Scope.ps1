#Adding DHCP Scope and Exclusion Range

Add-DhcpServerV4Scope -Name "MyLocalScope" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Write-Host 'Scope Added'

Add-DhcpServerv4ExclusionRange -EndRange 192.168.1.10 -ScopeId 192.168.1.0 -StartRange 192.168.1.1
Write-Host 'Exclusion Range Added'

Set-DhcpServerV4OptionValue -DnsServer 192.168.1.2,192.168.1.3 -Router 192.168.1.1
Write-Host 'Added DNS Server and Router'

Set-DhcpServerv4Scope -ScopeId 192.168.1.0 -LeaseDuration 192:00:00 #8 Dagen
Write-Host 'Added Lease Duration'

Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.100 -ClientId "b8-e9-37-3e-55-86"
Write-Host 'Reservation Added'

Write-Host 'Restarting Service...'
Restart-service dhcpserver
Write-Host 'Service Restarted'
