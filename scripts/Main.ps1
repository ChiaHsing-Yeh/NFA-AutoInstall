[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "================================"
Write-Host "NFA Auto Install Main Check V3"
Write-Host "================================"
Write-Host ""

Write-Host "Step 0: Admin Permission Check"
Write-Host ""

$AdminResult = .\scripts\utils\Check-Admin.ps1
$AdminResult

$IsAdminFailed = $AdminResult | Where-Object {
    $_.ToString().Trim().StartsWith("[NG]")
}

if ($IsAdminFailed)
{
    Write-Host ""
    Write-Host "This script requires Administrator permission."
    Write-Host "Please restart VS Code or PowerShell as Administrator."
    Write-Host ""
    Write-Host "Process stopped."
    return
}

Write-Host ""
Write-Host "Step 1: WiFi Check"
Write-Host ""

$WifiResult = .\scripts\checks\Check-Wifi.ps1
$WifiResult

Write-Host ""
Write-Host "Step 2: Domain Check"
Write-Host ""

$DomainResult = .\scripts\checks\Check-Domain.ps1
$DomainResult

Write-Host ""
Write-Host "Step 3: User Check"
Write-Host ""

$UserResult = .\scripts\checks\Check-User.ps1
$UserResult

Write-Host ""
Write-Host "Step 4: Network Drive Check"
Write-Host ""

$NetworkDriveResult = .\scripts\checks\Check-NetworkDrive.ps1
$NetworkDriveResult

$NetworkDriveFailed = $NetworkDriveResult | Where-Object {
    $_.ToString().Trim().StartsWith("[NG]")
}

if ($NetworkDriveFailed)
{
    Write-Host ""
    Write-Host "Network Drive not found. Trying to repair..."
    Write-Host ""

    $RepairNetworkDriveResult = .\scripts\repair\Repair-NetworkDrive.ps1
    $RepairNetworkDriveResult

    Write-Host ""
    Write-Host "Re-check Network Drive"
    Write-Host ""

    $NetworkDriveResult = .\scripts\checks\Check-NetworkDrive.ps1
    $NetworkDriveResult
}

Write-Host ""
Write-Host "Step 5: Printer Check"
Write-Host ""

$PrinterResult = .\scripts\checks\Check-Printer.ps1
$PrinterResult

Write-Host ""
Write-Host "Step 6: Software Check"
Write-Host ""

$SoftwareResult = .\scripts\checks\Check-Software.ps1
$SoftwareResult

$SoftwareInstallMap = @{
    "Google Chrome"    = ".\scripts\install\Install-Chrome.ps1"
    "LINE"             = ".\scripts\install\Install-LINE.ps1"
    "VLC media player" = ".\scripts\install\Install-VLC.ps1"
    "Webex"            = ".\scripts\install\Install-Webex.ps1"
    "OpenOffice"       = ".\scripts\install\Install-OpenOffice.ps1"
    "Avaya Workplace"  = ".\scripts\install\Install-AvayaWorkplace.ps1"
}

$MissingSoftware = $SoftwareResult | Where-Object {
    $_.ToString().Trim().StartsWith("[NG]")
}

if ($MissingSoftware)
{
    Write-Host ""
    Write-Host "Missing software found. Trying to install..."
    Write-Host ""

    foreach ($Item in $MissingSoftware)
    {
        $SoftwareName = $Item.ToString().Replace("[NG]", "").Trim()

        if ($SoftwareInstallMap.ContainsKey($SoftwareName))
        {
            Write-Host ""
            Write-Host "Installing: $SoftwareName"
            Write-Host ""

            $InstallScript = $SoftwareInstallMap[$SoftwareName]
            $InstallResult = & $InstallScript
            $InstallResult
        }
        else
        {
            Write-Host "[WARN] No install script found for: $SoftwareName"
        }
    }

    Write-Host ""
    Write-Host "Re-check Software"
    Write-Host ""

    $SoftwareResult = .\scripts\checks\Check-Software.ps1
    $SoftwareResult
}

Write-Host ""
Write-Host "Step 7: Office Check"
Write-Host ""

$OfficeResult = .\scripts\checks\Check-Office.ps1
$OfficeResult

Write-Host ""
Write-Host "Step 8: Trend Micro Check"
Write-Host ""

$TrendResult = .\scripts\checks\Check-TrendMicro.ps1
$TrendResult

Write-Host ""
Write-Host "Step 9: Summary Check"
Write-Host ""

$SummaryResult = .\scripts\checks\Check-Summary.ps1
$SummaryResult

Write-Host ""
Write-Host "Step 10: Generate Report"
Write-Host ""

.\scripts\utils\Generate-Report.ps1

Write-Host ""
Write-Host "================================"
Write-Host "All checks and report finished."
Write-Host "================================"