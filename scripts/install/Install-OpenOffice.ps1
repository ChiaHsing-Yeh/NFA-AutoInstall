[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\App\Apache_OpenOffice_4.1.15_Win_x86_install_zh-TW.exe"

$Result += "========================="
$Result += "Install OpenOffice"
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

$OpenOfficeInstalled = $InstalledPrograms | Where-Object {
    $_.DisplayName -like "*OpenOffice*"
}

if ($OpenOfficeInstalled)
{
    $Result += "[OK] OpenOffice already installed"
    return $Result
}

if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] OpenOffice installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing OpenOffice..."

    Start-Process `
        -FilePath $InstallerPath `
        -ArgumentList "/S" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] OpenOffice install command completed"
}
catch
{
    $Result += "[NG] OpenOffice install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result