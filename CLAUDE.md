# AI-Assisted Development Instructions

These instructions guide how you should work when helping develop code for this project.

## AI Assistant Behavior

When working on code in this project:

- **Ask Before Major Changes**: Request confirmation before making architectural changes, significant refactors, or changes to core logic
- **Provide Context**: Explain your changes, reasoning, and any trade-offs you're making
- **Incremental Approach**: Make small, focused changes rather than attempting large refactors in one go
- **Testing**: Include or update tests with code changes where applicable
- **Documentation**: Update relevant documentation, comments, and docstrings when changing functionality
- **Error Handling**: Include proper error handling in all generated code
- **Review Before Suggesting**: Verify your code meets all standards before suggesting it

## Project Memory Behavior

- Before answering, planning, or modifying code, you **must** consult all relevant files under the `memory-bank/` directory.
- If required information is missing, outdated, or contradictory, **stop and ask for clarification** before proceeding.
- If your proposed action conflicts with guidance in `memory-bank/`, **explicitly call out the conflict and do not proceed** until it is resolved.
- If `memory-bank/` files cannot be accessed or do not exist, **pause and request confirmation** before continuing.

## Planning Behavior

- Plans should be stored in the `plans/` directory at the project base
- Name plan files with a date prefix and a 1-4 word description: `YYYY-MM-DD-short-description.md` (e.g. `2026-02-13-implement-new-feature.md`)
- Plans are temporary, remove after implementation
- Persistent learnings from plans should be added to `memory-bank/`
- Create the `plans/` directory if it doesn't exist

## Code Generation Standards

All code you generate must:

- Follow the language-specific style guidelines below
- Include appropriate error handling for edge cases
- Use clear, descriptive names for variables, functions, and classes
- Avoid code duplication (DRY principle) - extract common patterns into reusable functions
- Consider security implications (input validation, injection risks, secrets management)
- Include docstrings or comments explaining non-obvious logic
- Not introduce trailing whitespace
- End files with exactly one newline character

## Language-Specific Guidelines

### Python

When generating or modifying Python code:

- **Formatting**: Use Black with 88 character line length
- **Import Sorting**: Sort imports with isort using Black profile
- **Type Hints**: Include type hints for function parameters and return values
- **Naming**: Use PascalCase for classes, snake_case for functions and variables
- **Documentation**: Write docstrings for classes and functions with Args, Returns, and Raises sections
- **Testing**: Use pytest for unit tests; test edge cases and error conditions
- **Pre-commit**: Ensure code is formatted with Black and imports sorted with isort before suggesting

### [Other Languages]

Add guidelines as you work with other languages.

## Git Workflow

When committing code:

- **Conventional Commits**: Use conventional commit format for all commits
- **Commit Message Format**: `type(scope): description`
- **Message Length**: Keep the first line to ≤ 72 characters
- **Common Types**: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **Logical Units**: Commit related changes together; avoid mixing unrelated features
- **Commit Bodies**: For complex changes, add a body explaining the "why" after a blank line

## Pre-commit Standards

Before suggesting code changes, verify:

- [ ] Code follows language-specific style guidelines
- [ ] All imports are properly sorted (if applicable)
- [ ] No trailing whitespace
- [ ] Files end with single newline character
- [ ] Error cases are handled
- [ ] Security implications are considered
- [ ] Documentation is updated
- [ ] Code follows DRY principles
- [ ] Variable and function names are clear and descriptive