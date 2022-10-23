$folder = '\\DC02\Profiles'

if (Test-Path -Path $Folder) 
{
    "Folder already exists"
} 

else 
{
    Write-Host "Creating Share ..."

    New-item $folder -itemtype directory

    New-SmbShare -Name "\`$Homes" -Path $folder -FullAccess "Everyone"
    
    Write-Host "Profiles Share Created"
}

