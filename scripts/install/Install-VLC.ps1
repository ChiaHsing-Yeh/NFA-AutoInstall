[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\vlc-3.0.21-win64.exe"

$Result += "========================="
$Result += "Install VLC"
$Result += "========================="

if (Get-Command "vlc.exe" -ErrorAction SilentlyContinue)
{
    $Result += "[OK] VLC already installed"
    return $Result
}

if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] VLC installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing VLC..."

    Start-Process `
        -FilePath $InstallerPath `
        -ArgumentList "/S" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] VLC install command completed"
}
catch
{
    $Result += "[NG] VLC install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result