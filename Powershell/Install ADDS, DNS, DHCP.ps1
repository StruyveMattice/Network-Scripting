Install-WindowsFeature -Name AD-Domain-Services -Restart -IncludeManagementTools
Install-WindowsFeature -Name DHCP -Restart -IncludeManagementTools
Install-WindowsFeature -Name DNS -Restart -IncludeManagementTools