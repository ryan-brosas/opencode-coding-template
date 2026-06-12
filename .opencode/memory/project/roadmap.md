---
purpose: Project roadmap with phases, milestones, and bead organization
updated: 2026-02-12
---

# Roadmap

## Overview

| Phase  | Goal                                              | Status      |
| ------ | ------------------------------------------------- | ----------- |
| Core   | Template with agents, commands, skills, memory    | Complete    |
| Polish | Template integrity checks, documentation, cleanup | In Progress |
| Extend | Optional packs, plugin system, customization      | Planned     |

## Phase 1: Core

**Goal:** A complete, cloneable OpenCode template with all essential files.

**Success Criteria:**

- [x] AGENTS.md with global rules for all agents
- [x] 6 agent definitions with proper tool scoping and permissions
- [x] 10 slash commands covering creation, planning, iteration, verification, shipping
- [x] 39 core skills for common coding workflows
- [x] 3 local plugins (memory, sessions, skill-mcp)
- [x] 2 custom tools (context7, grepsearch)
- [x] Integration with beads for task tracking
- [x] `.env.example` for model configuration
- [x] Optional packs in `extras/`

**Out of Scope:**

- Application code or build tooling
- Language-specific project templates

---

## Phase 2: Polish

**Goal:** Improve template quality, integrity verification, and documentation.

**Success Criteria:**

- [x] `scripts/audit-template.sh` for template integrity checks
- [x] All 8 extras packs documented
- [ ] Consistent frontmatter across all skill files
- [ ] Audit: resolve dead config, broken references, stale documentation
- [ ] Audit: clean up unused model definitions in opencode.json

**Dependencies:**

- Requires Core completion

---

## Phase 3: Extend

**Goal:** Add advanced customization, optional pack improvements, and plugin support.

**Success Criteria:**

- [ ] Plugin system fully documented for custom plugin authors
- [ ] Optional pack installation guide in each pack README
- [ ] Template generator or installer script (reduces manual copy steps)
- [ ] Community contribution guidelines

**Dependencies:**

- Requires Polish completion

---

## Legend

**Status:**

- `Not Started` - No work begun
- `In Progress` - Active development
- `Complete` - All deliverables met

---

_Update this file when phases complete or roadmap changes._

---

_Update this file when phases complete or roadmap changes._
_Use `/plan` command to create detailed plans for active phases._
