[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\App\Webex_en.msi"

$Result += "========================="
$Result += "Install Webex"
$Result += "========================="

# 檢查是否已安裝
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

$WebexInstalled = $InstalledPrograms | Where-Object {
    $_.DisplayName -like "*Webex*"
}

if ($WebexInstalled)
{
    $Result += "[OK] Webex already installed"
    return $Result
}

# 檢查安裝檔
if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] Webex installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing Webex..."

    Start-Process `
        "msiexec.exe" `
        -ArgumentList "/i `"$InstallerPath`" /qn /norestart" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] Webex install command completed"
}
catch
{
    $Result += "[NG] Webex install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result