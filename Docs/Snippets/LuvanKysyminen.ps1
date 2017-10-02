# Esimerkki jatkoluvan saamisesta käyttäjältä
$Käyttäjä = Read-Host -Prompt "Anna Poistettavan käyttäjän tunnus"
$Lupa = Read-Host -Prompt "Haluatko jatkaa? (k/e)"
if($Lupa -eq "k" -or $Lupa -eq "K")
{
    Remove-ADUser -Identity $Käyttäjä
}
else
{
    Write-Warning "Käyttän poisto keskeytettiin"
    exit # Poistutaan skriptin suorituksesta
}