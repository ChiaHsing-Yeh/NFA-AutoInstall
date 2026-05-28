[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$InstallerPath = "$env:USERPROFILE\Downloads\Software\App\LineInst_51563937.exe"

$Result += "========================="
$Result += "Install LINE"
$Result += "========================="

# 檢查是否已安裝
$LineInstalled = Get-ItemProperty `
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
    -ErrorAction SilentlyContinue |
    Where-Object {
        $_.DisplayName -like "*LINE*"
    }

if ($LineInstalled)
{
    $Result += "[OK] LINE already installed"
    return $Result
}

# 檢查安裝檔是否存在
if (!(Test-Path $InstallerPath))
{
    $Result += "[NG] LINE installer not found"
    $Result += "Expected: $InstallerPath"
    return $Result
}

try
{
    $Result += "[INFO] Installing LINE..."

    Start-Process `
        -FilePath $InstallerPath `
        -ArgumentList "/S" `
        -Wait `
        -ErrorAction Stop

    $Result += "[OK] LINE install command completed"
}
catch
{
    $Result += "[NG] LINE install failed"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result