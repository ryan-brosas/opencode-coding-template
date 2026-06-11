# OCK — Pi Coding Template

A lean, context-free, bloat-free `.pi` system template for [pi coding agent](https://github.com/earendil-works/pi-coding-agent).

## What's Inside

| Dir | Purpose | Size |
|---|---|---|
| `.pi/` | Config, agents, skills, extensions, memory | ~50KB |
| `.beads/` | SQLite task store (br beads) | ~32KB |

**Total: <100KB** — vs 64MB with .opencode

## Quick Start

```bash
# Copy template into your project
cp -r /path/to/ock/.pi /your/project/.pi
cp -r /path/to/ock/.beads /your/project/.beads

# Initialize beads
cd /your/project && br init

# Start working
pi-messenger-swarm task create --title "build feature X"
pi-messenger-swarm task claim task-1
```

## Stack

- **br beads** — Task tracking via SQLite (`BR_TASK_STORE=1`)
- **pi-vcc** — Algorithmic context compaction at 95% (no LLM, zero-cost)
- **pi-messenger-swarm** — File-based multi-agent coordination

## Agents (5)

| Agent | Tools | Use For |
|---|---|---|
| **build** | all | Implementation |
| **plan** | read + narrow write | Planning |
| **explore** | read-only | Navigation |
| **review** | read-only | Code review |
| **scout** | read-only | Research |

## Skills (15)

`beads` · `swarm-coordination` · `verification-before-completion` · `writing-plans` · `executing-plans` · `structured-edit` · `systematic-debugging` · `context-initialization` · `memory-grounding` · `deep-research` · `playwright` · `frontend-design` · `security-and-hardening` · `skill-creator` · `think`

## Commands (4)

`/verify` · `/ship` · `/compound` · `/audit-farm`

## What This Replaces

- `.opencode/` (64MB, 99 skills, 7 agents) → `.pi/` (50KB, 15 skills, 5 agents)
- JSONL task files → SQLite via br beads
- No compaction → pi-vcc at 95%
- No coordination → swarm on project channel
