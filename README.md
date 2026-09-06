# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.1

# Releases

### ✨ Features

- Introduced a tabbed command palette for chat `@` and `/` actions.
- Added on-demand expansion for complete tool call results.
- Added usage balance, lifetime spending, and yearly activity insights to subscription settings.
- Added per-user yearly activity heatmaps.
- Added project default models and inherited MCP tool settings.
- Added manual file vectorization.
- Added an admin switch to disable knowledge base capabilities.
- Added safer upstream model catalog synchronization.
- Improved temporary conversation support for tools, files, and retrieval features.

### ⚡ Improvements

- Improved chat composer focus behavior and keyboard navigation.
- Preserved saved drafts when creating a new conversation.
- Clearly separated attachment upload and file-processing states.
- Improved file preview, file list, and knowledge base detail pages.
- Unified preview layouts for sidebar search and starred conversations.
- Refined MCP and knowledge base popovers and dialogs.
- Improved empty states across announcements, files, models, logs, and settings.
- Improved code block and HTML block rendering across streamed content.
- Improved table scrolling, column sizing, and Firefox compatibility.
- Added better scroll-fade fallbacks for browsers without scroll-driven animation support.

### 🐛 Fixes

- Fixed cached prompt billing to use observed usage.
- Fixed stale conversation run indicators after generation.
- Fixed blank scrolling before model output.
- Fixed excess blank space after generation.
- Fixed long reasoning content being lost during stream recovery.
- Fixed reasoning snapshot API inconsistencies.
- Fixed multiline web text pasting into the composer.
- Fixed untagged code fences being parsed as Markdown.
- Fixed active session location handling.
- Fixed admin redemption filters and model selector styling.
- Improved SMTP delivery, authentication, and generation lifecycle stability.
