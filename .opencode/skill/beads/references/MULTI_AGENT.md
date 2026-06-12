# Multi-Agent Beads Coordination

Beads handles task tracking; swarm orchestration is provided by the `swarm-coordination` skill and `compound`/`lfg` commands.

## Default Beads Responsibilities

- Track task state (`open`, `in_progress`, `closed`)
- Record dependencies and blockers
- Store implementation artifacts under `.beads/artifacts/`
- Provide resumable handoff state across sessions

## Swarm Coordination

Use the swarm coordination workflows for:

- Parallel worker assignment
- Worker progress monitoring
- Multi-agent reconciliation
- Wave-based execution across independent tasks
