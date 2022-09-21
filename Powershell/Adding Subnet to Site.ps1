#Adding subnet to site
$subnet = Read-Host -Prompt 'Subnet (blank=192.168.1.0/24)'
if(!$subnet)
{
    $subnet = '192.168.1.0/24'
}
$site = Read-Host -Prompt 'Site (blank=Waregem)'
if(!$site)
{
    $site = 'Waregem'
}
New-ADReplicationSubnet -Name $subnet -Site $site
Write-Host "Subnet $subnet has been added to site $site"