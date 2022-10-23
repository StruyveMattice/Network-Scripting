#Adding Reverse Lookup Zone
Add-DnsServerPrimaryZone -NetworkId 192.168.1/24 -ReplicationScope Domain -DynamicUpdate Secure
Register-DnsClient
Write-Host "Reverse Lookup Zone Was Added"