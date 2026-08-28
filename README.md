# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.0

# Releases

### ✨ Feature

- Added privacy-preserving Temporary Chats that are excluded from normal history, cleared after leaving the page, and support model options, text-based MCP tools, Skills, knowledge bases, moderation, and Agent traces.
- Added xAI video extension with single-MP4 input, prompts, duration controls, compatible model routing, and attachment validation.
- Redesigned Agent traces to interleave reasoning and tool calls in their real execution order.
- Added structured tool cards with arguments, results, errors, source information, exit codes, copy actions, and duration.
- Added Agent run summaries showing tool-call count, reasoning rounds, and total execution time.
- Added independent preferences for automatically expanding active reasoning and active tool calls.
- Added model-aware context windows with automatic detection, presets, custom values from 4,096 to 16,000,000 tokens, and output-limit validation.
- Added bulk context-window updates with conflict detection, unchanged-value checks, and partial-failure feedback.
- Added live conversation run indicators in the sidebar for responses continuing in the background.
- Added MCP tool per-call pricing with search, filtering, selection, and bulk-pricing controls.
- Added paid-tool indicators in chat, including per-call prices and successful-call-only billing rules.
- Added MCP usage snapshots and detailed billing items. Self-use mode records usage without charging, while priced MCP calls are billed separately from model usage.
- Added administrator redemption records with filtering by user, redemption reference, code, and reward type.
- Redemption details now include code status, reward content, subscription duration, and balances before and after redemption.
- Enhanced Markdown tables and Mermaid diagrams with CSV/Markdown downloads, copy, fullscreen, zoom, reset, and multiple export formats.
- Added smoother hover expansion for the collapsed application sidebar.

### ⚡ Optimization

- Context compression now uses each model’s effective input budget, with configurable fallback windows and percentage-based trigger thresholds.
- Context compression now exposes pending, completed, and failed states and can retry unsuccessful background summaries.
- Token-budget protection now works independently from context compression, allowing oversized history to be trimmed even when rolling summaries are disabled.
- Optimized long-conversation screenshots and limited captures to the most recent or selected 100 messages.
- Improved sidebar navigation, conversation switching, search previews, recent conversations, starred conversations, and project navigation responsiveness.
- Preserved the application sidebar while navigating into the administration console, avoiding unnecessary layout and state resets.
- Added pagination and “Load more” workflows while reducing repeated capability checks in project catalogs and knowledge-base selectors.
- Added batched file-processing status queries to reduce one-request-per-file polling.
- Reduced redundant knowledge-base and file-processing refreshes by sharing processing-state updates.
- Bounded file-processing queues and background concurrency for better stability under heavy upload workloads.
- Improved chat submission coordination across queued messages, media tasks, branching, cancellation, and streaming completion.
- Added periodic authoritative run snapshots so clients can recover when stream start or finish events are missed.
- Isolated upstream `429` backoff by model route so one limited route does not block other healthy routes.
- Improved media playback with more reliable seeking, fullscreen behavior, inline controls, and progress updates.
- Improved streamed Markdown rendering, table layout, footnote navigation, and code-copy actions.
- Added graceful shutdown draining with readiness switching, active-request completion time, and clean SSE disconnection.
- Improved background-task supervision and write-pressure controls for more reliable high-load operation.

### 🐛 Fixed

- Fixed streamed Agent traces losing, duplicating, reordering, or flickering reasoning and tool-call records.
- Fixed historical conversations displaying duplicate reasoning blocks after trace-format migrations.
- Fixed reasoning timers and execution durations resetting or disappearing during streaming and after page refreshes.
- Fixed inconsistent duration formatting across reasoning steps, tool calls, message metadata, and Agent summaries.
- Fixed chat-setting changes not immediately synchronizing with active trace rendering.
- Fixed processing and execution traces being lost after editing assistant messages.
- Fixed forked conversations losing traces copied from the source conversation.
- Fixed conversation forks being created from user messages or while source history was incomplete.
- Fixed message-position navigation selecting or reporting the wrong message.
- Fixed response-outline navigation targeting stale or incorrect response sections.
- Fixed automatic scrolling becoming unstable while streamed response blocks changed height.
- Fixed queued messages continuing after their required parent response failed.
- Fixed queue completion not consistently refreshing message-position and response-outline controls.
- Fixed sidebar run indicators remaining stuck after server-side generation had finished.
- Fixed sidebar, recent, starred, project, and response navigation becoming inconsistent after rapid route changes.
- Fixed media playback state being reset during surrounding interface updates.
- Fixed project-dialog footer actions becoming inaccessible when prompts or option lists were too long.
- Fixed manually selected code losing raw characters or formatting when pasted into chat.
- Fixed text copied from web pages being reconstructed as unwanted HTML instead of preserving literal visible content.
- Fixed unsafe or malformed tags being reconstructed while normalizing tool output.
- Fixed weak-network upload retries creating duplicate file records.
- Fixed interrupted uploads leaving processing records in an incorrect state.
- Fixed file-processing polling continuing after a file completed, failed, or was removed.
- Fixed stale model and processing state affecting attachments, file mentions, file pages, and knowledge bases.
- Fixed cancelled or timed-out file-processing requests remaining active.
- Fixed inconsistent file states across chat attachments, the file manager, and knowledge-base pages.
- Fixed knowledge-base processing updates requiring a full-page refresh before appearing.
