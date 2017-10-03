class Documentation
{
    [String]$DocumentName
    [String]$Version
    [String]$Status
    # Muodostin kaikilla parametreilla
    Documentation ([string]$DocumentName,$Version,$Status)
    {
        # this on viittaus luokasta luotavaan olioon
        $this.DocumentName = $DocumentName
        $this.Version = $Version
        $this.Status = $Status
    }
    # Staattinen metodi aikaleiman muodostamiseen
    # Voidaan käyttää oliota muodostamatta
    [String] static GetTimeStamp()
    {
        $TimeStamp = Get-Date -Format o
        return $TimeStamp
    }
}
# Kutsutaan staattista metodia
$Aikaleima = [Documentation]::GetTimeStamp()
$Aikaleima | Out-GridView