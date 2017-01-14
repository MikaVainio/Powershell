# Skripti, joka luo käyttäjiä CSV-tiedostosta AD-hakemistopalveluun
$Tiedosto = Import-Csv -Delimiter ";" -Encoding Default C:\Users\Administrator\Downloads\Tilejä.csv
$Salasana = ConvertTo-SecureString "Q2werty" -AsPlainText -Force
$Tiedosto | New-ADUser -AccountPassword $Salasana -Enabled 1 -ChangePasswordAtLogon 1