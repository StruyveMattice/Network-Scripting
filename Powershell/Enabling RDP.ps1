$status_rdp = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections"
if($status_rdp.fDenyTSConnections)
{
    Write-Host 'Enabling RDP...'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Write-Host 'RDP Is Enabled'
}
else
{
    Write-Host 'Disabling RDP...'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 1
    Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Write-Host 'RDP Is Disabled'
}