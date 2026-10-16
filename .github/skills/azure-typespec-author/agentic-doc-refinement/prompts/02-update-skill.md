# Prompt 02 — Update skill markdown (only if needed)

You maintain the `azure-typespec-author` skill in `.github/skills/azure-typespec-author/`.

## Task

Given the reference documents updated in step 1, review the skill instructions and update
them **only where the reference changes require it**:

- `SKILL.md` — the skill entry point and instructions.
- Other `references/*.md` referenced by `SKILL.md`.

Rules:

- Make **minimal, surgical** changes. Do not rewrite sections that are already correct.
- `reference-document-links.md` is the source of truth for case names. In
  `references/intake.md` and `references/authoring-plan.md`, align the names of
  **existing cases only** with the corresponding reference headings.
- Preserve all existing case-specific prompts, instructions, defaults, numbering, and
  structure in `references/intake.md` and `references/authoring-plan.md`. Do not remove, merge, generalize, or rewrite their existing cases.
- Do **not** copy every case from `reference-document-links.md` into `intake.md` or
  `authoring-plan.md`. Do not add a case merely because a new reference heading exists;
  these files intentionally contain only the cases that need dedicated intake or
  authoring guidance.
- If an existing case has no direct reference-heading counterpart, keep its current name and content unchanged.
- Do not touch eval fixtures, `.vally.yaml`, or pipeline files.
- If nothing needs changing, make no edits and say so explicitly.
- Do **not** commit, stage, or push. Leave your edits unstaged in the working tree so
  the user can review them and decide whether to commit.

## Validation

- `SKILL.md` still parses (valid front matter + headings).
- Existing case counts, numbering, and case-specific content in `references/intake.md`
  and `references/authoring-plan.md` remain unchanged; only existing case names may be
  aligned with `reference-document-links.md`.
- No new cases from `reference-document-links.md` are duplicated into `intake.md` or
  `authoring-plan.md`.
