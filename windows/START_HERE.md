# Optional Windows 10/11 workaround: TradingView – MCP Mode

**Use this only if the upstream TradingView MCP launch method fails.** First try `tv_launch` and the upstream repository's `scripts\launch_tv_debug.bat` where appropriate, and verify with `tv_health_check`.

On some Windows Store/MSIX installations, starting TradingView by executing `TradingView.exe` inside `C:\Program Files\WindowsApps` fails with **Access is denied**, or a Codex-initiated launch fails with **spawn EPERM**. Do **not** change permissions under WindowsApps.

This optional script launches your **installed** TradingView Store app through Windows Application Activation Manager, with `--remote-debugging-port=9222`. It does not install or run an MCP server. It is a teaching example; actual success depends on the user's Windows/TradingView versions.

## 1. Get the script

Open [Start-TradingView-MCP.ps1](Start-TradingView-MCP.ps1) on GitHub and choose **Download raw file** (or copy its raw contents into a `.ps1` file). Save it in a folder of **your choosing**. Do not assume the tutorial instructor's directory exists on your computer.

## 2. Run the script

In **Windows PowerShell**, use the real path where you saved it:

```powershell
& "C:\YOUR\FOLDER\Start-TradingView-MCP.ps1"
```

If Windows blocks a **trusted file you just downloaded** because it has an internet download marker, you can unblock only that file (after reviewing it):

```powershell
Unblock-File -LiteralPath "C:\YOUR\FOLDER\Start-TradingView-MCP.ps1"
```

This might not be sufficient where an administrator has enforced an **AllSigned** or managed execution policy. Do not disable system-wide security controls; ask the assistant to diagnose the policy instead.

If TradingView is already open, the script asks you to close it before relaunching, so save your work first.

## 3. Create the desktop shortcut

Once the script works, right-click the Windows desktop → **New → Shortcut**.

In **Type the location of the item**, enter the following, substituting the **actual file path**:

```text
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -File "C:\YOUR\FOLDER\Start-TradingView-MCP.ps1"
```

Click **Next**, name it **TradingView – MCP Mode**, and click **Finish**.

Double-click this shortcut whenever you want to start TradingView with the debugging port enabled. The PowerShell window reports whether port 9222 is reachable.

> **Do not** add `-ExecutionPolicy Bypass` to the shortcut. Follow your organization's script-execution rules.

## 4. Confirm the MCP connection

Open Codex (where the TradingView MCP server was already configured) and ask:

```text
Use tv_health_check and tell me the current TradingView symbol and timeframe.
```

Port `9222` being open means the debug interface appears reachable; it does **not** by itself prove the complete Codex → MCP → TradingView workflow is working.

## When this workaround should not be used

- If the normal launcher already works, keep using it.
- If you are on macOS or Linux, follow the upstream platform-specific guide.
- If the script cannot find the app's AppUserModelID, inspect the installed package; do not guess package IDs or alter WindowsApps permissions.

Upstream documentation: https://github.com/tradesdontlie/tradingview-mcp/blob/main/SETUP_GUIDE.md
