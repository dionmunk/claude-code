---
name: git-code-review
description: "Perform a comprehensive and constructive code review of the current git diff (staged preferred)."
---

Perform a thorough and constructive code review of the current changes. Evaluate the implementation for code quality, potential issues, performance, security, and test coverage. Provide specific, actionable feedback that helps the author improve their work while acknowledging strengths and good practices.

STRICT SAFETY RULES:
- You MUST NOT run `git commit`, `git push`, or any git history-modifying commands.
- You MUST NOT modify any files.
- You MUST ONLY read repository state and output review feedback.

Process:
1) Collect read-only git context:
   - git rev-parse --show-toplevel
   - git status --porcelain=v1
   - git diff --stat
   - git diff
   - git diff --staged --stat
   - git diff --staged
   - git log -n 10 --oneline --decorate

2) Choose review target:
   - If staged changes exist, review `git diff --staged`.
   - Otherwise, review `git diff`.

3) Read project constraints:
   - Consult `memory-bank/` if it exists (especially `memory-bank/conventions.md`, `memory-bank/system-patterns.md`, `memory-bank/tech-context.md`).
   - If `memory-bank/` is missing or empty, note it and proceed with general best practices.

Review Considerations:
The review should evaluate:
- Code quality and adherence to best practices
- Potential bugs, logic errors, or edge cases
- Performance implications and optimization opportunities
- Security vulnerabilities and data protection concerns
- Test coverage and testing strategy
- Maintainability and code readability
- Documentation completeness
- Consistency with project conventions and patterns

Review Output Format:

## A) Summary (3–5 bullets)
- High-level description of what changed
- Scope and purpose of the changes
- Overall complexity or risk assessment

## B) Strengths (optional - include when applicable)
Highlight positive aspects of the implementation:
- Well-designed patterns or solutions
- Good practices observed
- Clear and maintainable code
- Effective problem-solving approaches

## C) Issues & Concerns
Organize issues by severity level. Always number each issue. For each issue, include:
- **Issue:** Clear description of the problem
- **Location:** File path and line number(s) or code block reference
- **Code:**
  ```
  [relevant code snippet from the diff]
  ```
- **Impact:** Explanation of why this matters and potential consequences
- **Recommendation:** Specific, actionable suggestion for fixing the issue

### Critical Issues
Security vulnerabilities, data loss risks, correctness bugs that cause failures, or breaking changes without migration path.

### High Priority Issues
Significant performance problems, maintainability concerns, missing critical error handling, or incomplete feature implementation.

### Medium Priority Issues
Code quality concerns, suboptimal patterns, missing edge case handling, or incomplete documentation.

### Low Priority / Style Issues
Minor style inconsistencies, readability improvements, naming conventions, or optional refactoring suggestions.

## D) Security Review (if applicable)
When security-relevant changes exist, address:
- Authentication and authorization concerns
- Input validation and sanitization
- SQL injection, XSS, or injection attack risks
- Sensitive data exposure or improper handling
- Dependency vulnerabilities
- Access control and permission issues

## E) Performance Considerations (if applicable)
When performance-relevant changes exist, address:
- N+1 queries or inefficient database access patterns
- Unnecessary loops, iterations, or redundant operations
- Memory usage concerns or potential leaks
- Algorithmic complexity issues
- Caching opportunities or optimization potential
- Scalability implications

## F) Test Coverage (if applicable)
Assessment of testing approach:
- Coverage of the changes by existing tests
- Missing test scenarios or edge cases
- Integration test requirements
- Suggestions for improving test quality or completeness

## G) Code Style & Conventions (if applicable)
When relevant to the changes:
- Consistency with project patterns and conventions
- Code organization and structure
- Naming clarity and readability
- Documentation completeness (comments, docstrings, etc.)
- Adherence to team style guidelines

## H) Recommendations by Priority

### Must Fix Before Merge
Blockers that must be addressed before merging:
- Security vulnerabilities or data protection issues
- Correctness bugs that cause failures
- Breaking changes without proper migration
- Critical performance issues affecting production

### Should Fix Before Merge
Important improvements that enhance code quality:
- Significant maintainability concerns
- Important edge cases or error handling
- Performance optimizations that matter
- Test coverage gaps for critical paths

### Can Fix in Follow-up
Nice-to-have improvements that can be addressed later:
- Style and readability enhancements
- Minor refactoring opportunities
- Documentation additions
- Future optimization opportunities

## I) Overall Assessment
Conclude with:
- **Readiness:** Clear statement on whether the code is ready to merge
- **Confidence Level:** Your confidence in the changes (High / Medium / Low)
- **Summary Recommendation:** Final verdict and next steps
- **Positive Note:** Acknowledge good work and effort where applicable

## J) Additional Notes (optional)
When needed:
- Clarifying questions for the author
- Context or background information needed for the review
- Assumptions made during the review
- Related issues or future considerations

Tone Guidelines:
- Be thorough, professional, and specific in your feedback
- Provide actionable recommendations with clear rationale
- Reference exact locations and code snippets
- Acknowledge strengths and good practices
- Ask questions when uncertain rather than assume
- Focus critique on the code and decisions, not the coder
- Use collaborative language ("consider", "we could", "suggest")
- Balance criticism with recognition of good work
- Explain the "why" behind recommendations
- Be respectful and constructive in all feedback

Now run the process and produce the review.