$s = New-PSSession -ComputerName 'MS' -Credential "INTRANET\Administrator" 

#Remote Session To MS
Invoke-Command -Session $s -ScriptBlock {

    $Acl = Get-Acl -Path "C:\Homes"

    $Ace = $Acl.Access

    foreach ($item in $Ace)
    {
        if(($item.IdentityReference -ne "BUILTIN\Administrators") -and ($item.IdentityReference -ne "NT AUTHORITY\Authenticated Users"))
        {
            $Acl.RemoveAccessRule($item)
            Write-Host "Removed $item"
            Set-Acl -Path "C:\Homes" -AclObject $Acl
        }
        
        else
        {
            Write-Host "Everything is already removed"
        }
    }
}

