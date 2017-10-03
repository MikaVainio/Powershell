$Osasto = "Tietohallinto"
$SallitutOsastot = "Taloushallinto", "Tietohallinto", "Markkinointi"
if ($Osasto -iin $SallitutOsastot)
{
    Write-Warning "Osasto on sallittujen osastojen luettelossa"
}
else
{
    Write-Warning "Osasto ei kuulu sallituihin osastoihin"
}