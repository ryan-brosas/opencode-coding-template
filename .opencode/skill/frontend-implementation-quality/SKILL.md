---
name: frontend-implementation-quality
description: Lightweight frontend engineering quality gates for coding work: semantic HTML, accessibility basics, UI states, responsive behavior, keyboard behavior, forms, tests, and browser smoke checks.
---

# Frontend Implementation Quality

Use this for frontend coding changes: React, Next.js, TypeScript UI, HTML, CSS, component behavior, browser interactions, and UI-facing state changes.

## Core Principle

Frontend is coding. Treat UI changes as implementation work with behavior, state, accessibility, and regression risks — not as optional visual polish.

## Checklist

### Semantics and Structure

- Use semantic HTML elements before generic `div`/`span` wrappers.
- Labels, headings, landmarks, and button/link roles match user intent.
- Interactive elements are native where possible (`button`, `a`, `input`, `select`).

### Accessibility Basics

- Keyboard navigation reaches every interactive control.
- Focus states are visible and not removed without replacement.
- Form controls have labels and clear validation messages.
- Color is not the only signal for errors, status, or selection.
- Check WCAG AA contrast when colors changed.

### UI State Coverage

For each async or data-driven surface, verify relevant states:

- Loading
- Empty
- Error
- Success
- Disabled/submitting
- Partial data or permission-limited views

### Responsive Behavior

- Check small, medium, and desktop layouts when layout changes.
- Avoid horizontal scroll unless intentionally designed.
- Touch targets are usable on mobile.
- Content reflows without clipping or overlap.

### Component Behavior

- Props and state transitions are explicit and tested where practical.
- Error boundaries or fallback paths exist for risky rendering paths.
- Event handlers avoid stale closures and duplicate side effects.
- Client/server boundaries are intentional in React/Next.js.

### Forms and Validation

- Validate before destructive or expensive actions.
- Preserve user input after recoverable errors.
- Show server errors in user language.
- Disable or debounce duplicate submissions.

### Verification

Prefer project-specific commands. If available, run:

```bash
npm run typecheck
npm run lint
npm run test
```

For UI-facing changes, also perform at least one browser smoke check or explain why it was not possible.

## When to Use Optional UI Pack

Install `extras/ui-pack` only for heavier design workflows:

- Figma MCP or mockup extraction
- Image generation or painter workflows
- Brand extraction
- Visual art direction or aesthetic redesign
- Detailed screenshot/mockup critique beyond implementation QA

## Output

When reporting frontend work, include:

- Files/components changed
- States verified
- Accessibility checks performed
- Responsive/browser checks performed
- Tests or commands run
- Any unverifiable UI risks
