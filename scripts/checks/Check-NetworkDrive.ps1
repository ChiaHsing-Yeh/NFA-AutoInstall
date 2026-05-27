[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$DriveLetter = "W:"
$ExpectedPath = "\\nfa.gov.tw\public"

$Result += "========================="
$Result += "Network Drive Check"
$Result += "========================="

$Drive = Get-PSDrive -Name "W" -ErrorAction SilentlyContinue

if ($Drive)
{
    $Result += "[OK] Drive $DriveLetter exists"
    $Result += "Root: $($Drive.Root)"
}
else
{
    $Result += "[NG] Drive $DriveLetter not found"
    $Result += "Expected: $ExpectedPath"
}

return $Result