$s = New-PSSession -ComputerName 'MS' -Credential "INTRANET\Administrator" 

#Remote Session To MS
Invoke-Command -Session $s -ScriptBlock {

    $Folder = 'C:\Public'

    #Check if homes folder already exists
    if (Test-Path -Path $Folder) 
    {
        "Folder already exists"
    } 

    else 
    {
        Write-Host "Creating Share ..."

        #Creating the dir
        New-item $Folder -itemtype directory

        #Sharing the dir
        New-SmbShare -Name "Public" -Path $Folder -FullAccess "Everyone"
        
        Write-Host "Public Share Created"
    }


    #Get Acl Var
    $acl = Get-ACL -Path $folder

    #Disabling Inheritance
    $acl.SetAccessRuleProtection($True, $True)  

    #Adding Authenticated Users
    $identity = 'Authenticated Users'
    $rights = 'Modify' #Other options: [enum]::GetValues('System.Security.AccessControl.FileSystemRights')
    $inheritance = 'ContainerInherit,ObjectInherit' #Other options: [enum]::GetValues('System.Security.AccessControl.Inheritance')
    $propagation = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.PropagationFlags')
    $type = 'Allow' #Other options: [enum]::GetValues('System.Securit y.AccessControl.AccessControlType')
    $ace = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)
    $acl.AddAccessRule($ace)
    Set-Acl -Path $Folder -AclObject $acl
    Write-Host "Added Authenticated Users Read Rights"

    #Adding Personeel Users
    $identity = 'Personeel' 
    $rights = 'Modify' #Other options: [enum]::GetValues('System.Security.AccessControl.FileSystemRights')
    $inheritance = 'ContainerInherit,ObjectInherit' #Other options: [enum]::GetValues('System.Security.AccessControl.Inheritance')
    $propagation = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.PropagationFlags')
    $type = 'Allow' #Other options: [enum]::GetValues('System.Securit y.AccessControl.AccessControlType')
    $ace = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)
    $acl.AddAccessRule($ace)
    Set-Acl -Path $Folder -AclObject $acl
    Write-Host "Added Authenticated Users Read Rights"

    
    Set-Acl -Path $Folder -AclObject $Acl
}