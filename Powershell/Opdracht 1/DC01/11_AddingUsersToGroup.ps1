#Assigning users to a group via CSV File

#Declaring Path
$path = 'C:\Users\Administrator\Documents\CSV Files\GroupMembers.csv'

if (Test-Path -Path $path){
    $members = Import-Csv -Path $path -Delimiter(';')
    foreach($item in $members)
    {
        $member = $item.Member
        $group = $item.Identity
        Add-ADGroupMember -Identity $group -Members $member
        Write-Host "$member was added to $group"
    }
}

else
{
    Write-Host "File Not Found"
}
