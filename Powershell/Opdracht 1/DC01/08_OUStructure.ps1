#Creating OU stucture via CSV file

#Declaring Path
$path = 'C:\Users\Administrator\Documents\CSV Files\OUs.csv'

#Check if the file is there
if (Test-Path -Path $path) 
{
    $ou = Import-Csv -Path $path -Delimiter(';')

    #Running throug the csv file and adding all the OU's
    foreach ($item in $ou)
    {
        New-ADOrganizationalUnit -Name $item.Name -Path $item.Path -ProtectedFromAccidentalDeletion $True -DisplayName $item.DisplayName -Description $item.Description
        Write-Host ("Added {0}" -f $item.name)
    }
}

else
{
    Write-Host "File Not Found"
}
