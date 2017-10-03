class Documentation
{
    [String]$DocumentName
    [int]$MajorVersion
    [int]$MinorVersion
    [string]$Version
    [String]$Status
    [String]$TimeStamp
    # Muodostin tarvittavilla tiedoilla, loput lasketaan ja tallennetaan olioon
    Documentation ([string]$DocumentName,$MajorVersion,$MinorVersion,$Status)
    {
        # this on viittaus luokasta luotavaan olioon
        $this.DocumentName = $DocumentName
        $this.MajorVersion = $MajorVersion
        $this.MinorVersion = $MinorVersion
        $this.Status = $Status
        $this.Version = [String]$MajorVersion + "." + [String]$MajorVersion 
        $this.TimeStamp = Get-Date -Format o
    }
 }
$Dokumentti = [Documentation]::new("Verkkokaavio",1,3,"Luonnos")
$Dokumentti | Out-GridView