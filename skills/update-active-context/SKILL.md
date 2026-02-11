---
name: update-active-context
description: "Refresh `memory-bank/active-context.md` based on recent work and current repo state."
---

Update `memory-bank/active-context.md` to reflect the current state of work: current focus, recent changes, next steps, and open questions/risks.

Rules:
- Do not create or modify any files outside `memory-bank/active-context.md`.
- Preserve existing content where possible; make minimal edits.
- Do not invent facts. If you cannot confirm something from the repo, terminal output, or user messages, label it as an assumption or leave as TODO.
- Prefer bullet points.
- Keep the file concise (aim for 1–2 screens).

Process:
1) Confirm `memory-bank/active-context.md` exists. If not, create it using the template from `/init-memory-bank`.
2) Gather context using:
   - `git status`
   - `git diff` (and `git diff --staged` if relevant)
   - `git log -n 20 --oneline`
   - Optionally scan the repo for TODO/FIXME notes related to current work
3) Update these sections:
   - Current Focus: summarize what the repo suggests is actively being worked on
   - Recent Changes: summarize key changes based on recent commits and diffs
   - Next Steps: list concrete next tasks (smallest actionable items)
   - Open Questions / Risks: list unknowns, blockers, risky areas
4) Write changes to `memory-bank/active-context.md`.
5) Output a short summary of what changed.

Format:
- Use Markdown headings exactly as in the file.
- Use bullet lists under each section.