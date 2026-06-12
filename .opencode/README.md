# OpenCode Template Assets

This directory contains the reusable OpenCode assets that sit beside the root project config.

> Active config lives at the project root: `opencode.json` and `tui.json`.
> Keep those root files with `.opencode/` when installing the template.

## Layout

```text
.opencode/
├── AGENTS.md                # Global operating rules for agents
├── dcp.jsonc                # Optional dynamic context pruning settings
├── agent/                   # 8 agent prompt files
├── command/                 # 22 slash command files
├── skill/                   # Skill library loaded on demand
├── tool/                    # Custom tools: context7.ts, grepsearch.ts
├── plugin/                  # Local OpenCode plugins and plugin SDK config
├── memory/                  # Project memory templates and seed files
├── context/                 # Prompt-injected context files
├── protocols/               # Reusable workflow/protocol docs
└── plans/                   # Local generated plans; README tracked only
```

## Core Workflow

Use this as the default coding loop:

```text
/create "describe the work" -> /plan <bead-id> -> /iterate <bead-id> -> /verify -> /ship <bead-id> -> /pr
```

There is no legacy start command in this template. If older notes mention it, use `/iterate` or `/ship` as the implementation step depending on whether you are actively editing or completing a bead.

## Inventory

Generate current counts from the filesystem:

```bash
find .opencode/agent -maxdepth 1 -name '*.md' | sort
find .opencode/command -maxdepth 1 -name '*.md' | sort
find .opencode/skill -mindepth 2 -maxdepth 2 -name 'SKILL.md' | sort
find .opencode/plugin -maxdepth 1 -name '*.ts' | sort
find .opencode/tool -maxdepth 1 -name '*.ts' | sort
```

Current high-level inventory:

- Agents: build, explore, general, painter, plan, review, scout, vision
- Commands: create, plan, iterate, verify, ship, review-codebase, status, resume, handoff, pr, plus optional design/research/autonomous helpers
- Custom tools: `context7.ts`, `grepsearch.ts`
- Local plugins: `copilot-auth.ts`, `memory.ts`, `prompt-leverage.ts`, `rtk.ts`, `sessions.ts`, `skill-mcp.ts`

## Tools vs Plugin-Provided Tools

Custom tools in `.opencode/tool/`:

- `context7` — library documentation lookup
- `grepsearch` — code/search helper

Plugin-provided tools come from local plugins in `.opencode/plugin/`, especially memory/session/skill helpers. Do not assume memory, session, or orchestration tools are present unless their plugin is enabled and loaded by your OpenCode installation.

## Plugins

Two plugin sources exist:

1. **Local plugins** in `.opencode/plugin/*.ts`
2. **NPM plugins** listed in root `opencode.json` → `plugin`

The template disables NPM plugin auto-install by default (`plugin: []`). Add and pin external plugin versions only after reviewing them.

See `.opencode/plugin/README.md` for local plugin details.

## Guardrails

- Never commit `.env` values or credentials.
- Keep generated plans and runtime logs local.
- Prefer read-only commands for exploration; ask before installs, networked MCPs, pushes, or destructive operations.
- Use `br` commands for multi-session task tracking when Beads is installed.

## Verification Baseline

Use project-specific checks when available:

```bash
npm run typecheck
npm run lint
npm run test
```

For template consistency, run:

```bash
scripts/audit-template.sh
```
