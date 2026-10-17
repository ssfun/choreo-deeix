# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.5

# Releases

### ✨ Feature

- **Desktop network settings:** Choose system proxy, manual HTTP/SOCKS5 proxy, or direct connection. Manual settings support authentication and bypass rules, with passwords stored in the system keychain. Changes take effect after restarting the app.
- **Richer Intelligent UI:** Added an image gallery with enlarged viewing, navigation, captions, and sources. Card grids can now show cover images; tables, quizzes, and statistic cards also support images.
- **Multi-provider import:** A single link can import multiple personal providers. Review each provider’s address and masked key, select models when needed, and see individual import results or retry failures.
- **Ultra reasoning level:** Added `ultra` where supported and clarified model capability and reasoning settings.
- **PDF fallback:** When text extraction fails, eligible PDFs can be sent to models that support native PDF input, subject to file and page limits.
- **Desktop notifications:** Receive a native system notification when a model reply finishes.

### ⚡ Optimization

- **Faster long conversations:** Open with the latest messages and load older history as you scroll. If the initial messages do not fill the screen, more load automatically.
- **Lighter process details:** Conversation process lists initially load summaries; full details load when expanded and can be retried if loading fails. HTTP response compression further reduces transfer size on slower connections.
- **Smoother editing and retrying:** Message edits follow your configured send shortcut without interfering with input-method selection. Retrying a reply now takes one click.
- **Clearer upload feedback:** Processing failures show their cause in chat. Partial uploads report success and failure counts, along with the first error, across chat, Files, and Knowledge Base.
- **Desktop download handling:** Downloaded images and exported files now go to the system Downloads folder, with success or failure feedback.

### 🐛 Fixed

- Fixed prices being mistaken for math and dollar signs rendering incorrectly inside formulas.
- Fixed paired, unsupported inline HTML tags causing their enclosed text to disappear.
- Fixed the statistic card layout and added fallbacks for images that fail to load in Intelligent UI.
- Fixed duplicate system-setting rows overriding valid configuration.
- Fixed profile saving on Windows Desktop by bundling the required time-zone data.
- Fixed Linux AppImage packaging that included unnecessary Wayland libraries.
- Improved macOS DMG signing and notarization reliability, including versioned package filenames; kept the Desktop download entry hidden in local mode and constrained the admin protocol menu to the viewport.

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
