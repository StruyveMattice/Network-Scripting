$s = New-PSSession -ComputerName 'MS' -Credential "INTRANET\Administrator" 

#Remote Session To MS
Invoke-Command -Session $s -ScriptBlock {

    $Folder = 'C:\Homes'

    #Check if homes folder already exists
    if (Test-Path -Path $Folder) 
    {
        "Folder already exists"
    } 

    else 
    {
        Write-Host "Creating Share ..."

        #Creating the dir
        New-item "C:\Homes" -itemtype directory

        #Sharing the dir
        New-SmbShare -Name "Homes" -Path "C:\Homes" -FullAccess "Everyone"
        
        Write-Host "Home Share Created"
    }


    #Get Acl Var
    $acl = Get-ACL -Path $folder

    #Disabling Inheritance
    $acl.SetAccessRuleProtection($True, $True)  

    #Adding Authenticated Users
    $identity = 'Authenticated Users'
    $rights = 'Read' #Other options: [enum]::GetValues('System.Security.AccessControl.FileSystemRights')
    $inheritance = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.Inheritance')
    $propagation = 'None' #Other options: [enum]::GetValues('System.Security.AccessControl.PropagationFlags')
    $type = 'Allow' #Other options: [enum]::GetValues('System.Securit y.AccessControl.AccessControlType')
    $ace = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)
    $acl.AddAccessRule($ace)
    Set-Acl -Path "C:\Homes" -AclObject $acl
    Write-Host "Added Authenticated Users Read Rights"

    
    Set-Acl -Path "C:\Homes" -AclObject $Acl
}