---
purpose: Tech stack, constraints, and integrations for AI context injection
updated: 2026-02-24
---

# Tech Stack

This file is automatically injected into ALL AI prompts via `opencode.json` instructions[].

This repository is an **OpenCode configuration template** — it does not contain application code or build tools. The items below describe what projects using this template typically use.

## This Repository

- **Type:** Configuration template (no application code)
- **Language:** YAML/JSON/Markdown agent definitions
- **Task Tracking:** beads_rust (br) — Git-backed task tracking
- **Template Audit:** `scripts/audit-template.sh`

## Typical Downstream Stack (projects that USE this template)

- **Runtime:** Node.js >= 20.19.0
- **Language:** TypeScript (ESNext, strict mode)
- **Lint:** oxlint
- **Format:** oxfmt
- **Package Manager:** pnpm (recommended)

## Key Template Contents

| Component    | Count | Description                                    |
| ------------ | ----- | ---------------------------------------------- |
| Agents       | 6     | build, explore, general, plan, review, scout   |
| Commands     | 10    | /create, /plan, /iterate, /verify, /ship, etc. |
| Core Skills  | 39    | Reusable skill definitions                     |
| Plugins      | 3     | memory, sessions, skill-mcp                    |
| Tools        | 2     | context7, grepsearch                           |
| Extras Packs | 8     | Optional domain-specific packs                 |

## Key Constraints

- Template integrity checked via `scripts/audit-template.sh`
- Keep `.opencode/` structure minimal and focused
- Optional packs in `extras/` can be selectively copied into `.opencode/`

## Active Integrations

- **OpenCode AI:** The template itself — provides agent configs, skills, and commands
- **Beads CLI:** beads_rust (br) — Task tracking CLI

---

_Update this file when tech stack or constraints change._
_AI will capture architecture, conventions, and gotchas via the `observation` tool as it works._
