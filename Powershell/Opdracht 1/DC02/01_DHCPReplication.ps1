$session = New-PSSession -ComputerName $hostname -Credential "INTRANET\Administrator"

Invoke-Command -Session $session -ScriptBlock {
    Install-WindowsFeature -Name DHCP -IncludeManagementTools 
    #If you don’t have permission to authorize DHCP in AD, you can specify that your DHCP server can start without checking for domain authorization
    #http://woshub.com/how-to-configure-dhcp-server-using-powershell/
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DHCPServer\Parameters" -Name DisableRogueDetection -Value 1 -Force

    # Removing the Post-Installation Warning in Server Manager
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12" -Name ConfigurationState -Value 2
}

$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

Add-DhcpServerv4Failover -Name "dc01.intranet.mijnschool.be" -PartnerServer "dc02.intranet.mijnschool.be" -ScopeId 192.168.1.0 -SharedSecret $Secure_String_Pwd -LoadBalancePercent 50
