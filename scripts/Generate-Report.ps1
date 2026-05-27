[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$ComputerName = $env:COMPUTERNAME
$TimeStamp = Get-Date -Format "yyyyMMdd-HHmmss"

$ReportFolder = ".\reports"
$ReportFile = "$ReportFolder\CheckReport-$ComputerName-$TimeStamp.txt"

if (!(Test-Path $ReportFolder)) {
    New-Item -ItemType Directory -Path $ReportFolder | Out-Null
}

$WifiResult = .\scripts\Check-Wifi.ps1
$DomainResult = .\scripts\Check-Domain.ps1
$UserResult = .\scripts\Check-User.ps1
$PrinterResult = .\scripts\Check-Printer.ps1
$SoftwareResult = .\scripts\Check-Software.ps1
$OfficeResult = .\scripts\Check-Office.ps1
$TrendResult = .\scripts\Check-TrendMicro.ps1

"================================" | Out-File $ReportFile -Encoding utf8
"NFA Auto Install Report" | Out-File $ReportFile -Append -Encoding utf8
"================================" | Out-File $ReportFile -Append -Encoding utf8
"" | Out-File $ReportFile -Append -Encoding utf8

"Computer Name : $env:COMPUTERNAME" | Out-File $ReportFile -Append -Encoding utf8
"User Name     : $env:USERNAME" | Out-File $ReportFile -Append -Encoding utf8
"Windows       : $((Get-CimInstance Win32_OperatingSystem).Caption)" | Out-File $ReportFile -Append -Encoding utf8
"Domain        : $((Get-CimInstance Win32_ComputerSystem).Domain)" | Out-File $ReportFile -Append -Encoding utf8
"Report Time   : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$WifiResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$DomainResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8

$UserResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$PrinterResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$SoftwareResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$OfficeResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
$TrendResult | Out-File $ReportFile -Append -Encoding utf8

"" | Out-File $ReportFile -Append -Encoding utf8
"================================" | Out-File $ReportFile -Append -Encoding utf8
"Report generated successfully." | Out-File $ReportFile -Append -Encoding utf8
"================================" | Out-File $ReportFile -Append -Encoding utf8

Write-Host ""
Write-Host "[OK] Full report generated:"
Write-Host $ReportFile