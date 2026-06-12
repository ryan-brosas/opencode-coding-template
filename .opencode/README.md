# OpenCode Template Assets

This directory contains the focused default OpenCode assets that sit beside the root project config. Frontend implementation, accessibility basics, UI states, and responsive behavior are part of the coding core; visual review agents, pure design/Figma/asset workflows, and browser automation are optional extras.

> Active config lives at the project root: `opencode.json` and `tui.json`.
> Keep those root files with `.opencode/` when installing the template.
> Root `opencode.json` explicitly loads `.opencode/AGENTS.md` through `instructions[]`.

## Layout

```text
.opencode/
├── AGENTS.md                # Global operating rules for agents
├── agent/                   # 6 user-facing core agent prompt files
├── command/                 # 10 core slash command files
├── skill/                   # Focused coding/frontend-implementation/workflow skill baseline
├── tool/                    # Custom tools: context7.ts, grepsearch.ts
├── plugin/                  # Core local OpenCode plugins
├── memory/                  # Project memory templates and seed files
├── context/                 # Prompt-injected context files
├── protocols/               # Reusable workflow/protocol docs
└── plans/                   # Local generated plans; README tracked only
```

Optional packs live in root `extras/` and are not loaded unless copied into `.opencode/`. DCP/opencodex plugin config is in `extras/integration-pack/dcp/`.

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

Current default inventory:

- Agents: build, explore, general, plan, review, scout (plus config-only compaction summarizer)
- Commands: create, plan, iterate, verify, ship, review-codebase, status, resume, handoff, pr
- Custom tools: `context7.ts`, `grepsearch.ts`
- Local plugins: `memory.ts`, `sessions.ts`, `skill-mcp.ts`

Optional vision/UI review agents, visual design, Figma, image generation, cloud/vendor, research/context, product/org, language, integration, and autonomous assets live under `extras/`.

## Tools vs Plugin-Provided Tools

Custom tools in `.opencode/tool/`:

- `context7` — library documentation lookup
- `grepsearch` — code/search helper

Plugin-provided tools come from local plugins in `.opencode/plugin/`, especially memory/session/skill helpers. Do not assume memory, session, or orchestration tools are present unless their plugin is enabled and loaded by your OpenCode installation.

## Plugins

Two plugin sources exist:

1. **Local plugins** in `.opencode/plugin/*.ts`
2. **NPM plugins** listed in root `opencode.json` → `plugin`

The focused default keeps only core local plugins in `.opencode/plugin/`. Optional local plugins live in `extras/integration-pack/plugin/`. NPM plugin auto-install is disabled by default (`plugin: []`). Add and pin external plugin versions only after reviewing them.

See `.opencode/plugin/README.md` for local plugin details.

## Guardrails

- Never commit `.env` values or credentials.
- Keep generated plans and runtime logs local.
- Prefer read-only commands for exploration; ask before installs, networked MCPs, pushes, or destructive operations.
- Use `br` commands for multi-session task tracking when Beads is installed.

## Verification Basic

Use project-specific checks when available (this template has no npm project by default; downstream projects should use their own):

```bash
# For downstream projects using this template:
npm run typecheck
npm run lint
npm run test
```

For template consistency, run:

```bash
scripts/audit-template.sh
```
