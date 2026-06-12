# OpenCode Coding Template

A comprehensive [OpenCode](https://opencode.ai) project template for AI-assisted software development. Includes a full coding baseline plus visual design, Figma/asset workflows, cloud, product, research, language, autonomous, and organization integrations — all under `.opencode/`.

## What's Inside

| Path                       | Count       | Purpose                                                                                     |
| -------------------------- | ----------- | ------------------------------------------------------------------------------------------- |
| `opencode.json`            | —           | Root project config; loads `.opencode/AGENTS.md`                                            |
| `tui.json`                 | —           | TUI keybindings and display settings                                                        |
| `.env.example`             | —           | Minimal environment template                                                                |
| `env.integrations.example` | —           | Optional API keys and MCP integrations                                                      |
| `.opencode/agent/`         | 8 agents    | build, plan, explore, review, scout, general, vision, painter                               |
| `.opencode/command/`       | 16 commands | create/plan/iterate/verify/ship/pr + design/ui-review + research/lfg/health                 |
| `.opencode/skill/`         | 98 skills   | coding, frontend, design, cloud, product, research, org, language, and autonomous workflows |
| `.opencode/plugin/`        | 4 plugins   | sessions, skill-mcp, prompt-leverage, rtk                                                   |
| `.opencode/tool/`          | 2 tools     | Context7 and grep search                                                                    |
| `.beads/`                  | —           | Beads task-tracking seed/config                                                             |

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

rm -rf tmp-ock
cp .env.example .env
# Edit .env with your model/provider values, then start:
opencode
```

OpenCode expects `opencode.json` at the project root; this template puts the active config there so it loads without `OPENCODE_CONFIG`.

## Memory Persistence (Honcho)

Memory is handled by **Honcho** (`@honcho-ai/opencode-honcho`), a cloud-native memory system installed globally.

```bash
opencode plugin "@honcho-ai/opencode-honcho" --global
opencode
/honcho:setup  # Set API key
/honcho:status # Verify
```

Provides: `honcho_search`, `honcho_chat`, `honcho_create_conclusion` for search, reasoning, and persistence.

## Plugin Notes

Two optional plugins require runtime dependencies:

- `prompt-leverage.ts` — prompt pre-processing with structured execution framing
- `rtk.ts` — RTK command-output compression (requires `rtk >= 0.23.0` in PATH)

Plugins are auto-discovered; remove any `.ts` file you don't need.

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
