function devshell {
  pwsh.exe -NoExit -Command '&"D:\VS\Microsoft Visual Studio\18\BuildTools\Common7\Tools\Launch-VsDevShell.ps1" -Arch arm64 -HostArch amd64 -SkipAutomaticLocation'
}

function eza-alias {
  eza -lh --group-directories-first
}

Set-Alias -Name ls -Value eza-alias
