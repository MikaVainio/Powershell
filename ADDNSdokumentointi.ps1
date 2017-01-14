# Haetaan toimialueen tiedot ja tallennetaan ne CSV-tiedostoon
Get-ADDomain | Export-Csv -Encoding Unicode -Delimiter ";" C:\Users\Administrator\Documents\ADDomain.txt
# Haetaan verkkokorttien IP-osoitetiedot ja tallennetaan ne CSV-tiedostoon
Get-NetIPAddress | Export-Csv -Encoding Unicode -Delimiter ";" C:\Users\Administrator\Documents\NetIPAdress.txt
# Haetaan verkkokortin MAC-tiedot ja tallennetaan ne CSV-tiedostoon
Get-NetAdapter | Export-Csv -Encoding Unicode -Delimiter ";" C:\Users\Administrator\Documents\NetAdapter.txt
# Haetaan DNS-palvelimen tiedot ja tallennetaan ne CSV-tiedostoon
Get-DnsServer | Export-Csv -Encoding Unicode -Delimiter ";" C:\Users\Administrator\Documents\DNSServer.txt