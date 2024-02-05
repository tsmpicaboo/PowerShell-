# This script deploys Microsoft Intune to a device using PowerShell

# Define variables
$IntuneInstaller = "C:\IntuneInstaller.exe"
$IntuneCommandLineArgs = "/silent /install"
$IntuneLogFilePath = "C:\IntuneInstallLog.txt"

# Run the Intune installer with the specified command line arguments and log file path
Start-Process -FilePath $IntuneInstaller -ArgumentList $IntuneCommandLineArgs -Wait -NoNewWindow -PassThru | Out-File -FilePath $IntuneLogFilePath

# Check if the installation was successful by searching for a specific string in the log file
$IntuneInstallSuccessString = "Installation completed successfully"
$IntuneInstallLogContent = Get-Content -Path $IntuneLogFilePath
if ($IntuneInstallLogContent -match $IntuneInstallSuccessString) {
    Write-Host "Microsoft Intune was successfully installed."
} else {
    Write-Host "Microsoft Intune installation failed. Please check the log file at $IntuneLogFilePath for more information."
}