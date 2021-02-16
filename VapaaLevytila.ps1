# Luetaan koneen kaikkien levyjen vapaa tila (MB)
 # Vaatii vähintään Powershell version 5.0, jos käytät suomenkielistä Windowsia, laskureiden nimet pitää kirjoittaa suomeksi!
class LooginenLevy
{
    [String]$Levyosio
    [int]$LevyVapaatila
}
$OutPut = @()
$VapaaTila = Get-Counter -Counter "\LogicalDisk(*)\Free Megabytes"
$Mittaukset = $VapaaTila.CounterSamples
foreach($Mittaus in $Mittaukset)
{
    $Vapaana = $Mittaus.CookedValue
    $Osio = $Mittaus.InstanceName
    $Olio = [LooginenLevy]::new()
    $Olio.Levyosio = $Osio
    $Olio.LevyVapaatila = $Vapaana
    $OutPut = $OutPut + $Olio
}
$OutPut | Out-GridView

# Esimerkin levytilalaskuri on suomeksi "\Looginen levy(*)\Vapaa tila"
