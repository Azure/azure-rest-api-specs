---
name: foundry-pr-review
license: MIT
metadata:
  version: "1.0.0"
description: "Creates a concise local markdown code-review draft for a GitHub pull request that changes the AI Foundry data-plane TypeSpec folder. USE FOR: reviewing a PR, checking Foundry API patterns, or preparing inline review comments for manual confirmation. OUTPUT: pr-review-NUMBER.md in the Foundry folder. SAFETY: never publishes comments or submits a GitHub review during draft generation. DO NOT USE FOR: PRs with no changes under specification/ai-foundry/data-plane/Foundry/."
argument-hint: "<PR URL, owner/repo#number, or #number>"
---

# Foundry PR Review

Create a high-confidence, publication-ready review draft for one pull request. Review the
PR's Foundry changes without checking out its branch or modifying its source files.

## Safety Contract

- Draft generation is read-only except for the local review markdown.
- Do not submit a GitHub review, create inline comments, change labels, change PR state, merge,
  or push commits.
- Treat publication as a separate action that requires the user to identify and explicitly
  approve the completed draft.
- Before any later publication, re-fetch the PR and require its head SHA to match the draft.
  If it differs, stop and generate a fresh review.
- Publish only the exact comments the user confirmed. Do not add commentary during publication.

## Input And Output

Accept a PR URL, `owner/repository#number`, or `#number`. For a bare number, resolve the
repository from the current workspace's Git remote.

Find the Foundry root as the nearest directory containing both `main.tsp` and this skill at
`.github/skills/foundry-pr-review/SKILL.md`. Save the draft there as:

```text
pr-review-<number>.md
```

Do not overwrite an existing review draft. Add `-2`, `-3`, and so on before `.md` when needed.
Use [the review template](./assets/review-template.md) and replace every placeholder.

## Workflow

1. Resolve the PR and fetch its title, URL, author, base branch, head branch, head SHA, draft
   state, labels, status checks, changed files, and complete diff. Prefer GitHub PR tools; use
   `gh` only when equivalent tools are unavailable. Do not check out the PR.
2. Confirm that the diff changes files under
   `specification/ai-foundry/data-plane/Foundry/`. If not, report that the skill is out of scope
   and do not create a draft.
3. Read the base and head versions of changed Foundry source files with enough surrounding
   context to understand each change. Use generated OpenAPI and examples as supporting evidence,
   but place a finding on the controlling TypeSpec source whenever possible.
4. Review only behavior introduced or made materially worse by the PR. Do not report untouched
   pre-existing issues. Compatibility requirements and explicit external wire contracts take
   precedence over preferred patterns.
5. Apply [the Foundry review rules](./references/review-rules.md). Also look for concrete API
   correctness, compatibility, request/response, example, and generated-artifact regressions
   visible in the changed scope.
6. Use status checks as evidence. Do not run code from an untrusted PR or install its
   dependencies as part of this skill. Record checks that were observed and checks that were not
   run.
7. Keep only findings that are specific, actionable, and supported by the diff. Anchor inline
   findings to an added or modified line on the right side. Use a PR-level comment only when no
   accurate line anchor exists.
8. Deduplicate findings and identify the root cause. Do not comment on generated output when one
   source change can fix all affected artifacts.
9. Write the local draft from the template. Choose `REQUEST_CHANGES` only for findings that must
   be fixed before merge, `COMMENT` for non-blocking findings, and `APPROVE` when there are no
   publishable findings.
10. Re-read every candidate comment as if it were posted verbatim. Remove internal rule names,
    references to this skill or its source material, unnecessary background, praise, and
    repetition. Then report the saved path and stop without publishing.

## Finding Threshold

Include a candidate comment only when all of these are true:

- The PR introduced the issue or materially expanded its impact.
- The issue affects the API contract, client generation, compatibility, correctness, or a stated
  Foundry pattern.
- The requested change is clear enough for the author to act on.
- The evidence supports the finding without guessing about service behavior.

Do not publish style preferences, speculative concerns, broad redesign requests, or findings
whose only evidence is an untouched nearby pattern. Put uncertain items in `Reviewer notes`, not
in `Candidate comments`.

## Comment Style

- Lead with the requested change or concrete problem.
- Prefer one sentence; use a second only when the impact is not obvious.
- Name the relevant symbol, route, property, or replacement directly.
- Aim for 40 words or fewer. Never add background that does not help resolve the issue.
- Do not mention a cheatsheet, guideline, rule ID, skill, prompt, or review process.
- Do not use `nit`, rhetorical questions, compliments, or generic preambles.
- Keep independent problems in separate comments.

Examples:

```markdown
Use `FoundryTimestamp` for `completed_at`; Foundry timestamps are Unix epoch values.
```

```markdown
Return `AgentsPagedResult<Widget>` and spread `CommonPageQueryParameters` so this list uses the shared cursor contract.
```

## Completion

The task is complete when the draft exists locally, every candidate comment has an exact anchor
or is explicitly PR-level, the recorded head SHA matches the reviewed diff, and no GitHub write
operation occurred.
