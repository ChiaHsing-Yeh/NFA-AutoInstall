[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$OfficeApps = @{
    "Access"     = "MSACCESS.EXE"
    "Excel"      = "EXCEL.EXE"
    "OneNote"    = "ONENOTE.EXE"
    "Outlook"    = "OUTLOOK.EXE"
    "PowerPoint" = "POWERPNT.EXE"
    "Publisher"  = "MSPUB.EXE"
    "Word"       = "WINWORD.EXE"
}

$OfficePaths = @(
    "$env:ProgramFiles\Microsoft Office\root\Office16",
    "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16"
)

$Result += "========================="
$Result += "Office Check"
$Result += "========================="

foreach ($App in $OfficeApps.Keys)
{
    $ExeName = $OfficeApps[$App]
    $Found = $false

    foreach ($Path in $OfficePaths)
    {
        if (Test-Path (Join-Path $Path $ExeName))
        {
            $Found = $true
            break
        }
    }

    if ($Found)
    {
        $Result += "[OK] $App"
    }
    else
    {
        $Result += "[NG] $App"
    }
}

return $Result