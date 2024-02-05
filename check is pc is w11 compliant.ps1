# This script checks if the system is compliant with Windows 11 requirements

# Define variables
$TPM = Get-TPM
$SecureBoot = Get-FirmwareType
$Processor = Get-CimInstance Win32_Processor | Select-Object Name
$RAM = Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum | Select-Object Sum
$Disk = Get-CimInstance Win32_DiskDrive | Measure-Object Size -Sum | Select-Object Sum

# Check TPM version
if ($TPM.TPMPresent -eq $false) {
    Write-Host "TPM is not present on this system."
} elseif ($TPM.TPMVersion -lt 2.0) {
    Write-Host "TPM version is not compatible with Windows 11."
} else {
    Write-Host "TPM version is compatible with Windows 11."
}

# Check Secure Boot
if ($SecureBoot -ne "UEFI") {
    Write-Host "Secure Boot is not enabled or not supported on this system."
} else {
    Write-Host "Secure Boot is enabled and supported on this system."
}

# Check Processor
if ($Processor.Name -notmatch "^(?=.*[13579])[02468]{0,}$") {
    Write-Host "Processor is not compatible with Windows 11."
} else {
    Write-Host "Processor is compatible with Windows 11."
}

# Check RAM
if ($RAM.Sum -lt 4GB) {
    Write-Host "RAM is not sufficient for Windows 11."
} else {
    Write-Host "RAM is sufficient for Windows 11."
}

# Check Disk Space
if ($Disk.Sum -lt 64GB) {
    Write-Host "Disk space is not sufficient for Windows 11."
} else {
    Write-Host "Disk space is sufficient for Windows 11."
}