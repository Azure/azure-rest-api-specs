---
name: typespec-linter-rule-enablement
description: "Roll out migrated TypeSpec linter rules with one independent draft PR per rule, an upfront policy assessment, narrow legacy-contract suppressions, and complete final validation. Not for implementing rules, changing API contracts, or suppressing unrelated failures."
---

# Enable migrated TypeSpec linter rules

Accept a nonempty **rule-name list**:

```text
typespec-linter-rule-enablement ["no-query-in-post", "no-query-in-point-op"]
```

Resolve fully qualified IDs or unique suffixes and deduplicate. Infer packages,
profiles, projects, and PR context from the repository. Reject unknown or
ambiguous names; never silently add or omit requested rules.

## 1. Assess policy and prerequisites

- Before enabling each rule, identify its original Swagger rule, severity,
  staging-only status, and intentional differences in native TypeSpec behavior.
  Explain whether enabling it under `--warn-as-error` preserves enforcement or
  introduces a new blocking requirement. Obtain policy-owner agreement before
  promoting previously advisory or staging-only policy to blocking enforcement;
  permission to prepare a draft PR is not policy approval.
- Inspect installed exports, package versions, defaults, and ordered profile
  composition. Later profiles can cancel an enable. Choose profiles from actual
  applicability and audit project references, including inheritance. Report
  incompatible composition, unavailable rules, and configurations outside the
  central profiles; do not silently upgrade dependencies or mass-edit projects.
- Keep already-enabled rules enabled and report a no-op when no work remains.
  Assess suspected false positives before adding suppressions. Rule bugs are
  blockers, not reasons to grandfather incorrect diagnostics.

## 2. Prepare one independent change per rule

For every requested rule, use a separate branch based on the intended target
branch. Do not stack rule rollouts or combine several rules in one PR. A rule
under discussion must not prevent another rule from shipping.

Enable only that rule's resolved ID in the applicable profiles in
`eng/typespec-rulesets/index.ts`, preserving upstream `extends` and unrelated
overrides. Include only its required suppressions and directly related tests.
Keep enablement and suppressions atomic.

Use the repository's supported project discovery and validation tooling to
identify affected configurations and shared consumers. Compile, inspect failures,
and recompile affected projects while iterating. Before production `.tsp` edits,
follow the `azure-typespec-author` skill.

Apply only observed, justified suppressions at the narrowest supported
declaration. For migrated legacy contracts, use a specific reason beginning with
`Back compat: ` that explains the existing API or SDK behavior being preserved.
Preserve existing directives and unrelated source, then format and inspect the
diff. Do not blanket-suppress namespaces, groups, projects, or templates.

Do not change API declarations, decorators, versions, examples, or generated
Swagger to make the rollout pass. Never hide violations through global
disablement, `linter.disable`, service configuration edits, or
`specification/suppressions.yaml`. Unrelated errors, infrastructure failures, and
lack of progress remain explicit blockers.

## 3. Publish and validate each candidate

Prepare the real change before creating or reusing its **single-rule draft PR**;
do not create synthetic `false`-entry bootstrap commits. Follow normal repository
Git guidance, prefer an authorized organization-repository branch, and disclose
any necessary fork fallback. Keep all spec-repo PRs draft until ready to merge.

Check protected-file author eligibility separately from push permission. Record
required maintainer action without bypassing allowlists, approvals, or policies.

For each rule independently:

- Obtain complete project coverage for the exact final candidate using supported
  repository validation tooling, locally or in CI. Include all configurations and
  shared consumers affected by central profiles, not just edited services.
  Report missing, failed, skipped, or otherwise incomplete evidence explicitly.
- Verify the actual validated checkout revision; a PR merge snapshot can differ
  from the branch head. Refresh discovery and validation when the candidate or
  relevant base changes. Do not apply stale diagnostic coordinates to new source.
- Run relevant wrapper/tooling build and regression tests, normal PR TypeSpec
  validation, and TypeSpec suppression checks. Confirm generated API output is
  unchanged. Continue targeted fixes until complete final validation succeeds or
  a genuine blocker is established.

Use clean disposable checkouts for validation that rewrites generated files.
Never run `tsv --git-clean` in the authoring worktree: it can discard tracked and
untracked work. Validation checkouts must contain the committed candidate.

Do not wait for SDK generation, SDK breaking-change, or APIView pipelines for
this contract-preserving rollout. Keep merge-policy approval separate from
compilation success; do not auto-merge or claim a blocked PR is merge-ready.
Update PR metadata sparingly because edits can retrigger validation.

## 4. Report

For each rule, report its PR link, meaningful policy or behavior changes,
suppression breakdown, final validation evidence, and unresolved blockers.
Keep detailed logs, manifests, versions, and checkout bookkeeping in linked
artifacts when needed rather than reproducing execution history.
