# Install TradingView MCP with ChatGPT — Step-by-Step

Use this repository's existing [master installation prompt](MASTER_INSTALLATION_PROMPT.md)
for guided setup. You do not need to rewrite the prompt or run every step at once.

1. Open [MASTER_INSTALLATION_PROMPT.md](MASTER_INSTALLATION_PROMPT.md) on GitHub.
2. Click the copy icon at the top-right of its large prompt code block.
3. Start a new [ChatGPT conversation](https://chatgpt.com/) and paste the complete prompt.
4. Tell ChatGPT your operating system and which software you already have when asked.
   Follow one instruction at a time, then share the result before continuing.
5. If a step fails, share the error without private credentials and resolve it before
   moving on. The master prompt checks current upstream instructions and reuses
   working installations.
6. Follow the prompt's connection verification with `tv_health_check` before using
   the separate [TradingView chat prompts](TRADINGVIEW_CHAT_PROMPTS.md) in Codex.

The [README](README.md) explains the setup workflow and requirements. The
[Windows launcher guide](windows/START_HERE.md) is an optional fallback only when
the normal supported launch method cannot enable the debugging connection.
The launcher starts TradingView with debugging enabled; Codex manages the
configured MCP server separately.

Keep passwords, authentication tokens and broker/API secrets out of chat.
