[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$ExpectedDomain = "nfa.gov.tw"
$CurrentDomain = (Get-CimInstance Win32_ComputerSystem).Domain

$Result += "========================="
$Result += "Domain Check"
$Result += "========================="

if ($CurrentDomain -eq $ExpectedDomain)
{
    $Result += "[OK] Domain: $CurrentDomain"
}
else
{
    $Result += "[NG] Domain: $CurrentDomain"
    $Result += "Expected: $ExpectedDomain"
}

return $Result