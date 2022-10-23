#Request all network adapters
Get-NetAdapter
$index = Read-Host -Prompt 'Interface Index'
$adapter = Get-NetAdapter -InterfaceIndex $index
$IPType = "IPv4"

#Clear the chosen adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

#Requesting IP... When left blank, the default value is chosen
$ip = Read-Host -Prompt 'IP Address'

$subnet = Read-Host -Prompt 'Network Prefix [/24]'
#Checking if the string is empty
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

#Data is filled in
Try
{
$adapter | New-NetIPAddress -IPAddress $ip -PrefixLength $subnet -DefaultGateway $default_gateway
$adapter | Set-DnsClientServerAddress -ServerAddresses $pref_dns, $altr_dns
$adapter | Disable-NetAdapterBinding –ComponentID ms_tcpip6
}

Catch
{
Write-Host 'Something went wrong'
}