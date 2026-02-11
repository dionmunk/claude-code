---
name: update-progress
description: "Refresh `memory-bank/progress.md` (completed / in progress / planned / tech debt)."
---

Update `memory-bank/progress.md` to reflect current project status, what's completed, what's in progress, what's planned next, and known issues/tech debt.

Rules:
- Do not create or modify any files outside `memory-bank/progress.md`.
- Preserve existing content where possible; make minimal edits.
- Do not invent facts. If you cannot confirm something from the repo, terminal output, or user messages, label it as TODO.
- Keep items short and scannable.
- Keep the file concise (aim for 1–2 screens).

Process:
1) Confirm `memory-bank/progress.md` exists. If not, create it using the template from `/init-memory-bank`.
2) Gather context using:
   - `git log -n 50 --oneline --decorate`
   - `git status`
   - `git diff` (and `git diff --staged` if relevant)
   - Search for open TODO/FIXME notes (optional)
   - If an issue tracker is not available, infer “Planned” conservatively and use TODO markers.
3) Update these sections:
   - Status: summarize the current phase/maturity (use TODO if unclear)
   - Completed: add recently completed milestones/features
   - In Progress: list active work items
   - Planned: list next milestones (avoid speculation; use TODO if unknown)
   - Known Issues / Tech Debt: list bugs, gaps, refactors needed (from TODO/FIXME, diffs, or known items)
4) Write changes to `memory-bank/progress.md`.
5) Output a short summary of what changed.

Format:
- Use Markdown headings exactly as in the file.
- Use bullet lists under each section.