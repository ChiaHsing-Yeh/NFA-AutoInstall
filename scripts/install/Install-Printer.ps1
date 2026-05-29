[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$Printers = @(
    "Printer01",
    "Printer02",
    "Printer03",
    "Printer04",
    "Printer05"
)

$Result += "========================="
$Result += "Install Printer"
$Result += "========================="

foreach ($Printer in $Printers)
{
    $Exists = Get-Printer -Name $Printer -ErrorAction SilentlyContinue

    if ($Exists)
    {
        $Result += "[OK] $Printer already exists"
        continue
    }

    try
    {
        Add-Printer `
            -Name $Printer `
            -DriverName "Microsoft Print To PDF" `
            -PortName "PORTPROMPT:"

        $Result += "[OK] $Printer created"
    }
    catch
    {
        $Result += "[NG] $Printer create failed"
        $Result += "Error: $($_.Exception.Message)"
    }
}

return $Result