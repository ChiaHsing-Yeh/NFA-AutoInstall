[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$AllResults = @()

$ScriptFiles = Get-ChildItem ".\scripts\checks\Check-*.ps1"

foreach ($Script in $ScriptFiles)
{
    if (
        $Script.Name -eq "Check-Summary.ps1" -or
        $Script.Name -eq "Check-PC.ps1"
    )
    {
        continue
    }

    $Output = & $Script.FullName

    $AllResults += $Output
}

$OKCount = ($AllResults | Where-Object {
    $_ -match "^\[OK\]"
}).Count

$NGCount = ($AllResults | Where-Object {
    $_ -match "^\[NG\]"
}).Count

$SKIPCount = ($AllResults | Where-Object {
    $_ -match "^\[SKIP\]"
}).Count

$TotalCount = $OKCount + $NGCount + $SKIPCount

$Result += "========================="
$Result += "Summary Check"
$Result += "========================="

$Result += "Total Check Items: $TotalCount"
$Result += "OK Count: $OKCount"
$Result += "NG Count: $NGCount"
$Result += "SKIP Count: $SKIPCount"

$Result += ""

if ($NGCount -eq 0)
{
    $Result += "[PASS] Device Check Passed"
}
else
{
    $Result += "[FAIL] Device Check Failed"
    $Result += ""
    $Result += "Missing / Failed Items:"

    $NGItems = $AllResults | Where-Object {
        $_ -match "^\[NG\]"
    }

    foreach ($Item in $NGItems)
    {
        $Result += "- $Item"
    }
}

return $Result