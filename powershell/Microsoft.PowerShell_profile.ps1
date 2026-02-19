# Import the module
Import-Module PSFzf

# Replace 'Ctrl+R' with a fuzzy history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function devshell {
    pwsh.exe -NoExit -Command '&"D:\VS\Microsoft Visual Studio\18\Community\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64 -HostArch amd64 -SkipAutomaticLocation'
}

function eza-alias() {
    eza -lh --group-directories-first $args
}

Set-Alias -Name ls -Value eza-alias
