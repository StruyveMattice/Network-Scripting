$groups = Import-Csv -Path 'C:\Users\Administrator\Documents\CSV Files\Groups.csv' -Delimiter(';')


foreach($item in $groups)
{
    $name = $item.Name
    New-ADGroup -Path $item.Path -Name $item.Name -DisplayName $item.DisplayName -Description $item.Description -GroupCategory $item.GroupCategory -GroupScope $item.GroupScope
    Write-Host "$name was added"
}