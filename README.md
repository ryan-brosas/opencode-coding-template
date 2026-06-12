# OpenCode Coding Template

A reusable [OpenCode](https://opencode.ai) project template for AI-assisted software development. It includes a safer default config, coding workflow commands, task tracking with Beads, and optional power-user integrations.

## What's Inside

| Path | Purpose |
|---|---|
| `opencode.json` | Root project config OpenCode loads by default |
| `tui.json` | TUI keybindings and display settings |
| `.env.example` | Minimal environment template |
| `env.integrations.example` | Optional API keys and MCP integrations |
| `.opencode/agent/` | 8 agent prompts: build, plan, explore, review, scout, general, vision, painter |
| `.opencode/command/` | 22 slash commands for create/plan/iterate/verify/ship/pr and optional workflows |
| `.opencode/skill/` | 90+ skills; coding core plus optional UI, cloud, product, and research packs |
| `.opencode/plugin/` | Local OpenCode plugins for memory/session/skill helpers |
| `.opencode/tool/` | Custom tools: Context7 and grep search |
| `.beads/` | Beads task-tracking seed/config |

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

`/lfg`, UI/design commands, research commands, and cloud/vendor skills are included for users who want the larger power-user kit, but they are not required for the core coding workflow.

## Quick Start

```bash
cd your-project
git clone --depth 1 https://github.com/ryan-brosas/opencode-coding-template.git tmp-ock

cp tmp-ock/opencode.json .
cp tmp-ock/tui.json .
cp tmp-ock/.env.example .
cp -r tmp-ock/.opencode .
cp -r tmp-ock/.beads .

rm -rf tmp-ock
cp .env.example .env
# Edit .env with your model/provider values, then start:
opencode
```

OpenCode expects `opencode.json` at the project root; this template now puts the active config there so it loads without `OPENCODE_CONFIG`.

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
- provider credential helper values such as `MAKORA_API_KEY` if you use the bundled Makora example

Optional services are documented in `env.integrations.example`.

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
