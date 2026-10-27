# Trade With AM - Optional TradingView Desktop MCP-mode launcher (Windows 10/11)
# Starts an installed TradingView MSIX/Store app through Windows Application
# Activation Manager with the local debugging port enabled on 9222.
# Does NOT start the MCP server. Run only after reviewing this file.

$Port = 9222
Write-Host '=== TradingView - MCP Mode ===' -ForegroundColor Cyan
Write-Host 'This launcher starts the installed TradingView app with port 9222 enabled.'
Write-Host 'It does NOT start the TradingView MCP server.'
Write-Host ''

# Discover the CURRENT installed app package; never hardcode its version or user.
$packages = @(Get-AppxPackage -Name 'TradingView.Desktop' -ErrorAction SilentlyContinue)
if ($packages.Count -ne 1) {
    Write-Host 'Could not identify exactly one installed TradingView.Desktop MSIX package.' -ForegroundColor Red
    Write-Host 'Check the current package with: Get-AppxPackage *TradingView*'
    Read-Host 'Press Enter to close'
    exit 1
}

$package = $packages[0]
$appCandidates = @(Get-StartApps | Where-Object {
    $_.AppID -like ($package.PackageFamilyName + '!*')
})

# If the package has several app entries, prefer the TradingView.Desktop app.
$primary = @($appCandidates | Where-Object { $_.AppID -like '*!TradingView.Desktop' })
if ($primary.Count -eq 1) {
    $appId = $primary[0].AppID
} elseif ($appCandidates.Count -eq 1) {
    $appId = $appCandidates[0].AppID
} else {
    Write-Host 'Could not unambiguously determine the TradingView AppUserModelID.' -ForegroundColor Red
    Write-Host 'For diagnosis, run: Get-StartApps | Where-Object Name -like "*TradingView*"'
    Read-Host 'Press Enter to close'
    exit 1
}

Write-Host "Detected TradingView application: $appId" -ForegroundColor Green

# An existing process must close for a new instance to receive the debug flag.
$running = @(Get-Process -Name 'TradingView' -ErrorAction SilentlyContinue)
if ($running.Count -gt 0) {
    Write-Host ''
    Write-Host 'TradingView is already running.' -ForegroundColor Yellow
    Write-Host 'Save your charts and close all TradingView windows before continuing.' -ForegroundColor Yellow
    Read-Host 'After closing TradingView, press Enter to continue'
    if (@(Get-Process -Name 'TradingView' -ErrorAction SilentlyContinue).Count -gt 0) {
        Write-Host 'TradingView is still running. Launcher stopped without forcing it closed.' -ForegroundColor Red
        Read-Host 'Press Enter to close'
        exit 1
    }
}

# The COM application activation interface can launch MSIX apps with arguments,
# even when executing a file inside WindowsApps directly is not permitted.
if (-not ('TradeWithAMAppLauncher' -as [type])) {
    $source = @"
using System;
using System.Runtime.InteropServices;
public static class TradeWithAMAppLauncher {
    [ComImport, Guid("2e941141-7f97-4756-ba1d-9decde894a3d"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IApplicationActivationManager {
        IntPtr ActivateApplication([In] string appUserModelId, [In] string arguments, [In] uint options, [Out] out uint processId);
    }
    [ComImport, Guid("45BA127D-10A8-46EA-8AB7-56EA9078943C")]
    class ApplicationActivationManager { }
    public static uint Launch(string appId, string arguments) {
        var manager = (IApplicationActivationManager)new ApplicationActivationManager();
        uint processId;
        manager.ActivateApplication(appId, arguments, 0, out processId);
        return processId;
    }
}
"@
    try {
        Add-Type -TypeDefinition $source -ErrorAction Stop
    } catch {
        Write-Host "Failed to initialize Windows app activation interface: $_" -ForegroundColor Red
        Read-Host 'Press Enter to close'
        exit 1
    }
}

Write-Host "Launching TradingView with remote debugging on port $Port..." -ForegroundColor Cyan
try {
    $launchedProcessId = [TradeWithAMAppLauncher]::Launch($appId, "--remote-debugging-port=$Port")
    Write-Host "Launched application (process ID $launchedProcessId)." -ForegroundColor Green
} catch {
    Write-Host "TradingView launch failed: $_" -ForegroundColor Red
    Read-Host 'Press Enter to close'
    exit 1
}

# Check only the local listener; a complete MCP connection still needs tv_health_check.
$portOpen = $false
for ($attempt = 1; $attempt -le 15; $attempt++) {
    Start-Sleep -Seconds 2
    $client = New-Object System.Net.Sockets.TcpClient
    try {
        $asyncResult = $client.BeginConnect('127.0.0.1', $Port, $null, $null)
        if ($asyncResult.AsyncWaitHandle.WaitOne(1000) -and $client.Connected) {
            $client.EndConnect($asyncResult)
            $portOpen = $true
            break
        }
    } catch {
        # Port not ready; try again.
    } finally {
        $client.Close()
    }
    Write-Host "Still checking port $Port ($attempt/15)..."
}

Write-Host ''
if ($portOpen) {
    Write-Host "SUCCESS: localhost port $Port is reachable." -ForegroundColor Green
    Write-Host 'Next, open your configured Codex session and run tv_health_check.' -ForegroundColor Cyan
} else {
    Write-Host "WARNING: localhost port $Port did not become reachable." -ForegroundColor Yellow
    Write-Host 'Check the TradingView window and the current upstream MCP setup guide.'
}
Read-Host 'Press Enter to close this window'
