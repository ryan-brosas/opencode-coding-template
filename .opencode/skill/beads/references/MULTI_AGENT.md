# Multi-Agent Beads Coordination

The focused default template keeps Beads as the task-tracking layer and leaves swarm orchestration optional.

For parallel execution with multiple subagents, install `extras/autonomous-pack` and copy its skills/commands into `.opencode/`.

## Default Beads Responsibilities

- Track task state (`open`, `in_progress`, `closed`)
- Record dependencies and blockers
- Store implementation artifacts under `.beads/artifacts/`
- Provide resumable handoff state across sessions

## Optional Autonomous Pack Responsibilities

After installing `extras/autonomous-pack`, use its swarm coordination workflows for:

- Parallel worker assignment
- Worker progress monitoring
- Multi-agent reconciliation
- Wave-based execution across independent tasks
