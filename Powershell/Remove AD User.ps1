$users = Import-Csv -Path 'C:\Users\Administrator\Documents\CSV Files\UserAccounts.csv' -Delimiter(';')

foreach($item in $users)
{
    $name = $item.Name
    Remove-ADUser -Identity $item.SamAccountName -Confirm:$false
    Write-Host "$name was deleted"
    
}