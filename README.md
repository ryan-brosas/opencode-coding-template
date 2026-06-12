# OpenCode Coding Template

A reusable [OpenCode](https://opencode.ai) project template for AI-assisted software development. The default install is a focused coding baseline including backend and frontend engineering; pure visual design, Figma/asset workflows, cloud, product, research, language, and autonomous workflows live in optional `extras/` packs.

## What's Inside

| Path | Purpose |
|---|---|
| `opencode.json` | Root project config OpenCode loads by default |
| `tui.json` | TUI keybindings and display settings |
| `.env.example` | Minimal environment template |
| `env.integrations.example` | Optional API keys and MCP integrations |
| `.opencode/agent/` | 7 user-facing core agents: build, plan, explore, review, scout, general, vision (plus config-only compaction summarizer) |
| `.opencode/command/` | 11 core slash commands for create/plan/iterate/verify/ship/pr plus frontend review |
| `.opencode/skill/` | Focused coding/frontend/workflow skill baseline |
| `.opencode/plugin/` | Core local plugins: memory, sessions, skill MCP |
| `.opencode/tool/` | Custom tools: Context7 and grep search |
| `.beads/` | Beads task-tracking seed/config |
| `extras/` | Optional UI, cloud, research, product, org, language, integration, and autonomous packs |

## Core Workflow

Recommended coding loop:

```text
/create "describe the work"
/plan <bead-id>
/iterate <bead-id>
/verify
/ship <bead-id>
/pr
```

## Quick Start

```bash
cd your-project
git clone --depth 1 https://github.com/ryan-brosas/opencode-coding-template.git tmp-ock

cp tmp-ock/opencode.json .
cp tmp-ock/tui.json .
cp tmp-ock/.env.example .
cp -r tmp-ock/.opencode .
cp -r tmp-ock/.beads .
cp -r tmp-ock/extras .   # optional packs; safe to omit if you only want the core

rm -rf tmp-ock
cp .env.example .env
# Edit .env with your model/provider values, then start:
opencode
```

OpenCode expects `opencode.json` at the project root; this template puts the active config there so it loads without `OPENCODE_CONFIG`.

## Optional Packs

Copy only the packs you want into `.opencode/`:

```bash
# Example: add optional visual/design workflows
cp -r extras/ui-pack/agent/* .opencode/agent/ 2>/dev/null || true
cp -r extras/ui-pack/command/* .opencode/command/ 2>/dev/null || true
cp -r extras/ui-pack/skill/* .opencode/skill/ 2>/dev/null || true
```

Available packs:

- `extras/ui-pack` — optional visual design, Figma, image, browser automation, and mockup workflows
- `extras/cloud-pack` — Cloudflare, Supabase, Resend, Polar, Vercel helpers
- `extras/research-pack` — deep research, context engineering, Webclaw, prompt leverage
- `extras/product-pack` — PRD, brainstorming, init/explore/health commands
- `extras/org-pack` — GitHub/Jira workflow helpers
- `extras/language-pack` — Swift/Core Data specialists
- `extras/autonomous-pack` — LFG/compound/swarm workflows
- `extras/integration-pack` — optional local plugins and DCP/opencodex config

## Security Defaults

The template is intentionally conservative:

- Broad shell execution defaults to `ask`, not `allow`
- Read-only search/git commands are allowed
- Destructive commands such as `rm*` and `sudo*` are denied
- NPM plugin auto-install is disabled by default (`plugin: []`)
- Optional MCP servers are disabled until you enable them intentionally
- `.env`, credentials, logs, generated plans, and runtime state are ignored

## Environment Setup

Minimal setup lives in `.env.example`:

- `OPENCODE_MODEL`
- `OPENCODE_SMALL_MODEL`
- `OPENCODE_PLAN_MODEL`

Provider auth is normally handled with `opencode auth login <provider>`. Optional service-specific API keys are documented in `env.integrations.example`.

## Beads Task Tracking

This template includes `.beads/` config for Beads task tracking. Generated artifacts are local by default.

```text
.beads/
  config.yaml       # tracked template config
  issues.jsonl      # tracked seed/task state
  metadata.json     # tracked metadata
  artifacts/        # generated PRDs/plans/reviews; ignored by default
  *.db              # generated local database files; ignored
```

## Template Audit

Run the lightweight self-check after modifying the template:

```bash
scripts/audit-template.sh
```

## License

MIT — use this as a starting point for your own OpenCode configuration.
