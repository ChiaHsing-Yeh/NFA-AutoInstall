[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "========================="
Write-Host "NFA Auto Install"
Write-Host "PC Information Check"
Write-Host "========================="
Write-Host ""

$ComputerName = $env:COMPUTERNAME
$UserName = $env:USERNAME

$WindowsVersion = (Get-CimInstance Win32_OperatingSystem).Caption

$Domain = (Get-CimInstance Win32_ComputerSystem).Domain

Write-Host ("Computer Name: " + $ComputerName)
Write-Host ("User Name: " + $UserName)
Write-Host ("Windows: " + $WindowsVersion)
Write-Host ("Domain: " + $Domain)