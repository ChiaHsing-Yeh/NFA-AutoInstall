$Result = @()

$ExpectedUser = "User"
$CurrentUser = $env:USERNAME

$Result += "========================="
$Result += "User Check"
$Result += "========================="

if ($CurrentUser -eq $ExpectedUser)
{
    $Result += "[OK] User: $CurrentUser"
}
else
{
    $Result += "[NG] User: $CurrentUser"
    $Result += "Expected: $ExpectedUser"
}

return $Result