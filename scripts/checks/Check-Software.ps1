[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$SoftwareList = @(
    "Google Chrome",
    "LINE",
    "VLC media player",
    "Webex",
    "OpenOffice"
    "Avaya Workplace"
)

$InstalledPrograms = @()

$InstalledPrograms += Get-ItemProperty `
"HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
-ErrorAction SilentlyContinue

$InstalledPrograms += Get-ItemProperty `
"HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
-ErrorAction SilentlyContinue

$InstalledPrograms += Get-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
-ErrorAction SilentlyContinue

$Result += "========================="
$Result += "Software Check"
$Result += "========================="

foreach ($Software in $SoftwareList)
{
    $Found = $InstalledPrograms |
        Where-Object {
            $_.DisplayName -like "*$Software*"
        }

    if ($Found)
    {
        $Result += "[OK] $Software"
    }
    else
    {
        $Result += "[NG] $Software"
    }
}

return $Result