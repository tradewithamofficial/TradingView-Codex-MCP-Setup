# Connect TradingView Desktop to ChatGPT / Codex using MCP

**Free course resources from Trade With AM**

Use an AI assistant to set up [TradingView MCP](https://github.com/tradesdontlie/tradingview-mcp) with Codex, then ask Codex to inspect and interact with charts in TradingView Desktop.

[**Install with ChatGPT — Step-by-Step**](INSTALL-WITH-CHATGPT.md)

**Start here:** [TradingView MCP installation video](https://youtu.be/dwptd_aNn6I) · [Trade With AM YouTube channel](https://www.youtube.com/@TradeWithAMTrading/videos)

## Start here

### 1. Installation master prompt

**[Open MASTER_INSTALLATION_PROMPT.md](MASTER_INSTALLATION_PROMPT.md)**

Open the file, click **Copy** on the large prompt code block, paste it into a **new ChatGPT conversation**, and follow **one instruction at a time**. The prompt first checks your operating system and existing software; it does not assume that you use Windows or need a special launcher.

### 2. TradingView chat prompts

**[Open TRADINGVIEW_CHAT_PROMPTS.md](TRADINGVIEW_CHAT_PROMPTS.md)**

Once installation is verified, each chart-analysis prompt appears in its **own code block with a copy button**. Copy **one prompt at a time** into your Codex session.

### 3. Optional Windows launcher

**[Open windows/START_HERE.md](windows/START_HERE.md)**

Only for Windows viewers whose normal MCP launch method cannot enable the debugging port. Includes a PowerShell launcher using Windows Application Activation Manager, and instructions to create a desktop shortcut called **TradingView – MCP Mode**.

> **Important:** This launcher starts TradingView Desktop with the debugging port; **it does not start the MCP server**. Codex manages its configured MCP server process separately. Always run `tv_health_check` to confirm the connection.

## How the connection works

```text
Codex / AI assistant
    <-> TradingView MCP server (local Node.js process)
    <-> TradingView Desktop (Chrome DevTools Protocol on port 9222)
```

The MCP server is a **separate local process**, not a Python library, Windows service, or online server. It normally starts when a configured Codex session initializes its MCP tools; it does not automatically run merely because you turn on Windows.

## Requirements and cautions

- Check the [upstream repository](https://github.com/tradesdontlie/tradingview-mcp) for its current requirements and installation method. TradingView Desktop and a valid subscription may be required for particular features/data.
- This is a **community-built, third-party integration**, not an official TradingView product. It uses TradingView's internal desktop interfaces, so updates may break it.
- The debug port is intended for local use. Don't expose `9222` to the internet or untrusted networks; don't enter broker passwords or API secrets in prompts.
- This resource covers chart interaction and analysis, **not automatic order execution**. AI analysis may be wrong. Verify everything independently.
- Use only the **latest supported instructions** from the upstream project when versions or commands change.

## Credits

- Tutorial resources: **Trade With AM**
- TradingView MCP implementation: [tradesdontlie/tradingview-mcp](https://github.com/tradesdontlie/tradingview-mcp) (separate project and maintainers)
- Older tutorial resources: [original Gist](https://gist.github.com/tradewithamofficial/6a16e3c9d835deb65d01e44e461c0a9f)

These educational prompts and the example launcher are independently provided by Trade With AM. They do not include or redistribute the upstream MCP server's code.
