---
purpose: Project vision, success criteria, and core principles
updated: 2026-02-12
---

# OpenCode Coding Template

## Vision

A git-cloneable OpenCode configuration template that enables developers to bootstrap AI-assisted development environments with all essential agents, commands, skills, plugins, and memory pre-configured.

Users clone this repo and copy the relevant files into their own projects to get a working OpenCode setup in minutes.

## Success Criteria

- [x] Template includes all essential files (AGENTS.md, agents, commands, skills, memory)
- [x] Integration with beads for task tracking works out-of-the-box
- [ ] Template passes `scripts/audit-template.sh` integrity checks
- [ ] Users can install in under 60 seconds via clone-and-copy
- [ ] Optional packs (`extras/`) can be selectively installed

## Target Users

### Primary

- **Solo developers** setting up AI-assisted workflows for personal projects
- **Teams** standardizing their OpenCode configuration across multiple projects

### User Needs

- Quick setup without manual file assembly
- Consistent, validated agent/command/skill configurations
- Customizable through optional packs (`extras/`)
- Integrated task tracking from day one

## Core Principles

1. **Convention over configuration** - Sensible defaults, minimal setup required
2. **Minimal but complete** - Include only essential files, no bloat
3. **Extensible** - Easy to add custom skills, commands, and optional packs
4. **Composable** - Core template plus domain-specific packs in `extras/`
5. **Git-backed** - All state and tracking integrated with git workflow

## Repository Architecture

```
opencode.json          # Root OpenCode configuration
tui.json               # TUI keybindings and display settings
.env.example           # Model selector environment variables
env.integrations.example # Optional API key references

.opencode/
├── AGENTS.md           # Global rules for all agents
├── agent/              # 6 agent definitions
├── command/            # 10 slash commands
├── skill/              # 39 core skills
├── tool/               # 2 custom tools (context7, grepsearch)
├── plugin/             # 3 local plugins (memory, sessions, skill-mcp)
├── memory/             # Memory system files
└── context/            # Prompt-injected context

extras/
├── ui-pack/            # Visual design, browser automation, Figma
├── cloud-pack/         # Cloud provider integrations
├── research-pack/      # Deep research and context engineering
├── product-pack/       # Product process and PRD helpers
├── autonomous-pack/    # Multi-agent orchestration
├── language-pack/      # Swift/SwiftUI expertise
├── org-pack/           # GitHub/Jira workflow
└── integration-pack/   # Platform integrations and DCP

.beads/                 # Task tracking configuration
scripts/                # Template integrity scripts
```

## Key Files

| File                        | Purpose                       |
| --------------------------- | ----------------------------- |
| `opencode.json`             | Root OpenCode configuration   |
| `AGENTS.md`                 | Project rules for AI agents   |
| `.env.example`              | Environment variable template |
| `scripts/audit-template.sh` | Template integrity checker    |

---

_Update this file when vision, success criteria, or principles change._
