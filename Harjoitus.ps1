# Luodaan AD-käyttäjiä CSV tiedoston perusteella

# Kysytään CSV-tiedoston tiedot käyttäjältä ja tallennetaan ne muuttujaan
Write-Warning("Luodaan käyttäjätilejä CSV-tiedostosta")
$Tiedosto = Read-Host("Anna tiedoston nimi ja polku")
$UudetKäyttäjät = Import-Csv -Path $Tiedosto -Delimiter ";" -Encoding Default

# Kryptataan ensimmäinen salasana
$EkaSalasana = ConvertTo-SecureString "MuutaHet1" -AsPlainText -Force

# Määritellään organisaatioyksikkö, johon käyttäjät luodaan
$Osasto = "OU=Markkinointi, DC=firma, DC=intra"

# Luodaan AD-käyttäjät
$UudetKäyttäjät | New-ADUser -AccountPassword $EkaSalasana -ChangePasswordAtLogon 1 -Enabled 1 -Path $Osasto

# Ilmoitetaan kun kaikki on valmista
$Määrä = $UudetKäyttäjät.Count
Write-Warning("$Määrä Käyttäjää lisätty")
