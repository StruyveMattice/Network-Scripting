
if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Mijn School,DC=intranet,DC=mijnschool,DC=be'") {
  Write-Host "OU already exists."
} 

else {
  New-ADOrganizationalUnit New-ADOrganizationalUnit -Name 'Mijn School' -Path "DC=intranet,DC=mijnschool,DC=be" -ProtectedFromAccidentalDeletion $True -DisplayName 'Mijn School' -Description 'Mijn School'
}

