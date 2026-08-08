# Suppress & validate

## Inserting suppressions

For each **user-error** violation, add a suppression directly above the flagged
operation:

```tsp
#suppress "<rule-id>" "<justification>"
```

Use the exact justification string the requester specified (e.g.
`fixme-invalid-lro-result`). The rule id is the fully-qualified name, e.g.
`@azure-tools/typespec-azure-resource-manager/lro-response-mismatch`.

### Placement

TypeSpec applies a `#suppress` to the statement whose **leading trivia** it sits
in, so it can go anywhere above the operation's doc-comment + decorators. Two
robust options:

- Insert the directive on its own line immediately **before** the line reported by
  the ground-truth source location (which points at the doc/decorator block
  start), matching that line's indentation; **then run `tsp format`** — the
  formatter moves it into the canonical position (grouped with any other
  `#suppress` directives, directly above the operation). Letting the formatter
  place it is the reliable approach and is required to pass `tsv`'s format check.

### Scripting the edits safely

- Drive insertions from the stored dataset, one file at a time, inserting from the
  **bottom of the file upward** (descending line order) so earlier inserts don't
  shift later line numbers.
- Write files as **UTF-8 without BOM** and preserve the file's original line
  endings. A BOM-adding writer corrupts line 1 and shows up as a spurious diff; if
  a file originally had a BOM, keep it. Verify with `git diff --numstat` that each
  file's only change is the added suppression line(s) (`N insertions, 0 deletions`).
- Run `tsp format <files...>` on every edited file afterward and re-check the diff
  contains only suppression-line changes.

## Validate

1. Remove any rule instrumentation so the pristine rule runs.
2. Commit the suppressions (see below) — required before `tsv`'s git checks.
3. Re-run `npx tsv <spec-dir>` on each affected spec. Confirm:
   - **Compilation completed successfully** (no user-error diagnostics remain);
   - the **false-positive** violations still appear (they were not suppressed);
   - no "Files have been changed after `tsp format`" and no git-difference
     failures.

Validate at least one spec per violation variant (e.g. a POST-heavy service, a
DELETE-heavy service, and a mixed PUT/PATCH service).

## Commit

`tsv` compares generated Swagger and the working tree against the base branch, so
uncommitted `.tsp` edits fail its git checks. Stage the suppressed `.tsp` files
and the report and commit (keep evaluation-only `package.json`/lockfile changes
out unless requested). Include any repository-required commit trailers.
