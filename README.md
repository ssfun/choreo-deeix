# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.4

# Releases

### ✨ Feature

- **Desktop app:** Added a native desktop client for macOS, Windows, and Linux, supporting both local use and connections to existing DEEIX Chat servers.
- **Local mode:** Run the bundled server directly from the desktop app, with conversations and files stored locally using SQLite and a passwordless single-user workflow.
- **Multi-server tabs:** Connect to multiple servers in one window, reorder tabs by dragging, and restore connected tabs after restarting.
- **Native desktop integration:** Added system tray support, single-instance behavior, external browser links, and macOS shortcuts for closing tabs and windows.
- **Desktop updates:** Added update checks and user-confirmed installation. Portable builds provide download notifications, while MSI builds support administrator-managed updates.
- **Windows distribution:** Added installer, MSI, portable ZIP, and optional offline WebView2 distribution support.
- **Enterprise policies:** Administrators can preconfigure or lock the server address and disable local mode or automatic updates.
- **Desktop download entry:** Added configurable desktop download links and a download entry in the web interface.
- **BYOK providers:** Users can connect model providers with their own API keys, test connections, fetch model lists, enable selected models, and replace credentials.
- **Per-model protocols:** BYOK models can individually select OpenAI, Anthropic, Google, xAI, or OpenRouter API protocols, including supported Responses and Interactions APIs.
- **Provider import links:** Added a confirmation-based import flow for provider configurations, suitable for integration with New API and One API sites.
- **BYOK administration:** Added platform controls for enabling BYOK, limiting providers per user, blocking domains, and suspending or restoring user providers.
- **Unified model catalog:** Added capability information for input/output modalities, context windows, reasoning levels, and tool support, with administrator overrides.
- **Reasoning controls:** Users can select supported reasoning levels and regenerate replies with a different reasoning setting.
- **Visual model parameters:** Added select, toggle, and numeric controls in the composer, alongside provider-native tool switches. Frequently used controls can be pinned.
- **Native file input:** Supported models and protocols can receive PDF, audio, and video attachments directly, with format and size checks and text fallback for unsupported PDFs.
- **Multimodal image embedding:** Supported embedding protocols can index image content directly, expanding image retrieval beyond OCR-derived text.
- **Stateful interactive responses:** Added formula-driven panels, sliders, and explorable diagrams whose results update as users interact.
- **Interactive illustrations:** Added sandboxed animations, 3D sketches, and process demonstrations, with side-panel viewing, source inspection, and follow-up question controls.
- **Saved interaction state:** Interactive blocks and custom renderers can save their state with a conversation and pass the current state into subsequent messages.
- **Message editing:** Added the option to save an edited user message without immediately regenerating the assistant response.
- **Processing display:** Added a preference for hiding processing steps beneath replies.
- **Large text attachments:** Large pasted text can automatically become a `.txt` attachment.
- **Vector task management:** Administrators can inspect platform-wide indexing status, search files, retry individual or selected tasks, and reprocess files with missing extracted text.
- **Error tracing:** Added persistent request error records, copyable error IDs, and matching searches across error logs, conversation events, and model-call records.
- **Encryption key rotation:** Added support for retaining previous encryption keys while stored secrets are migrated to a new key in the background.

### ⚡ Optimization

- **Model picker:** Redesigned model selection and detail views to make capabilities, context limits, pricing, and provider information easier to inspect.
- **Composer menus:** Unified the presentation of knowledge bases, MCP tools, and interactive components, with clearer selection states.
- **Quick selection:** Added knowledge bases to the composer’s mention menu and improved recent-item ordering and search behavior.
- **Parameter layout:** Users can pin up to six controls; smaller screens keep fewer controls visible to preserve composer space.
- **Media controls:** Moved image and video parameters into the composer parameter menu and improved task-specific placeholders and unavailable-state notices.
- **JSON editing:** Replaced the Monaco JSON editor with a lighter CodeMirror editor and refined parameter-editing interactions.
- **Administrator tables:** Reworked model and upstream tables and improved capability configuration and model synchronization workflows.
- **Catalog refresh:** Improved capability snapshot refresh and remote catalog filtering by synchronization status.
- **Attachment context:** File content now stays attached to its own message turn, preserving a stable reusable prompt-cache prefix.
- **Desktop resource use:** Tabs load on demand, and long-inactive tabs can release their webviews and reload when selected.
- **Local-mode interface:** Navigation and settings now reflect available capabilities, hiding unsupported multi-user, billing, and sharing functions.
- **Index recovery:** Added stalled-task detection, interrupted-task recovery, automatic progress refresh, and selective indexing that avoids rebuilding already-ready files.
- **Debug inspection:** Improved upstream request and response views with formatted/raw modes and copy actions.
- **Library navigation:** Renamed the visible Skills area to Library and aligned related navigation.
- **Rendering:** Updated Markdown and Mermaid rendering and improved loading and fallback states for interactive content.

### 🐛 Fixed

- Preserved conversation context across cancelled generations.
- Preserved attachment awareness when extracted content is unavailable.
- Kept original pasted text when automatic `.txt` conversion fails.
- Fixed provider sign-in callbacks across web and desktop, including native loopback completion.
- Fixed desktop webview cross-origin API access.
- Fixed premature branding requests before a desktop tab is bound to its server.
- Fixed Windows window controls, installation, build, and release packaging issues.
- Stabilized the desktop tab-strip height on Linux.
- Fixed composer menus and model detail panels extending outside the viewport.
- Allowed upstream model synchronization to tolerate unresolved protocols.
- Fixed unexpected caching of exported server-component responses.
- Corrected administrator log refresh and cleanup behavior.
- Restored `HTTP_PROXY` / `HTTPS_PROXY` support when SSRF protection is enabled.
- Removed API key hints from audit records and hardened provider import-link parsing.
- Improved interactive illustration title extraction and HTML entity handling.
- Addressed security advisories affecting image processing and other dependencies.

### ⏬ Download

| Platform | Download | Verified | Available |
| --- | --- | --- | --- |
| macOS · Apple silicon | `macos-arm64.dmg` | ✅ Verified | ✅ Available |
| macOS · Intel | `macos-x64.dmg` | ✅ Verified | ✅ Available |
| Linux · x86_64 | `linux-x64.AppImage` or `.deb` | ✅ Verified | ✅ Available |
| Windows · x86_64 | `windows-x64-setup.exe` | ✅ Verified | ✅ Available |
| Windows · x86_64 · MSI | `windows-x64.msi` | ✅ Verified | ✅ Available |
| Windows · x86_64 · Portable | `windows-x64-portable.zip` | ✅ Verified | ✅ Available |

Checksums are in `SHA256SUMS`. `-updater.tar.gz`, `.sig` and `latest.json` belong to the built-in updater.
