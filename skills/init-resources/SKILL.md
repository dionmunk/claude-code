---
name: init-resources
description: "Initialize a resources/ directory scaffold for reference repos, docs, snippets, and data."
---

Create a `resources/` directory at the workspace root with a standard structure for reference material (cloned repos, snippets, docs, sample data), including a README and a manifest index.

Rules:
- Do NOT overwrite existing files.
- Do NOT delete or rename any existing files.
- If a directory or file already exists, leave it unchanged.
- Create ONLY the directories/files described below.
- After completion, print a short summary listing what was created vs what already existed.

Steps:
1) Ensure the following directories exist at the workspace root:
   - `resources/`
   - `resources/repos/`
   - `resources/snippets/`
   - `resources/docs/`
   - `resources/data/`

2) Ensure the following files exist at the workspace root:
   - `resources/README.md`
   - `resources/manifest.yml`

Templates (use these exactly for newly created files):

========================
resources/README.md
========================
# Resources

This directory contains **reference material** used during development:
- cloned repositories
- example projects
- snippets and experiments
- supporting documentation
- sample data (non-sensitive)

## Guidelines

- Treat everything here as **reference-first**.
- Do not modify third-party repos unless you are intentionally patching them.
- Prefer keeping forks/patches in your main repo (or a dedicated fork), not inside `resources/`.
- Do not store secrets here (no API keys, tokens, passwords, private certs).

## Layout

- `repos/` — cloned git repos and upstream references
- `snippets/` — small code examples, gists, scratch code
- `docs/` — PDFs, notes, vendor docs (non-secret)
- `data/` — sample payloads/fixtures (non-sensitive)

## Adding a Repo

1) Clone into `resources/repos/<name>/`
2) Add an entry to `resources/manifest.yml`
3) Note anything special (branch, tag, commit hash)

========================
resources/manifest.yml
========================
# resources/manifest.yml
# Index of reference material stored under /resources

repos: []
# Example:
# repos:
#   - name: example-repo
#     source: https://github.com/org/example-repo.git
#     pinned_ref: "v1.2.3"   # tag/branch/commit
#     purpose: "Reference implementation for X"
#     notes: "Do not edit locally; treat as read-only"

docs: []
# docs:
#   - name: vendor-api
#     path: docs/vendor-api.pdf
#     source: "Vendor portal"
#     purpose: "Integration reference"

data: []
# data:
#   - name: sample-webhook-payloads
#     path: data/webhooks/
#     purpose: "Fixtures for integration tests"
#     notes: "Sanitized; no secrets"