#Renaming Default Site
#https://pixelrobots.co.uk/2016/11/step-by-step-guide-to-setting-up-an-active-directory-forest-and-adding-additional-dcs-on-windows-2016-with-powershell/

$sitename = Read-Host -Prompt "New Site Name"
$configNCDN = (Get-ADRootDSE).ConfigurationNamingContext
$siteContainerDN = ("CN=Sites," + $configNCDN)
$siteDN = "CN=Default-First-Site-Name," + $siteContainerDN
Get-ADObject -Identity $siteDN | Rename-ADObject -NewName:$sitename
Write-Host "Default Site name has been changed to $sitename"


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