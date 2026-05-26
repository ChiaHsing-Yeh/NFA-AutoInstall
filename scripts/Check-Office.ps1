[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$OfficeList = @(
    "Access"
    "Excel"
    "OneNote"
    "Outlook"
    "PowerPoint"
    "Publisher"
    "Word"
)

$InstalledPrograms = Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
-ErrorAction SilentlyContinue

$Result += "========================="
$Result += "Office Check"
$Result += "========================="

foreach ($Office in $OfficeList)
{
    $Found = $InstalledPrograms |
        Where-Object {
            $_.DisplayName -like "*$Office*"
        }

    if ($Found)
    {
        $Result += "[OK] $Office"
    }
    else
    {
        $Result += "[NG] $Office"
    }
}

return $Result