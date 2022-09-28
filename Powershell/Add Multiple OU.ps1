$ou = 'OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be',
'OU=Leerlingen,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be'

foreach($item in $ou)
{
    Write-Host $item
    [string]$name = Read-Host -Prompt 'Name'
    Write-Host $name
    New-ADOrganizationalUnit -Name $name -Path $item -ProtectedFromAccidentalDeletion $True -DisplayName $name -Description $name
}


