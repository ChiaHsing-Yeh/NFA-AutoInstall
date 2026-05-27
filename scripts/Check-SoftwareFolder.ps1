[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$SoftwareFolder =
"$env:USERPROFILE\Downloads\Software"

$Result += "========================="
$Result += "Software Folder Check"
$Result += "========================="

if (Test-Path $SoftwareFolder)
{
    $Result += "[OK] Software Folder Found"
    $Result += $SoftwareFolder
}
else
{
    $Result += "[NG] Software Folder Not Found"
    $Result += $SoftwareFolder
}

return $Result