[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Result = @()

$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$Principal = New-Object Security.Principal.WindowsPrincipal($CurrentUser)

$IsAdmin = $Principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)

$Result += "========================="
$Result += "Admin Permission Check"
$Result += "========================="

if ($IsAdmin)
{
    $Result += "[OK] Running as Administrator"
}
else
{
    $Result += "[NG] Not running as Administrator"
    $Result += "Please restart PowerShell as Administrator."
}

return $Result