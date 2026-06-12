# OpenCode Plugins

Plugins in this directory extend OpenCode with focused default behavior and tools.

Optional plugins that are useful for personal/power-user setups live in `extras/integration-pack/plugin/` and are not loaded by default.

## Current Default Plugin Files

```text
plugin/
├── memory.ts           # 4-tier automated memory system (capture → distill → curate → inject)
├── sessions.ts         # Session search tools (find/read)
├── skill-mcp.ts        # Skill-scoped MCP bridge (skill_mcp tools)
└── lib/                # Shared memory/plugin support modules
```

## Plugin Responsibilities

- `memory.ts`
  - 4-tier automated knowledge system: temporal_messages → distillations → observations → memory_files
  - Captures messages automatically via `message.part.updated` events
  - Distills sessions on idle (TF-IDF, key sentence extraction)
  - Curates observations from distillations via pattern matching
  - Injects relevant knowledge into system prompt (BM25, recency, confidence scoring)
  - Manages context window via messages.transform (token budget enforcement)
  - Provides memory tools such as observation, memory-search, memory-get, memory-read, memory-update, memory-timeline, memory graph, compaction, and admin operations

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

## Optional Plugins

Moved out of the focused default:

- `extras/integration-pack/plugin/copilot-auth.ts` — GitHub Copilot provider/auth integration
- `extras/integration-pack/plugin/prompt-leverage.ts` — prompt pre-processing with structured execution framing
- `extras/integration-pack/plugin/rtk.ts` — optional RTK command-output compression hook

Copy optional plugin files into `.opencode/plugin/` only after reviewing the behavior you want to enable.

## Notes

- OpenCode auto-discovers every `.ts` file in `plugin/` as a plugin — keep helper modules in `lib/`.
- Keep plugin documentation aligned with actual files in this directory.
- Prefer shared helpers in `lib/` over duplicated utilities across plugins.

## References

- OpenCode plugin docs: https://opencode.ai/docs/plugins/
- OpenCode custom tools docs: https://opencode.ai/docs/custom-tools/
