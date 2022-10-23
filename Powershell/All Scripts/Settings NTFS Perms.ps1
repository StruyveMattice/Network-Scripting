﻿#Get-Acl C:\Homes | Format-List
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path $folder -AclObject $acl
$rights = 'Read' #Other options: [enum]::GetValues('System.Security.AccessControl.FileSystemRights')
$inheritance = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.Inheritance')
$propagation = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.PropagationFlags')
$type = 'Allow' #Other options: [enum]::GetValues('System.Securit y.AccessControl.AccessControlType')
$ace = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)