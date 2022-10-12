$Folder = 'C:\Homes'

if (Test-Path -Path $Folder) 
{
    "Folder already exists"
} 

else 
{
    Write-Host "Creating Share ..."

    New-item "C:\Homes" -itemtype directory

    New-SmbShare -Name "Homes" -Path "C:\Homes" -FullAccess "Everyone"
    
    Write-Host "Home Share Created"
}

