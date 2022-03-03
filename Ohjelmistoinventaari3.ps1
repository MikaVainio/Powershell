# Enhanced application inventory script

# Class definition for application objects

class InstalledApp
{
   # Properties
   [string]$Name
   [string]$Version
   [string]$InstallDate
   [string]$Vendor
   [string]$Architecture
}

# Empty array for results
$ResultSet = @()

# Reset application counters
$Counter32bit = 0
$Counter64bit = 0

# Read registry entries for 32-bit applications
$App32 = Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

# Create a new object for every 32-bit app and set properties
foreach($App in $App32)
{
    $installedApp = [InstalledApp]::new()
    $installedApp.Architecture = "32-bit"
    $installedApp.Name = $App.DisplayName
    $installedApp.Version = $App.DisplayVersion
    $installedApp.Vendor = $App.Publisher
    $installedApp.InstallDate = $App.InstallDate

    # Add the object to the result array
    $ResultSet += $installedApp

    # Increment the counter of 32-bit apps
    $Counter32bit ++
}

#  Read registry entries for 64-bit applications
$App64 = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" 

# Create a new object for every 64-bit app and set properties
foreach($App in $App64)
{
    $installedApp = [InstalledApp]::new()
    $installedApp.Architecture = "64-bit"
    $installedApp.Name = $App.DisplayName
    $installedApp.Version = $App.DisplayVersion
    $installedApp.Vendor = $App.Publisher
    $installedApp.InstallDate = $App.InstallDate

    # Add the object to the result array
    $ResultSet += $installedApp

    # Increment the counter of 64-bit apps
    $Counter64bit ++
}

Write-Warning "Scanned $Counter32bit 32-bit applications"
Write-Warning "Scanned $Counter64bit 64-bit applications"

Write-Output $ResultSet
