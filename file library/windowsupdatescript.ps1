$session = New-Object -ComObject Microsoft.Update.Session
$installer = $session.CreateUpdateInstaller()
$updates = $session.CreateUpdateSearcher().Search("IsInstalled=0")

if ($updates.Updates.Count -gt 0) {
    $installer.Updates = $updates.Updates
    $result = $installer.Install()

    if ($result.ResultCode -eq "2" -or $result.ResultCode -eq "3") {
        Write-Output "Updates installed successfully."
    } else {
        Write-Output "Failed to install updates. Error code: $($result.ResultCode)"
    }
} else {
    Write-Output "No updates are available."
}
