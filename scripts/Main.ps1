[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "================================"
Write-Host "NFA Auto Install Main Check V2"
Write-Host "================================"
Write-Host ""

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
Write-Host "Step 0: Admin Permission Check"
Write-Host ""

$AdminResult = .\scripts\utils\Check-Admin.ps1

$AdminResult

Write-Host ""
Write-Host "Step 1: WiFi Check"
Write-Host ""

$WifiResult = .\scripts\Checks\Check-Wifi.ps1
$WifiResult

Write-Host ""
Write-Host "Step 2: Domain Check"
Write-Host ""

$DomainResult = .\scripts\Checks\Check-Domain.ps1
$DomainResult

Write-Host ""
Write-Host "Step 3: User Check"
Write-Host ""

$UserResult = .\scripts\Checks\Check-User.ps1
$UserResult

Write-Host ""
Write-Host "Step 4: Printer Check"
Write-Host ""

$PrinterResult = .\scripts\Checks\Check-Printer.ps1
$PrinterResult

Write-Host ""
Write-Host "Step 5: Software Check"
Write-Host ""

$SoftwareResult = .\scripts\Checks\Check-Software.ps1
$SoftwareResult

Write-Host ""
Write-Host "Step 6: Office Check"
Write-Host ""

$OfficeResult = .\scripts\Checks\Check-Office.ps1
$OfficeResult

Write-Host ""
Write-Host "Step 7: Trend Micro Check"
Write-Host ""

$TrendResult = .\scripts\Checks\Check-TrendMicro.ps1
$TrendResult

Write-Host ""
Write-Host "Step 8: Generate Report"
Write-Host ""

.\scripts\utils\Generate-Report.ps1

Write-Host ""
Write-Host "================================"
Write-Host "All checks and report finished."
Write-Host "================================"