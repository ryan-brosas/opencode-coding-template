---
description: Save progress and context for next session
argument-hint: "<bead-id> [instructions]"
agent: build
---

# Handoff: $ARGUMENTS

Save state so the next session can pick up cleanly.

> **Workflow:** Run this when pausing work. Resume with `/resume $ARGUMENTS`.

## Parse Arguments

| Argument         | Default  | Description                        |
| ---------------- | -------- | ---------------------------------- |
| `<bead-id>`      | required | The bead to hand off               |
| `[instructions]` | none     | Extra context for the next session |

## Load Skills

```typescript
skill({ name: "beads" });
```

---

## Phase 1: Gather State (Parallel)

```bash
br show $ARGUMENTS
git status --porcelain
git branch --show-current
git rev-parse --short HEAD
Read `.beads/artifacts/$ARGUMENTS/` to check existing artifacts.
```

---

## Phase 2: Handle Uncommitted Changes

If `git status` shows uncommitted changes, ask the user:

```typescript
question({
  questions: [
    {
      header: "Uncommitted work",
      question: "You have uncommitted changes. What should we do?",
      options: [
        { label: "Commit as WIP (Recommended)", description: "git commit -m 'WIP: $ARGUMENTS'" },
        { label: "Leave uncommitted", description: "Skip commit, just write handoff" },
      ],
    },
  ],
});
```

If user chooses commit:

```bash
git add <specific-files-you-modified>
git commit -m "WIP: $ARGUMENTS - [brief description of where you stopped]"
```

**Never use `git add -A` or `git add .`** — stage only the files you modified.

---

## Phase 3: Persist Handoff via Honcho

Write the handoff as a Honcho conclusion (requires Honcho plugin):

```typescript
honcho_create_conclusion({
  context: "Session handoff: $ARGUMENTS",
  data: {
    bead: "$ARGUMENTS",
    date: "[timestamp]",
    branch: "[from git branch]",
    commit: "[from git rev-parse]",
    completed: "[completed work]",
    in_progress: "[current step]",
    blockers: "[any blockers, or None]",
    next_steps: "[next steps]",
    files_touched: ["path/to/file.ts"],
    decisions: [{ decision: "[decision]", reason: "[why]" }],
  },
});
```

Also write to `progress.txt` for git-tracked persistence:

```bash
echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Handoff: stopped at [step]" >> .beads/artifacts/$ARGUMENTS/progress.txt
```

---

## Phase 4: Record Learnings (If Any)

If you discovered patterns worth remembering:

```typescript
honcho_create_conclusion({
  context: "Learning from $ARGUMENTS",
  data: { type: "learning", narrative: "[what you learned]", keywords: "[searchable terms]" },
});
```

---

## Phase 5: Sync

```bash
br sync --flush-only
```

---

## Output

```
Handoff: $ARGUMENTS
━━━━━━━━━━━━━━━━━━━

Branch: [branch]
Commit: [hash]
Saved:  handoffs/$ARGUMENTS (memory system)

Next session: /resume $ARGUMENTS
```
