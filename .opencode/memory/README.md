---
purpose: Minimal project memory seed files for OpenCode sessions
updated: 2026-06-12
---

# Project Memory

This folder provides lightweight, file-based project memory. Keep it small and project-specific.

## Actual Directory Structure

```text
memory/
├── project/              # Always-injected project context
│   ├── project.md
│   ├── tech-stack.md
│   ├── user.md
│   ├── gotchas.md
│   ├── roadmap.md
│   └── state.md
├── research/             # Optional deep-dive notes
├── _templates/           # Templates for project memory files
├── session-context.md    # Current/recent session handoff context
└── README.md
```

## How It Is Used

Root `opencode.json` injects selected files from `memory/project/` and `.opencode/context/` through `instructions[]`.

Local plugins may provide richer memory/session tools, but those tools are optional and depend on your OpenCode plugin setup. The file layout above is the portable baseline.

## Guidelines

- Keep `project/` concise; these files can affect every prompt.
- Put temporary or exploratory notes in `research/`.
- Do not store secrets, API keys, credentials, private tokens, or local-only paths.
- Prefer updating `session-context.md` for handoffs instead of committing generated session logs.
