# Define variables
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$regName = "AllowDomainPINLogon"
$regValue = "1"

# Check if registry key exists
if (Test-Path $regPath) {
    # Set registry value
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Force
} else {
    # Create registry key and set value
    New-Item -Path $regPath -Force | Out-Null
    New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWORD -Force | Out-Null
}

# Enable biometric authentication
Enable-WindowsOptionalFeature -Online -FeatureName "Biometric" -All -NoRestart

# Restart computer to apply changes
Restart-Computer -Force