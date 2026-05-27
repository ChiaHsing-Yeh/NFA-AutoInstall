[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$RequiredPrinters = @(
    "Microsoft Print to PDF",
    "Printer01",
    "Printer02",
    "Printer03",
    "Printer04",
    "Printer05"
)

$InstalledPrinters = Get-Printer | Select-Object -ExpandProperty Name

$Result += "========================="
$Result += "Printer Check"
$Result += "========================="

foreach ($Printer in $RequiredPrinters) {
    if ($InstalledPrinters -contains $Printer) {
        $Result += "[OK] $Printer"
    }
    else {
        $Result += "[NG] $Printer"
    }
}

return $Result