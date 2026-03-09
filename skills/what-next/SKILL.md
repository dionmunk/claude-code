---
name: what-next
description: "Determine the highest-value next work item by inspecting repository state, recent changes, unfinished work, CLAUDE.md, and the memory-bank."
argument-hint: "[focus-area]"
---

You are deciding what to work on next in this codebase.

Inspect the repository and recommend the single best next task, plus a short prioritized backlog of alternatives.

Use the repository itself as the source of truth. Give special attention to:
- `CLAUDE.md`
- the `memory-bank/` directory

## Evidence sources

Base your recommendation on:
- `CLAUDE.md` and `memory-bank/` (especially active context, progress, plans, and conventions)
- `README*`, project docs, and planning files
- Recent git activity and unstaged/staged changes
- TODO/FIXME/HACK/XXX/WIP comments in code
- Test, config, and build files
- Roadmaps, issues, notes, or backlog documents

## Priority order

1. Explicit current priorities in `CLAUDE.md`
2. Active work and priorities documented in `memory-bank/`
3. In-progress local code changes and recent git history
4. Roadmaps, backlog docs, TODOs, and unfinished implementation evidence
5. General project structure and missing tests or broken/incomplete integrations

If guidance conflicts:
- Prefer `CLAUDE.md` for agent instructions and workflow rules
- Prefer the most current `memory-bank/` files for project status and active priorities
- Use recent code changes and git history to break ties

## Investigation guide

1. **Understand the project shape** — main app/services/packages, language/framework, uncommitted changes.
2. **Read guidance sources first** — `CLAUDE.md`, then `memory-bank/` (active context, progress, plans, conventions), then `README`.
3. **Inspect current work state** — `git status`, recent commits, local changes, partially completed work.
4. **Search for unfinished work** — TODO/FIXME/HACK/XXX/WIP markers, stubs, placeholders. Prefer items tied to active codepaths and recent changes.
5. **Evaluate candidates** by impact, urgency, alignment with `CLAUDE.md` and `memory-bank/`, readiness, risk reduction, and closeness to active work.
6. **Choose the best task**, preferring: continuation of in-progress work, explicitly called-out tasks, blockers, tasks that unlock downstream work, missing tests for recent changes, half-built implementations.

Avoid: speculative large rewrites, low-value cleanup, vague recommendations without repo evidence, ignoring `memory-bank/`.

## Output format

Return exactly these sections:

### Best next task
A concise 1-2 sentence recommendation of the single best thing to work on next.

### Why this is next
3-5 bullets explaining why, grounded in specific repo evidence.

### Evidence
A short bullet list with file paths, git clues, TODO markers, `CLAUDE.md`, or `memory-bank/` references that support the recommendation.

### First concrete step
The exact first action to take in under 15 minutes.

### Top alternatives
A numbered list of 2-4 backup next tasks, each with one short reason.

### Confidence
State `High`, `Medium`, or `Low` and explain briefly.

## Behavior rules

- Be decisive. Pick one best next task.
- Be specific. Mention concrete files, modules, workflows, or memory-bank documents.
- Do not say "it depends" unless the repo evidence is genuinely contradictory.
- Do not recommend asking humans unless the codebase truly lacks enough evidence.
- If the repository is sparse or ambiguous, still provide the best recommendation available and explain the uncertainty clearly.
- If `$ARGUMENTS` is provided, use it as a focus lens, but still verify against repo evidence.
- Never ignore `CLAUDE.md` or `memory-bank/` when they are present.

User focus or extra instruction: $ARGUMENTS
