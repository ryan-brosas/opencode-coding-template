# OpenCode Plugins

Plugins in this directory extend OpenCode with focused default behavior and tools.

Memory persistence is handled externally by **Honcho** (`@honcho-ai/opencode-honcho`). Install it globally:

```bash
opencode plugin "@honcho-ai/opencode-honcho" --global
opencode
/honcho:setup
```

## Current Plugin Files

```text
plugin/
├── sessions.ts         # Session search tools (find/read)
├── skill-mcp.ts        # Skill-scoped MCP bridge (skill_mcp tools)
├── prompt-leverage.ts  # Prompt pre-processing with structured execution framing
└── rtk.ts              # Optional RTK command-output compression hook
```

## Plugin Responsibilities

- `sessions.ts`
  - Provides tools: `list_recent_sessions`, `find_sessions`, `read_session`
  - Direct SQLite access to OpenCode's session DB
  - Multi-word AND search with relevance ranking
  - 180-day time-bounded search
  - Agentic `nextStep` guidance in results

- `skill-mcp.ts`
  - Loads MCP configs from skills
  - Exposes `skill_mcp`, `skill_mcp_status`, `skill_mcp_disconnect`
  - Supports tool filtering with `includeTools`

- `prompt-leverage.ts` — prompt pre-processing with structured execution framing
- `rtk.ts` — optional RTK command-output compression hook (requires `rtk >= 0.23.0` in PATH)

## Honcho Tools

The Honcho plugin replaces the built-in memory system with these agent tools:

| Tool                       | Replaces                                         |
| -------------------------- | ------------------------------------------------ |
| `honcho_search`            | `memory-search`, `memory-get`, `memory-timeline` |
| `honcho_chat`              | `memory-get` (with reasoning)                    |
| `honcho_create_conclusion` | `observation`, `memory-update`, `memory-graph-*` |
| `honcho_status`            | `memory-admin` status                            |

Setup: `/honcho:setup` → set API key → `/honcho:status` to verify.

## Notes

- OpenCode auto-discovers every `.ts` file in `plugin/` as a plugin — keep helper modules in `lib/`.
- Keep plugin documentation aligned with actual files in this directory.

## References

- OpenCode plugin docs: https://opencode.ai/docs/plugins/
- Honcho OpenCode integration: https://honcho.dev/docs/v3/guides/integrations/opencode
- Honcho docs: https://honcho.dev/docs
