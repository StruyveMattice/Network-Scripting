#Renaming Default Site
#https://pixelrobots.co.uk/2016/11/step-by-step-guide-to-setting-up-an-active-directory-forest-and-adding-additional-dcs-on-windows-2016-with-powershell/
$Sitename = read-host "Enter new site name to replace Default-First-Site"
$configNCDN = (Get-ADRootDSE).ConfigurationNamingContext
$siteContainerDN = ("CN=Sites," + $configNCDN)
$siteDN = "CN=Default-First-Site-Name," + $siteContainerDN
Get-ADObject -Identity $siteDN | Rename-ADObject -NewName:$sitename
Write-Host "Default Site name has been changed to $Sitename"