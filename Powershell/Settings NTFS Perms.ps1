#Get-Acl C:\Homes | Format-List#(Get-Acl C:\Homes).Access#Disabling Inheritance$acl = Get-Acl -Path "C:\Homes"
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path $folder -AclObject $acl#Adding Authenticated Users$identity = 'Authenticated Users'
$rights = 'Read' #Other options: [enum]::GetValues('System.Security.AccessControl.FileSystemRights')
$inheritance = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.Inheritance')
$propagation = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.PropagationFlags')
$type = 'Allow' #Other options: [enum]::GetValues('System.Securit y.AccessControl.AccessControlType')
$ace = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)$acl.AddAccessRule($ace)Set-Acl -Path "C:\Homes" -AclObject $aclWrite-Host "Added Authenticated Users Read Rights"