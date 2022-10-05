Write-Host "Creating Home Share on MS..."

New-SmbShare -Name "Home" -Path "\\MS\" -FullAccess "Everyone", "INTRANET\Administrators" -ReadAccess "Authenticated Users"

Write-Host "Home Share Created"