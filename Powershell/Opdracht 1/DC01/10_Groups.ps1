#Creating Groups via CSV file

#Declaring Path
$path = 'C:\Users\Administrator\Documents\CSV Files\Groups.csv'

if (Test-Path -Path $path)
{
    $groups = Import-Csv -Path $path -Delimiter(';')
    foreach($item in $groups)
    {
        New-ADGroup -Path $item.Path -Name $item.Name -DisplayName $item.DisplayName -Description $item.Description -GroupCategory $item.GroupCategory -GroupScope $item.GroupScope
        Write-Host ("{0} was added" -f $item.name)
    }
}

else
{
    Write-Host "File Not Found"
}
