$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

Add-DhcpServerv4Failover -Name "dc01.intranet.mijnschool.be" -PartnerServer "dc02.intranet.mijnschool.be" -ScopeId 192.168.1.0 -SharedSecret $Secure_String_Pwd -LoadBalancePercent 50