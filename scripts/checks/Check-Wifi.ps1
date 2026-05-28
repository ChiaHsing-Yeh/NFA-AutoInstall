[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$Result += "========================="
$Result += "WiFi Check"
$Result += "========================="

$ComputerModel = (Get-CimInstance Win32_ComputerSystem).Model

if ($ComputerModel -match "Virtual|VirtualBox|VMware")
{
    $Result += "[SKIP] Running inside VM"
    $Result += "WiFi check skipped because VM uses virtual network adapter."
    return $Result
}

$ExpectedSSID = "NFA"

$WifiInfo = netsh wlan show interfaces

$CurrentSSIDLine = $WifiInfo | Where-Object {
    $_ -match "^\s*SSID\s*:"
}

$CurrentSSID = ""

if ($CurrentSSIDLine) {
    $CurrentSSID = ($CurrentSSIDLine -split ":", 2)[1].Trim()
}

if ($CurrentSSID -eq $ExpectedSSID)
{
    $Result += "[OK] WiFi SSID: $CurrentSSID"
}
else
{
    $Result += "[NG] WiFi SSID: $CurrentSSID"
    $Result += "Expected: $ExpectedSSID"
}

return $Result