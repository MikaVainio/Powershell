# STEAM-PALOMUURISÄÄNTÖJEN KÄYTTÖÖNOTTO 

# Sallitaan liikenne ulospäin  
$UDPEtäPortit = @("3478-3480", "27000-27100")
$TCPEtäPortit = "27015-27030"

New-NetFirewallRule -DisplayName "Allow Steam UDP Out" -Profile Private -Direction Outbound -Action Allow `
-Protocol UDP -RemotePort $UDPEtäPortit -Enabled True
New-NetFirewallRule -DisplayName "Allow Steam TCP Out" -Profile Private -Direction Outbound -Action Allow `
-Protocol TCP -RemotePort $TCPEtäPortit -Enabled True

# Sallitaan liikenne sisäänpäin
$UDPPaikallisPortit = @("27015","27031-27036")
$TCPPaikallisPortit = @("27015", "27036")

New-NetFirewallRule -DisplayName "Allow Steam UDP In" -Profile Private -Direction Inbound -Action Allow `-Protocol UDP -LocalPort $UDPPaikallisPortit -Enabled True
New-NetFirewallRule -DisplayName "Allow Steam TCP In" -Profile Private -Direction Inbound -Action Allow `
-Protocol TCP -LocalPort $TCPPaikallisPortit -Enabled True
