# DEEIX-Chat Dockerfile for Choreo

# Version

v0.4.3

# Releases

### ✨ Features

- Added interactive UI components for assistant replies, including charts, card grids, data tables, function plots, KPI cards, Gantt charts, calculators, decision trees, text diffs, and quizzes.
- Added a personal UI component library where users can create, edit, preview, enable, disable, and delete custom components.
- Added sandboxed component rendering with optional JSON Schema validation for component inputs.
- Added time-of-day pricing multipliers for model billing. Administrators can configure different rates by weekday and time period, including overnight periods.
- Added current pricing-period details to model pricing, usage logs, and conversation billing displays.
- Added a setting to choose where toast notifications appear.
- Added artifact previews to public conversation share pages.
- Added signed MCP user-context tokens with audience binding and unique request identifiers for safer tool integrations.

### ⚡ Improvements

- Added an output settings panel in chat for selecting interactive components and visual response preferences.
- Improved streaming layout stability by pinning the message viewport before rendering updates.
- Improved user-message expansion animations and tightened message bubble typography.
- Refined interactive component transitions, sizing, previews, and responsive layouts.
- Redesigned the admin model pricing table with clearer pricing groups, tiers, and editing controls.
- Improved pricing tooltips and usage displays to show the currently applied time-based multiplier.
- Improved artifact handling and preview behavior in shared conversations.
- Improved chat screenshot and message layout calculations when messages are expanded or edited.
- Improved admin page scrolling and table interaction consistency.

### 🐛 Fixes

- Fixed message layout observers not updating correctly while editing user messages.
- Fixed streaming viewport jumps that could move the reader away from the latest response.
- Fixed interactive component state and sizing issues during long or incremental responses.
- Fixed MCP user-context tokens being reusable across unintended audiences by binding them to the target audience and a unique `jti`.
- Fixed inconsistencies between scheduled pricing, displayed model rates, usage estimates, and billing records.
- Fixed artifact previews not appearing correctly on public share pages.
- Fixed layout and typography issues in expanded user messages.
- Fixed several pricing-table alignment and control-state issues in the administration console.
