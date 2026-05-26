Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* ,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
-ErrorAction SilentlyContinue |
Where-Object {
    $_.DisplayName -like "*Office*"
} |
Select-Object DisplayName