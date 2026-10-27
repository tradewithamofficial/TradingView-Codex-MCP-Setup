# TradingView + Codex: Copy-and-paste chart prompts

These prompts accompany the **Trade With AM** tutorial. **Open this file on GitHub and use the copy icon at the top-right of EACH fenced code block.** Paste the copied prompt into a Codex session that has the TradingView MCP connection configured.

> Before analysis, open TradingView Desktop in MCP/debug mode and confirm that `tv_health_check` succeeds. AI-generated analysis can be wrong. Do not trade a setup unless you independently verify it and accept the risk.

---

## 1. Check the TradingView connection

```text
Use the TradingView MCP tool tv_health_check. Are you connected to my TradingView Desktop app? Tell me the exact symbol and timeframe of the chart I have open. If there is no connection, tell me what failed rather than guessing.
```

---

## 2. VWAP indicator

### A. Add VWAP and change the timeframe

```text
Change the current chart timeframe to 15 minutes and then add TradingView's built-in VWAP (Volume Weighted Average Price) indicator to the chart.
```

### B. Keep only the main VWAP line

```text
Keep only the main VWAP line. Hide the upper band, lower band, and band fill without removing the main VWAP indicator.
```

### C. Remove the VWAP indicator

```text
Remove the VWAP indicator from the current chart.
```

---

## 3. RSI analysis and divergence

### A. Analyze RSI on the 1-hour and 4-hour timeframes

```text
Analyze the current TradingView chart on both the 1-hour and 4-hour timeframes using price action together with TradingView's Relative Strength Index (RSI).

For each timeframe, check the current RSI value and tell me whether it is overbought, oversold, or neutral.

Examine the recent price action for any clear bullish or bearish RSI divergence.

If you identify a valid divergence, mark the relevant price swing highs or lows directly on the chart, along with the corresponding RSI swing points. Clearly label whether it is bullish or bearish divergence, and briefly explain why you consider it valid. Do not force divergence if the evidence is unclear.

If there is no clear divergence on either timeframe, tell me that instead.
```

### B. Remove RSI and clear drawings (destructive; review first)

```text
Remove the Relative Strength Index indicator from the current chart. Before deleting any chart drawings, tell me which drawings would be removed and ask for my confirmation. Do not delete unrelated work without permission.
```

---

## 4. Multi-timeframe support and resistance

### A. Find and draw the strongest levels

```text
Analyze the current TradingView chart and identify the strongest support and resistance levels using the 1-hour, 4-hour, and 1-day timeframes.

Focus on levels that show the strongest multi-timeframe confluence and have clearly been respected by price.

Use different visual styles to represent the relative strength of each level: thicker solid lines for the strongest levels, medium-width dashed lines for moderately strong levels, and thinner dotted lines for weaker or secondary levels, if the available drawing tools support these styles.

Briefly explain why each level is important and identify which level has the strongest overall confluence across the three timeframes.

Do not overcrowd the chart; include only the most meaningful levels.

Place all drawings from this analysis into a single Object Tree group named Support and Resistance, if the MCP tools support grouping. If any requested drawing or grouping operation fails, clearly tell me rather than claiming it succeeded.
```

---

## 5. Market structure and potential trade setups

### A. Analyze market structure and build scenarios

```text
Analyze the current TradingView chart and first determine the market structure using the 1-hour, 4-hour, and 1-day timeframes.

For each timeframe, classify the structure as bullish, bearish, or ranging and briefly explain the evidence, such as higher highs and higher lows, lower highs and lower lows, or consolidation.

Then combine that market structure analysis with the support and resistance levels and RSI information identified earlier. Based on that confluence, identify any promising potential long or short trade setups that are currently forming or could become valid soon.

For each potential setup, provide the direction (long or short), entry zone, specific conditions required before entry, stop-loss location, take-profit targets, and invalidation level. Distinguish confirmed conditions from conditions still pending.

Do not force a trade if there is no clear setup with sufficient confluence. Clearly say when there is no valid setup right now and explain what would need to develop before a trade becomes interesting.

If you identify more than one setup, rank them by your assessment of confluence without representing the ranking as a guaranteed outcome.

Draw the important entry, stop-loss, take-profit, and invalidation levels directly on the chart and place the drawings from this analysis into a single Object Tree group named Trade Setups, if supported. Report any drawing or grouping operations that could not be completed.
```

---

## Tips for writing your own prompts

Say what to analyze (**symbol, timeframe, indicators**), what output you need (**levels, scenarios, confirmations, invalidations, targets**), what chart changes you want (**indicators, drawings, labels**), and what not to do (**do not invent values, force setups, or erase unrelated drawings**).

This is a chart-analysis tutorial. No prompt here authorizes placing real trades.

**MCP implementation:** https://github.com/tradesdontlie/tradingview-mcp
