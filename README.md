# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.2

# Releases

### ✨ Feature

- **Message deletion:** Delete individual user or assistant messages while preserving subsequent messages and reconnecting the conversation; the first message and messages being generated are protected.
- **OpenRouter image support:** Added text-to-image generation and reference-image editing, with image model discovery and streaming responses where supported.
- **Tiered pricing import:** Import OpenRouter pricing tiers, including input, output, cache-read, and cache-write rates.
- **Signed MCP user context:** MCP calls can optionally carry signed user, conversation, and request information, enabling services to verify caller context.
- **MCP header presets:** Added quick-fill request headers, JSON validation, and protection against overwriting conflicting values.
- **Embedding compatibility:** Added an option to omit the `dimensions` parameter for embedding providers that do not accept it.

### ⚡ Optimization

- **Dark theme:** Adjusted background, border, and foreground contrast for clearer visual hierarchy.
- **Per-device appearance:** Light, dark, and system modes are now saved independently on each device instead of being overwritten by account synchronization.
- **Chat navigation:** Improved message-position and response-outline navigation, including heading alignment, active-section tracking, and hover targets.
- **Markdown tables:** Refined column widths, long-text wrapping, line spacing, and explicit line-break spacing.
- **Admin scrolling:** Pages can now scroll when the pointer is over the sidebar or page margins.
- **Pricing configuration:** Added clearer price units, tier ranges, and import warnings; tier limits now use full token counts instead of thousands.
- **Upstream model status:** Clearly marks models that have disappeared from upstream catalogs and explains route availability and automatic recovery.
- **File indexing:** Added a distinct “No text” state and count, plus an option to include these files when manually rebuilding indexes.

### 🐛 Fixed

- Fixed tool-call steps disappearing during long reasoning streams and improved preservation of reasoning content across rounds.
- Fixed rendering problems caused by nested code fences.
- Fixed excessive escaping when pasting rich content as Markdown.
- Fixed model submenus shifting unexpectedly on hover or close.
- Fixed table content bleeding above sticky headers.
- Fixed light-theme flashes when loading a page with dark mode selected.
- Fixed locked accounts being reported as invalid credentials; login errors now show the remaining lock duration.
- Fixed compatibility with upstreams that only accept a single leading system message, while preserving explicit prompt-cache behavior.
- Fixed repeated extraction and reindexing of files with no readable text.
- Fixed imported cache-write pricing calculations and aligned displayed prices with billing.
- Fixed raw JSON error output during upstream model synchronization.
- Improved error handling when deleting messages or replying to a message that has already been deleted.
