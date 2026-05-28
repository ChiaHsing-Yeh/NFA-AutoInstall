[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$DriveLetter = "W:"
$NetworkPath = "\\nfa.gov.tw\public"

$Result += "========================="
$Result += "Repair Network Drive"
$Result += "========================="

# VM 環境跳過修復，避免 net use 卡住要求輸入帳密
$ComputerModel = (Get-CimInstance Win32_ComputerSystem).Model

if ($ComputerModel -match "Virtual|VirtualBox|VMware")
{
    $Result += "[SKIP] Running inside VM"
    $Result += "Network drive repair skipped in VM environment."
    return $Result
}

# 如果來源路徑無法存取，就不要執行 net use
if (!(Test-Path $NetworkPath))
{
    $Result += "[NG] Cannot access network path"
    $Result += "Path: $NetworkPath"
    $Result += "[INFO] Please connect to company network, VPN, or login with NFA domain account."
    return $Result
}

$Existing = net use $DriveLetter 2>$null

if ($LASTEXITCODE -eq 0)
{
    $Result += "[OK] Drive $DriveLetter already exists"
    return $Result
}

$Result += "[INFO] Drive $DriveLetter not found"
$Result += "[INFO] Trying to map $DriveLetter to $NetworkPath"

cmd /c "net use $DriveLetter $NetworkPath /persistent:yes /y"

if ($LASTEXITCODE -eq 0)
{
    $Result += "[OK] Drive $DriveLetter mapped successfully"
}
else
{
    $Result += "[NG] Failed to map drive $DriveLetter"
}

return $Result