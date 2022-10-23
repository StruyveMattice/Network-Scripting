#Installing  ADDS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#Promoting DC01

#Requesting Domain Name
[string]$name = Read-Host -Prompt "Domain Name"

Install-ADDSForest -DomainName $name -Confirm:$false