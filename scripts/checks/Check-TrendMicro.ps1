[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$TrendList = @(
    "Trend Micro Apex One Security Agent"
    "Security Agent"
    "Trend Vision One Endpoint Security"
)

$InstalledPrograms = Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
-ErrorAction SilentlyContinue

$Result += "========================="
$Result += "Trend Micro Check"
$Result += "========================="

foreach ($Trend in $TrendList)
{
    $Found = $InstalledPrograms |
        Where-Object {
            $_.DisplayName -like "*$Trend*"
        }

    if ($Found)
    {
        $Result += "[OK] $Trend"
    }
    else
    {
        $Result += "[NG] $Trend"
    }
}

return $Result