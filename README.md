# DEEIX-Chat Dockerfile for Choreo

# Version

v0.3.6

# Releases

### ✨ Feature

- Added personal and built-in knowledge bases with managed files and RAG retrieval.
- Added knowledge-base selection in chat, project-level defaults, retrieval status, and source citations in responses.
- Added message forking to create a new conversation from any completed user or assistant message while preserving its preceding context and attachments.
- Added synchronized Markdown response outlines for quickly navigating long answers.
- Added Mermaid diagram downloads in SVG, PNG, and editable MMD formats.
- Added secure SVG artifact preview and download support.
- Added Mistral OCR with configurable endpoint, API key, model, and timeout.
- Added native tool and thinking-summary support for Gemini Interactions.
- Added managed custom model icons with PNG, JPEG, and WebP uploads, deduplication, reusable icon libraries, and safe cleanup.
- Added safe deletion of unused custom model vendors.
- Added a global switch for automatic model circuit breaking while retaining per-model and per-upstream policies.

### ⚡ Optimization

- Expanded embedding support to dimensions up to 4096 across PostgreSQL and SQLite vector storage.
- Improved model protocol and upstream-binding management so route configurations remain isolated and intact during synchronization or editing.
- Improved Gemini Interactions compatibility with the official request, streaming, native-tool, reasoning, and event schemas.
- Preserved partial assistant output when reconnecting to an in-progress generation.
- Synchronized user-setting cache invalidation across multiple backend instances so changes take effect immediately.
- Improved knowledge-base file health, indexing status, availability diagnostics, and retrieval-source visibility.
- Improved content moderation configuration validation, event filtering, interrupted-generation recovery, and shared-conversation displays.
- Improved model icon validation and lifecycle management, including reference checks and delayed cleanup of unused uploads.
- Improved administration dialog consistency and permission-group table presentation.

### 🐛 Fixed

- Fixed message forks carrying invalid state, incomplete history, or inconsistent parent relationships.
- Fixed forked conversations appearing incorrectly in the sidebar or being available before message generation completed.
- Fixed upstream model binding edits losing protocol or route configuration.
- Fixed Gemini Interactions native tools, thinking summaries, streamed events, and large step indexes being parsed incorrectly.
- Fixed Mistral OCR losing Markdown structure or incorrectly buffering streamed request bodies.
- Fixed possible allocation overflow when processing large Mistral OCR requests.
- Fixed stale user preferences remaining active after settings were changed.
- Fixed EPay checkout URL construction, gateway validation, signing, error reporting, and redirect diagnostics.
- Fixed unexpected chat scrolling when interacting with or streaming around code blocks.
- Fixed interrupted chat generations failing to resume correctly after reconnecting.
- Fixed content-moderation recovery states and numeric configuration validation.

### ⚠️ Note
>  This update includes a migration to fix the vector store. Please back up your database and schedule a maintenance window before upgrading. For PostgreSQL, ensure `pgvector` is version 0.8.0 or higher. After the upgrade, please check the admin dashboard and rebuild any invalid vectors.
