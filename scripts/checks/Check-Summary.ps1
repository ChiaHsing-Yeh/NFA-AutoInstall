[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$AllResults = @()

$AllResults += .\scripts\Checks\Check-Wifi.ps1
$AllResults += .\scripts\Checks\Check-Domain.ps1
$AllResults += .\scripts\Checks\Check-User.ps1
$AllResults += .\scripts\Checks\Check-NetworkDrive.ps1
$AllResults += .\scripts\Checks\Check-SoftwareFolder.ps1
$AllResults += .\scripts\Checks\Check-Printer.ps1
$AllResults += .\scripts\Checks\Check-Software.ps1
$AllResults += .\scripts\Checks\Check-Office.ps1
$AllResults += .\scripts\Checks\Check-TrendMicro.ps1

$OkItems = $AllResults | Where-Object { $_.ToString().Trim().StartsWith("[OK]")}
$NgItems = $AllResults | Where-Object { $_.ToString().Trim().StartsWith("[NG]")}

$OkCount = $OkItems.Count
$NgCount = $NgItems.Count
$TotalCount = $OkCount + $NgCount

$Result += "========================="
$Result += "Summary Check"
$Result += "========================="
$Result += "Total Check Items: $TotalCount"
$Result += "OK Count: $OkCount"
$Result += "NG Count: $NgCount"
$Result += ""

if ($NgCount -eq 0)
{
    $Result += "[PASS] Device Ready"
}
else
{
    $Result += "[FAIL] Device Check Failed"
    $Result += ""
    $Result += "Missing / Failed Items:"

    foreach ($Item in $NgItems)
    {
        $Result += "- $Item"
    }
}

return $Result