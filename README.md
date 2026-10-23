# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.6

# Releases

### ✨ Feature

 - None in this release; it is a reliability, presentation and security update.

 ### ⚡ Optimization

 - Long traces open and close smoothly: Reasoning and tool chains keep their expanded content instead of rebuilding it on every toggle, so long runs no longer freeze the conversation while expanding or collapsing.
 - Inline illustrations follow the app: Intelligent UI diagrams now use the app's cards, tables and good/bad tone colours, size themselves to their content instead of scrolling inside their own box, and no longer clip the selection ring at their edges.
 - Verifiable downloads: Every desktop asset now ships alongside SHA256SUMS in GNU coreutils format and a provenance record naming the source commit and tag it was built from.
 - Faster desktop releases: macOS builds are produced on native runners per architecture in separate platform jobs instead of one long serial job, so a release finishes with far less waiting.
 - Smaller desktop app: Unused dependencies were removed from the desktop shell.

 ### 🐛 Fixed

 - Fixed reasoning and tool steps staying on "Calling" with a timer that kept counting after the reply had finished, which happened when a tool returned binary content and its trace write failed.
 - Fixed image generation failing when a provider returned both a URL and inline bytes for the same image; the inline bytes are used and the redundant download is skipped.
 - Fixed admin pickers with long option lists trapping the mouse wheel, for both the permission-group selector and the upstream protocol menu.
 - Fixed admin log tabs being clipped on phones, where the last tabs could not be reached or tapped.
 - Fixed desktop releases being published from the wrong ref; publication now runs in the source tag context and verifies the tag before uploading.
 - Fixed macOS packaging signing checks by verifying the DMG signer's team ID, so a build signed by the wrong identity fails instead of shipping.
 - Fixed desktop builds failing with --locked when the root package version in Cargo.lock drifted from the project version.
 - Security: Certificate verification on the server and in the desktop app now rejects chains built from revoked or distrusted intermediate certificates (Go 1.26.10 with x/net 0.60.0, rustls-webpki 0.103.16, webpki-root-certs 1.0.10).
 - Security: The desktop updater no longer includes ZIP extraction support, removing a library with unpatched archive advisories.
 - Security: The JavaScript toolchain moved to Node.js 26.12.1, with supported lines documented as 22.23.4 / 24.22.1 / 26.12.1, closing eight Node.js advisories.

### ⏬ Download

| Platform | Download |
| --- | --- |
| macOS · Apple silicon | `DEEIX-Chat-0.4.6-macos-arm64.dmg` |
| macOS · Intel | `DEEIX-Chat-0.4.6-macos-x64.dmg` |
| Linux · x86_64 | `DEEIX-Chat-0.4.6-linux-x64.AppImage` or `.deb` |
| Windows · x86_64 | `DEEIX-Chat-0.4.6-windows-x64-setup.exe` |
| Windows · x86_64 · MSI | `DEEIX-Chat-0.4.6-windows-x64.msi` |
| Windows · x86_64 · Portable | `DEEIX-Chat-0.4.6-windows-x64-portable.zip` |

Checksums are in `SHA256SUMS`. `-updater.tar.gz`, `.sig` and `latest.json` belong to the built-in updater.
