# OpenCode Coding Template

A comprehensive [OpenCode](https://opencode.ai) configuration template with curated agents, skills, commands, and plugins for AI-assisted software development.

## What's Inside

| Dir | Purpose | Size |
|---|---|---|
| `.opencode/` | Agents, commands, 90+ skills, plugins, memory, plans | ~5.8MB |
| `.beads/` | Task tracking configuration (br beads) | ~1KB |

## Agents (9)

| Agent | Model | Use For |
|---|---|---|
| **build** | Primary development | Full codebase implementation |
| **plan** | Architecture planning | Multi-phase execution design |
| **explore** | Fast search | Codebase navigation |
| **review** | Code review | Debugging, security audits |
| **scout** | External research | Library docs and patterns |
| **general** | Subagent delegation | Fast, well-defined tasks |
| **vision** | Multimodal analysis | UI/UX guidance |
| **painter** | Image generation | UI mockups, visual assets |
| **compaction** | Session summary | Context continuity |

## Commands (20+)

`/ship` · `/verify` · `/compound` · `/create` · `/plan` · `/explore` · `/research` · `/design` · `/iterate` · `/handoff` · `/curate` · `/status` · `/health` · `/pr` · `/review-codebase` · `/ui-review` · `/ui-slop-check` · `/init` · `/init-context` · `/init-user` · `/resume` · `/lfg`

## Skills (90+)

Core development, frontend design, Cloudflare, Supabase, Swift/SwiftUI, React best practices, security hardening, testing, debugging, research, swarm coordination, and more.

## Plugins

- **Memory system** — SQLite-backed project memory with hooks
- **Copilot provider** — OpenAI-compatible API adapter
- **Context7 / GrepSearch** — Documentation and code search tools

## Quick Start

```bash
# Clone into your project
cd your-project
git clone --depth 1 https://github.com/ryan-brosas/opencode-coding-template.git tmp-ock
cp -r tmp-ock/.opencode .
cp -r tmp-ock/.beads .
rm -rf tmp-ock

# Copy environment template
cp .opencode/.env.example .opencode/.env
# Edit .env with your API keys

# Start OpenCode
opencode
```

## Environment Setup

See `.opencode/.env.example` for required and optional environment variables:

- **Context7** — Library documentation (recommended)
- **Exa** — Web search and code context (recommended)
- **Gemini / OpenAI** — Code execution and multimodal features (optional)
- **Cloudflare** — Deployment features (optional)

## Task Tracking (Optional)

This template includes `.beads/` config for [br beads](https://github.com/ryan-brosas/br-beads) task tracking:

```bash
# Requires br beads installed
br init
br create "build feature X"
br claim 1
```

## License

MIT — use as a starting point for your own OpenCode configuration.
