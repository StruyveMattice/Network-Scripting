$ip = Read-Host -Prompt 'IP Address'
$subnet = Read-Host -Prompt 'Network Prefix'
$default_gateway = Read-Host -Prompt 'Default Gateway'
$pref_dns = Read-Host -Prompt 'Preffered DNS'
$altr_dns = Read-Host -Prompt 'Alternate DNS'

New-NetIPAddress –IPAddress $ip -DefaultGateway $default_gateway -PrefixLength $subnet Set-DnsClientServerAddress -ServerAddresses $pref_dns, $altr_dns -InterfaceIndex (Get-NetAdapter).6