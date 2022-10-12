#Opvragen van alle adapters, zo kunnen we makkelijk selecteren welke we willen aanpassen
Get-NetAdapter
$index = Read-Host -Prompt 'Interface Index'
$adapter = Get-NetAdapter -InterfaceIndex $index
$IPType = "IPv4"

#De gekozen adapter leegmaken
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

#Ip, Default Gateway en DNS op vragen. Geen value is default value
$ip = Read-Host -Prompt 'IP Address'

$subnet = Read-Host -Prompt 'Network Prefix [/24]'
if(!$subnet)
{
    $subnet = 24
}

$default_gateway = Read-Host -Prompt 'Default Gateway [192.168.1.1]'
if(!$default_gateway)
{
    $default_gateway = '192.168.1.1'
}

$pref_dns = Read-Host -Prompt 'Preffered DNS [172.20.4.140]'
if(!$pref_dns)
{
    $pref_dns = '172.20.4.140'
}

$altr_dns = Read-Host -Prompt 'Alternate DNS [172.20.4.141]'
if(!$altr_dns)
{
    $altr_dns = '172.20.4.141'
}

#Invullen van gegevens
Try
{
$adapter | New-NetIPAddress -IPAddress $ip -PrefixLength $subnet -DefaultGateway $default_gateway
$adapter | Set-DnsClientServerAddress -ServerAddresses $pref_dns, $altr_dns
}

Catch
{
Write-Host 'Something went wrong'
}