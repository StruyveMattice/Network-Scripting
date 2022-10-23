$s = New-PSSession -ComputerName 'DC02' -Credential "INTRANET\Administrator" 

#Remote Session To MS
Invoke-Command -Session $s -ScriptBlock {

    $Folder = 'C:\Public'

    $Acl = Get-Acl -Path $Folder

    $Ace = $Acl.Access

    foreach ($item in $Ace)
    {
        if(($item.IdentityReference -ne "BUILTIN\Administrators") -and ($item.IdentityReference -ne "NT AUTHORITY\Authenticated Users"))
        {
            $Acl.RemoveAccessRule($item)
            Write-Host "Removed $item"
            Set-Acl -Path $Folder -AclObject $Acl
        }
        
        else
        {
            Write-Host "Everything is already removed"
        }
    }
}

