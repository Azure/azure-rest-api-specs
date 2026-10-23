---
name: typespec-linter-rule-enablement
description: "Enable a list of migrated TypeSpec linter rules in one draft PR and iterate full compilation and narrow legacy-contract suppressions until every project passes. Not for implementing rules, changing API contracts, or suppressing unrelated failures."
---

# Enable migrated TypeSpec linter rules

Accept only a nonempty **rule-name list**:

```text
typespec-linter-rule-enablement ["no-query-in-post", "no-query-in-point-op"]
```

Resolve fully qualified IDs or unique suffixes and deduplicate. Infer packages,
profiles, projects, and PR context from the repository; require no other inputs.
Reject unknown or ambiguous names, and never omit or add requested rules.

## 1. Resolve prerequisites and create one draft PR

- Inspect installed linter exports, package versions, defaults, and ordered
  profile composition. Later profiles can cancel an enable. Report unavailable
  rules or incompatible composition; do not silently upgrade dependencies or
  switch branches. Keep already-enabled rules enabled; report a no-op when
  there is no work.
- Audit project profile references, including inheritance. Record configurations
  outside the central profiles rather than mass-editing them. Choose profiles
  from actual rule applicability, not the defining package alone.
- Reuse the requested rollout's existing draft PR. Otherwise use a dedicated
  work branch at the repository default branch's exact SHA and create **one
  draft PR for the entire list before enabling rules**. Prefer an authorized
  organization-repository branch; disclose a necessary fork fallback.
- If a new PR needs a branch difference, bootstrap with explicit `false` entries
  only for requested rules proven effectively disabled in those profiles.
  Commit/push this policy-neutral change, create and verify the draft, then
  enable the rules. Never temporarily disable an already-enabled rule.
- Check protected-file author eligibility separately from push permission.
  Record required maintainer action; never bypass allowlists or approvals.

## 2. Enable, compile, suppress, and repeat

Enable the resolved IDs in the applicable profiles in
`eng/typespec-rulesets/index.ts`. Preserve upstream `extends` and unrelated
overrides. Build the wrapper and add/update regression coverage proving the
selected rules apply in composed profiles and a narrow suppression does not
hide another violation. Commit/push enablement to the same draft.

Discover all configurations, not just edited services:

```powershell
$projects, $checkedAll = & .\eng\scripts\Get-TypeSpec-Folders.ps1 -CheckAll
pnpm exec tsv --all --dry-run specification
```

Retain the reconciled manifest, source revision, versions, per-project exit
codes, and full diagnostics. Compile configured `main.tsp` projects with
`pnpm exec tsp compile <project> --warn-as-error`; use
`pnpm exec tsp compile <project>\client.tsp --no-emit --warn-as-error` for
client-only projects. Account for grouping configurations through all their
configured child entry points. Continue the scan after failures.
Treat unresolved entry points as blockers, not silent omissions.

For each pass:

1. Analyze failures before editing. Classify diagnostics by rule, source target,
   and cause; suppress only observed requested-rule violations where preserving
   an existing API or SDK contract is intentional.
2. Before production `.tsp` edits, follow the repository's `azure-typespec-author`
   skill. If unregistered, read its local `SKILL.md` and required references.
   Inaccessible required guidance is a blocker.
3. Apply justified suppressions at the exact reported property or operation.
   Format the edited scope, inspect the diff, and recompile affected projects.
4. Run another complete all-project pass, including shared consumers, with all
   requested rules still enabled. Repeat until there are **zero failed or
   skipped projects**, with no arbitrary iteration limit.

Investigate recurring diagnostics as possible placement errors instead of
broadening scope. Rule bugs, unrelated errors, infrastructure failures, or
demonstrable lack of progress are explicit blockers, not suppressible shortcuts.
Keep the PR draft and report incomplete work.

### Exact-source compilation evidence

Complete **TypeSpec Validation - All** runs can supply a full compile pass
instead of duplicating it locally; targeted recompilation remains required
after source edits. Require all three Ubuntu and three Windows shards for the
candidate and target ref. Reconcile every logged `pass`/`fail`/`skip` project
against discovery: no missing, duplicate, skipped, or truncated coverage.
A failure before the compile check does not establish compilation.

Verify the actual checkout SHA across shards, not just workflow `head_sha`:
PR jobs can use a newer-base merge snapshot. Align authoring source with that
immutable snapshot before using diagnostic coordinates; refresh discovery if
the base changed. Preserve raw logs and repair only verified diagnostic
fragments interrupted by progress counters. Require matching located
diagnostics across operating systems; an empty harvest is not proof of success.

Use clean disposable checkouts for validation that rewrites generated files.
Never run `tsv --git-clean` in the authoring worktree; it discards tracked and
untracked work. Disposable checkouts must contain committed candidate changes.

### Narrow suppression editing

Deduplicate observations across versions/projects/OS, then insert one directive
per **rule and exact AST declaration**. Match identifiers and enclosing owners,
not repeated names or documentation text. Interface generic-argument properties
are valid property anchors, not permission to suppress the whole interface.
Library, inline, or other unsupported targets require explicit placement review.

Preflight the entire batch before writes. Insert bottom-up before decorators,
preserving documentation and existing directives. Reparse and prove that
removing only new directives recovers the original source byte-for-byte.
Use contract-specific justifications and retain shared-consumer coverage.

Do not blanket-suppress namespaces, groups, projects, or templates. Do not
change API declarations, decorators, versions, examples, existing suppressions,
or generated Swagger. Never use global disablement, `linter.disable`, service
configuration edits, or `specification/suppressions.yaml` to hide violations.

## 3. Validate and publish

After all edits and formatting, rediscover projects and require successful
exact-candidate evidence for:

- **TypeSpec Validation - All:** complete six-shard coverage as above, with zero
  failed/skipped projects or remaining diagnostics.
- **TypeSpec Validation:** the normal PR validation path.
- **TypeSpec Suppressions:** analysis and aggregate status, including the
  repository's approval policy; inspect new counts and structural anchors.
- Relevant wrapper/tooling build, typecheck, and regression tests when changed.

Verify generated API output is unchanged. **Do not wait for SDK generation,
SDK breaking-change, or APIView pipelines** for this contract-preserving rollout.
Keep merge-policy gates separate from TSV convergence; never alter approval
rules or claim a blocked PR is merge-ready.

Commit/push to the same PR, keeping enablement and required suppressions atomic.
Validate the final published candidate, not an earlier local revision.
Update PR metadata sparingly: title/body edits can retrigger impacted scans.
Do not auto-merge or create a replacement PR.

Report the PR link, supplied/resolved rules and profiles, package versions,
base/head and actual CI checkout revisions, project coverage, per-pass failures,
suppression counts, unchanged-output evidence, final CI links, and blockers.
