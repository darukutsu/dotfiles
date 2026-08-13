# Start WSL distributions at boot
Start-Sleep -Seconds 5

# Start Arch Linux WSL in background with a persistent process
Start-Process -WindowStyle Hidden -FilePath "wsl" -ArgumentList "-d", "archlinux", "--exec", "sleep", "infinity"
Write-Host "WSL distributions started"

# Physical USB port to bind+attach to WSL (any device plugged here, any VID:PID).
# Requires running elevated (Task Scheduler: "Run with highest privileges").
$TargetLocationPath = 'PCIROOT(80)#PCI(1400)#USBROOT(0)#USB(10)#USB(4)#USB(4)'

# Detached watcher: every 3s resolve port -> current busid, then bind+attach if needed.
Start-Process -WindowStyle Hidden -FilePath "powershell" -ArgumentList @(
    '-NoProfile', '-Command', @"
`$TargetLocationPath = '$TargetLocationPath'
while (`$true) {
    try {
        `$inst = Get-PnpDevice -PresentOnly -Class USB -ErrorAction SilentlyContinue | Where-Object {
            `$paths = (Get-PnpDeviceProperty -InstanceId `$_.InstanceId ``
                -KeyName 'DEVPKEY_Device_LocationPaths' -ErrorAction SilentlyContinue).Data
            `$paths -contains `$TargetLocationPath
        } | Select-Object -First 1 -ExpandProperty InstanceId

        if (`$inst) {
            `$loc = (Get-PnpDeviceProperty -InstanceId `$inst ``
                -KeyName 'DEVPKEY_Device_LocationInfo' -ErrorAction SilentlyContinue).Data
            `$busid = `$null
            if (`$loc -match 'Port_#0*(\d+)\.Hub_#0*(\d+)') {
                `$busid = "`$(`$Matches[2])-`$(`$Matches[1])"
            }
            if (`$busid) {
                `$line = usbipd list | Select-String "^`$([regex]::Escape(`$busid))\s"
                if (`$line) {
                    `$stateText = `$line.ToString()
                    if (`$stateText -notmatch 'Shared|Attached') {
                        usbipd bind --force --busid `$busid | Out-Null
                    }
                    if (`$stateText -notmatch 'Attached') {
                        usbipd attach --wsl --busid `$busid | Out-Null
                    }
                }
            }
        }
    } catch { }
    Start-Sleep -Seconds 3
}
"@
)
Write-Host "Started USB port watcher for $TargetLocationPath"
