[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\App\AvayaWorkplaceSetup3.39.0.137.17.msi"

$Result += "========================="
$Result += "Install Avaya Workplace"
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

$AvayaInstalled = $InstalledPrograms | Where-Object {
    $_.DisplayName -like "*Avaya Workplace*"
}

if ($AvayaInstalled)
{
    $Result += "[OK] Avaya Workplace already installed"
    return $Result
}

if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] Avaya Workplace installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing Avaya Workplace..."

    Start-Process msiexec.exe `
        -ArgumentList "/i `"$InstallerPath`" /qn /norestart" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] Avaya Workplace install command completed"
}
catch
{
    $Result += "[NG] Avaya Workplace install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result