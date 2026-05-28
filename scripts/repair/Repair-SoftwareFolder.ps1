[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$SourceFolder = "W:\Software"
$TargetFolder = "$env:USERPROFILE\Downloads\Software"

$Result += "========================="
$Result += "Repair Software Folder"
$Result += "========================="

if (!(Test-Path $SourceFolder))
{
    $Result += "[NG] Source folder not found"
    $Result += "Source: $SourceFolder"
    return $Result
}

if (Test-Path $TargetFolder)
{
    $Result += "[OK] Software Folder already exists"
    $Result += "Target: $TargetFolder"
    return $Result
}

try
{
    $Result += "[INFO] Copying Software folder..."
    $Result += "From: $SourceFolder"
    $Result += "To: $TargetFolder"

    Copy-Item -Path $SourceFolder -Destination $TargetFolder -Recurse -Force -ErrorAction Stop

    $Result += "[OK] Software Folder copied successfully"
}
catch
{
    $Result += "[NG] Failed to copy Software folder"
    $Result += "Error: $($_.Exception.Message)"
}

return $Result