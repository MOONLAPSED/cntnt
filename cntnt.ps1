<#
.SYNOPSIS
This script installs and configures various software tools on a Windows virtual machine.

.DESCRIPTION
The script installs tools using Scoop, configures the environment, and launches common applications.

.NOTES
This script requires Scoop to be installed on the system.

.EXAMPLE
Run the script during the Windows virtual machine startup process.
#>

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Output "$timestamp - $message" | Tee-Object -FilePath "C:\Users\WDAGUtilityAccount\Desktop\scoop_log.txt" -Append
}

# Function to install a package using Scoop
function Install-ScoopPackage {
    param (
        [string]$package
    )
    try {
        scoop install $package
        Log-Message "Successfully installed $package."
    } catch {
        Log-Message "Failed to install $package. $_"
    }
}

Log-Message "Starting Scoop script execution."

# Add Scoop to PATH for this session
$env:SCOOP_PATH = "C:\Users\WDAGUtilityAccount\AppData\Local\Programs\Scoop\bin"
$env:PATH = "$env:PATH;$env:SCOOP_PATH"

# Introduce a delay of 3 seconds
Start-Sleep -Seconds 3

# Check if Scoop is in the PATH
if ($env:PATH -contains $env:SCOOP_PATH) {
    Log-Message "Scoop is in the PATH."
} else {
    Log-Message "Scoop is not in the PATH. Please check the installation."
    exit 1
}

# Add Scoop buckets
try {
    scoop bucket add versions
    scoop bucket add extras
    Log-Message "Scoop buckets added."
} catch {
    Log-Message "Failed to add Scoop buckets. $_"
    exit 1
}

# Install necessary packages
$packages = @(
    "git",
    "main/gh",
    "versions/vscode-insiders",
    "versions/windows-terminal-preview",
    "main/lsd",
    "extras/mambaforge"
)

foreach ($package in $packages) {
    Install-ScoopPackage $package
}

# Set desktop target and PATH additions
$desktop = "C:\Users\WDAGUtilityAccount\Desktop"
$desktopPath = "$desktop\micromamba;$desktop\Scoop\bin"
$env:PATH += ";$desktopPath"
[System.Environment]::SetEnvironmentVariable("PATH", $env:PATH, [System.EnvironmentVariableTarget]::User)
Log-Message "PATH updated with desktop additions."

# Launch common applications
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Start-Process "notepad.exe"
Start-Process "explorer.exe"
try {
    Start-Process "wt.exe" -Wait
} catch {
    Start-Process "powershell.exe"
}
Log-Message "Common applications launched."

# Function to prompt user for confirmation and run a command
function Run-Command {
    param (
        [string]$command
    )

    Write-Host "Running command: $command"

    while ($true) {
        $confirmation = Read-Host -Prompt "Proceed with installation? (Y/N/A)"
        if ($confirmation -eq "Y") {
            break
        } elseif ($confirmation -eq "N") {
            Write-Host "Installation skipped."
            return $false
        } elseif ($confirmation -eq "A") {
            $yesToAll = $true
            break
        } else {
            Write-Host "Invalid input. Please enter 'Y', 'N', or 'A'."
        }
    }

    try {
        Invoke-Expression $command 2>&1 | Tee-Object -FilePath "C:\Users\WDAGUtilityAccount\Desktop\scoop_log.txt" -Append
        return $true
    } catch {
        Write-Error "Command execution failed: $command"
        Write-Error $_.Exception.Message
        return $false
    }
}

$yesToAll = $false

if (-not $yesToAll) {
    $yesToAll = Run-Command "scoop update"
}

if ($yesToAll) {
    $extraPackages = @(
        "nerd-fonts/FiraMono-NF-Mono",
        "nerd-fonts/FiraCode-NF",
        "extras/x64dbg",
        "main/curl",
        "versions/openssl-light",
        "extras/okular",
        "extras/irfanview-lean",
        "extras/mpc-hc-fork",
        "extras/carapace-bin",
        "main/zoxide"
    )

    foreach ($package in $extraPackages) {
        Run-Command "scoop install $package"
    }
}

Log-Message "Scoop script execution completed."
