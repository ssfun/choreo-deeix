# DEEIX-Chat Dockerfile for Choreo

# Version

v0.3.5

# Releases

### ✨ Feature

- Added model vendor management with custom stable keys, display names, and icons.
- Added optional model display groups that organize the model picker independently from technical vendors.
- Added bulk model-group assignment and drag-and-drop ordering for groups and models.
- Added an OAuth authorization bridge with PKCE for web, desktop, and other public clients while preserving the existing 2FA and session flows.
- Added a recommended server-side OAuth callback URL alongside the legacy web callback.
- Added native xAI image and video generation with duration and resolution controls.
- Added per-second pricing for video models, with duration billing applied only after successful generation.
- Added MCP image attachment processors that convert uploaded images into text context before invoking the main model.
- Added configurable MCP image and prompt argument mappings with Data URL and raw Base64 transfer modes.
- Added project and conversation presets for MCP image processors, limited to one active processor per request.
- Added configurable SSRF hostname and CIDR allowlists for trusted private integrations.

### ⚡ Optimization

- Added support for trusted private identity-provider and model-upstream endpoints without disabling global SSRF protection.
- Revalidated every outbound redirect to prevent trusted endpoints from redirecting requests to unsafe metadata or link-local destinations.
- Secured generated-media retrieval with controlled redirects, response validation, download limits, and safer artifact persistence.
- Added persistent OpenRouter pricing caching with a 24-hour refresh window and stale-cache fallback when the upstream catalog is unavailable.
- Improved model picker organization with custom groups while keeping unassigned models grouped by their technical vendor.
- Added schema-aware MCP processor validation that detects missing image fields and unmapped required arguments.
- Improved model call logs with separate input, output, reasoning, cache, image-count, and video-duration usage details.
- Improved video-generation configuration by exposing only duration options supported by the active model.
- Updated Next.js and related frontend dependencies to address known security advisories.
- Improved redemption-code validation responses with clearer field and reason information.

### 🐛 Fixed

- Fixed image attachments bypassing their configured MCP processors.
- Fixed MCP image processors receiving incorrectly encoded images or incomplete prompt arguments.
- Fixed historical RAG evidence being recalled from unrelated conversation branches.
- Fixed retried messages inheriting token usage from their original attempts.
- Fixed Android browser speech recognition repeatedly restarting, becoming stuck, or failing without a useful error.
- Added clearer voice-input errors for microphone permissions, unavailable devices, unsupported languages, network failures, and missing speech.
- Fixed xAI video polling instability and invalid duration submissions.
- Fixed integer overflow when allocating large video debug payloads.
- Fixed generated video usage and pricing information being displayed inconsistently in model-call logs.
