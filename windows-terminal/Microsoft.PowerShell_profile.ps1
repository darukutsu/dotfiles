#oh-my-posh init pwsh --config 1_shell | Invoke-Expression

$env:STARSHIP_CONFIG = "C:/Users/z0057w1w/linux/.config/starship.toml"
$env:Path += ";C:\Program Files\usbipd-win"
$env:PATHEXT += ";.PY"

Invoke-Expression (&starship init powershell)

#Set-Alias -Name archlinux -Value "wsl.exe --distribution-id {3ed0ef17-120f-4afa-b88e-4b30235c0244}"
Set-Alias -Name ubuntu2204 -Value "ubuntu2204.exe"

function archlinux {
	wsl.exe -d archlinux -u daru @args
}

# --- Linux-style shebang support in Windows for qutebrowser userscripts ---
# Override command execution for .py files
function Invoke-CommandIfPy {
    param($Command, $Args)

    if ($Command -match "\.py$") {
        # Run via Python Launcher (py.exe) instead of PowerShell
        py "$Command" @Args
    } else {
        & $Command @Args
    }
}
# Intercept all command calls
Set-Alias run Invoke-CommandIfPy

function sudo {
    param([Parameter(ValueFromRemainingArguments)]$Command)

    Start-Process powershell -Verb RunAs -Wait -ArgumentList '-NoProfile', '-Command', ($Command -join ' ')
}

function reboot {
    shutdown.exe /r /t 0
}

function poweroff {
    shutdown.exe /p
}
