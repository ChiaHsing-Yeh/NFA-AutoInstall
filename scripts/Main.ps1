[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "================================"
Write-Host "NFA Auto Install Main Check V2"
Write-Host "================================"
Write-Host ""

Write-Host "Step 1: WiFi Check"
Write-Host ""

$WifiResult = .\scripts\Check-Wifi.ps1
$WifiResult

Write-Host ""
Write-Host "Step 2: Domain Check"
Write-Host ""

$DomainResult = .\scripts\Check-Domain.ps1
$DomainResult

Write-Host ""
Write-Host "Step 3: User Check"
Write-Host ""

$UserResult = .\scripts\Check-User.ps1
$UserResult

Write-Host ""
Write-Host "Step 4: Printer Check"
Write-Host ""

$PrinterResult = .\scripts\Check-Printer.ps1
$PrinterResult

Write-Host ""
Write-Host "Step 5: Software Check"
Write-Host ""

$SoftwareResult = .\scripts\Check-Software.ps1
$SoftwareResult

Write-Host ""
Write-Host "Step 6: Office Check"
Write-Host ""

$OfficeResult = .\scripts\Check-Office.ps1
$OfficeResult

Write-Host ""
Write-Host "Step 7: Trend Micro Check"
Write-Host ""

$TrendResult = .\scripts\Check-TrendMicro.ps1
$TrendResult

Write-Host ""
Write-Host "Step 8: Generate Report"
Write-Host ""

.\scripts\Generate-Report.ps1

Write-Host ""
Write-Host "================================"
Write-Host "All checks and report finished."
Write-Host "================================"