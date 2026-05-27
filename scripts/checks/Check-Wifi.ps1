[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$ExpectedSSID = "NFA"

$WifiInfo = netsh wlan show interfaces

$CurrentSSIDLine = $WifiInfo | Where-Object {
    $_ -match "^\s*SSID\s*:"
}

$CurrentSSID = ""

if ($CurrentSSIDLine) {
    $CurrentSSID = ($CurrentSSIDLine -split ":", 2)[1].Trim()
}

$Result += "========================="
$Result += "WiFi Check"
$Result += "========================="

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