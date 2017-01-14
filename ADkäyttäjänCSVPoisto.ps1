# Poistetaan CSV-tiedostoon kirjatut käyttäjät AD:sta
$tiedosto = Import-Csv -Delimiter ";" -Encoding Default "C:\Users\Administrator\Downloads\Poista.csv"
foreach($rivi in $tiedosto)
{
    Remove-ADUser -Identity $rivi.SamAccountName -Confirm:0 # ei vahvistusta poistolle
}