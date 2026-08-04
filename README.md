# DEEIX-Chat Dockerfile for Choreo

# Version

v0.3.4

# Releases

### ✨ Feature

- Added full-text conversation search across titles, labels, projects, metadata, and message content, with matched-message previews and paginated results.
- Added manual conversation label management, including the ability to add, remove, and clear labels.
- Added a user preference to disable automatic conversation label generation, reducing auxiliary model calls and token usage.
- Added bulk project moves for selected conversations from the Recent page.
- Added Markdown preview to the message composer.
- Added rich-text paste conversion that preserves Markdown formatting, including links, lists, tables, and code.
- Added click-to-copy support for inline code.
- Added configurable OpenAI prompt caching with Auto, Enabled, and Disabled policies; implicit and explicit cache modes; TTL; and retention controls.
- Added dynamic upstream header values for conversation IDs, session keys, request IDs, and OpenAI diagnostic request IDs, with quick-fill presets for common providers.
- Added post-settlement balances to user and administrator usage logs.
- Added detailed conversation-event inspection for administrators, including payload size information.
- Added administrative cleanup of trace events for selected conversation runs while preserving conversations, messages, attachments, calls, and billing records.

### ⚡ Optimization

- Added automatic request-route failover for eligible timeouts, rate limits, server errors, and network failures, with support for trying up to three routes before returning an error.
- Preserved historical images across multi-turn conversations so follow-up requests retain the intended visual context.
- Expanded reasoning-context compatibility for DeepSeek, Moonshot, Zhipu, Xiaomi MiMo, Alibaba Qwen, MiniMax, and OpenRouter-compatible routes.
- Added the required reasoning-history request options for providers such as Qwen when previous reasoning content is present.
- Improved MCP tool synchronization with an explicit choice between preserving locally edited names and descriptions or replacing them with server-provided metadata.
- Standardized administrator-facing storage, attachment, image, document, and full-context size settings in MB, including alignment of the default full-context limit to 2 MB.
- Prevented large file bodies from inflating conversation traces; oversized historical payloads are now safely omitted from the log viewer.
- Deferred new-conversation creation until the first message is sent, preventing empty conversations from appearing in history.
- Improved the visual selected state in announcement dialogs.
- Improved code-block styling and readability in rendered Markdown.
- Improved chat scrolling after sending messages and stabilized the viewport when streaming finishes.
- Improved desktop model-menu sizing based on available viewport space.
- Improved generation-resume cleanup so canceled or replaced resume streams cannot apply stale updates.
- Added clear validation for conversation search queries that exceed the supported 200-character limit.

### 🐛 Fixed

- Fixed failed conversation turns disappearing when the user has insufficient balance.
- Fixed interrupted generations losing reasoning content or producing incomplete usage settlement.
- Fixed stopped or failed first generations overwriting the conversation’s fallback title.
- Fixed concurrent generations and queued messages leaking between different conversation branches.
- Fixed negative account balances being clamped or displayed incorrectly in user and administrator views.
- Fixed Gemini text-only responses being handled incorrectly by media-generation flows.
- Fixed Gemini MCP tool declarations losing referenced JSON Schema definitions.
- Fixed reasoning content being omitted when cloning shared conversations.
- Fixed OpenAI prompt-cache breakpoints not rolling correctly through conversation history.
- Fixed explicit OpenAI cache history being dropped from outbound requests.
- Fixed OpenAI cache affinity and cache breakpoints not persisting across turns.
- Fixed cache-boundary handling for OpenAI-compatible relay services.
- Fixed prompt-cache affinity headers being applied to models or routes without the required capability.
- Fixed mobile Markdown tables overflowing or rendering with unusable column layouts.
- Fixed wide Markdown tables lacking accessible horizontal-scroll guidance.
- Fixed chat layout shifts during streaming and scroll-position changes after streaming completed.
- Fixed desktop model menus overflowing in constrained viewports.
- Fixed installed PWA sessions overriding the device’s system rotation lock.
- Fixed empty Markdown links being incorrectly shown as blocked links.
- Fixed copied code blocks containing an unwanted trailing newline.
- Fixed resumed generation streams retaining stale cursors or replay state after cancellation.
