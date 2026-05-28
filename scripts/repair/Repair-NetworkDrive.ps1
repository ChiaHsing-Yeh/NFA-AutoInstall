[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$DriveLetter = "W:"
$NetworkPath = "\\nfa.gov.tw\public"

$Result += "========================="
$Result += "Repair Network Drive"
$Result += "========================="

$Existing = net use $DriveLetter 2>$null

if ($LASTEXITCODE -eq 0)
{
    $Result += "[OK] Drive $DriveLetter already exists"
    return $Result
}

$Result += "[INFO] Drive $DriveLetter not found"
$Result += "[INFO] Trying to map $DriveLetter to $NetworkPath"

net use $DriveLetter $NetworkPath /persistent:yes

if ($LASTEXITCODE -eq 0)
{
    $Result += "[OK] Drive $DriveLetter mapped successfully"
}
else
{
    $Result += "[NG] Failed to map drive $DriveLetter"
}

return $Result