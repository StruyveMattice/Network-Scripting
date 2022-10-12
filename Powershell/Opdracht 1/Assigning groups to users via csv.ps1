$members = Import-Csv -Path 'C:\Users\Administrator\Documents\CSV Files\GroupMembers.csv' -Delimiter(';')


foreach($item in $members)
{
    $member = $item.Member
    $group = $item.Identity
    Add-ADGroupMember -Identity $group -Members $member
    Write-Host "$member was added to $group"
}