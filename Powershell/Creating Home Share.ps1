Write-Host "Creating Home Share on MS..."

New-SmbShare -Name "Homes" -Path "C:\" -FullAccess "Everyone"

Write-Host "Home Share Created"