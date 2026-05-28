[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\App\ChromeStandaloneSetup64.exe"

$Result += "========================="
$Result += "Install Google Chrome"
$Result += "========================="

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

$ChromeInstalled = $InstalledPrograms | Where-Object {
    $_.DisplayName -like "*Google Chrome*"
}

if ($ChromeInstalled)
{
    $Result += "[OK] Google Chrome already installed"
    return $Result
}

if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] Chrome installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing Google Chrome..."

    Start-Process `
        -FilePath $InstallerPath `
        -ArgumentList "/silent /install" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] Google Chrome install command completed"
}
catch
{
    $Result += "[NG] Google Chrome install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result