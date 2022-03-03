# ENHANCED INSTALLED APPLICATION INVENTORY
<# This script will scan the registry to find installed programs by detecting unistaller information or
package information of Microsoft Store application entries. The Script will not detect any portable software packages #>

# Class definitions
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
$CounterStore = 0

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

$StoreApps = Get-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\*"

# Create a new object for every Windows Store app and set properties
foreach($App in $StoreApps)
{
    $installedApp = [InstalledApp]::new()
    $installedApp.Architecture = "Microsoft Store"
    $installedApp.Name = $App.DisplayName
    $installedApp.Version = $App.DisplayVersion
    $installedApp.Vendor = $App.Publisher
    $installedApp.InstallDate = $App.InstallDate

    # Add the object to the result array
    $ResultSet += $installedApp

    # Increment the counter of 64-bit apps
    $CounterStore ++
}



Write-Warning "Scanned $Counter32bit 32-bit applications"
Write-Warning "Scanned $Counter64bit 64-bit applications"
Write-Warning "Scanned $CounterStore Microsoft Store applications"

Read-Host "Hit Enter to continue"

Write-Output $ResultSet
