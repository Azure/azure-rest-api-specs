---
name: typespec-linter-rule-enablement
description: "Accept a list of migrated TypeSpec linter rule names, create one draft PR, enable those rules centrally, and iterate compilation and narrow legacy-contract suppressions until every TypeSpec project compiles. Not for implementing rules in typespec-azure, suppressing arbitrary CI failures, or changing API contracts."
---

# Enable migrated TypeSpec linter rules

Accept only a **rule-name list**. Create one draft PR for that list **before
enabling the rules**, then enable them centrally and repeat
**compile all projects → suppress observed legacy violations → recompile**
until every project passes `tsp compile` with warnings treated as errors.
Preserve existing API contracts; new unsuppressed violations must still fail.

Read [the rollout procedure](references/rollout.md) before executing. The
[initial investigation](references/initial-inventory.md) is a dated starting
point, not a permanent allowlist.

## Input contract

Example invocation:

```text
typespec-linter-rule-enablement ["no-query-in-post", "no-query-in-point-op"]
```

Accept nonempty lists of fully qualified rule IDs or uniquely resolvable rule
suffixes; deduplicate them. Do not require a package, plane, branch, project list,
PR URL, iteration count, or execution mode as another input. Infer these from
repository metadata and installed rules, using the repository default branch as
the base. Reject unknown or ambiguous names explicitly; never guess, silently
drop a requested rule, or enable extra rules.

## Execution order

1. Resolve the entire list, installed exports, current defaults, applicable
   central profiles, and ordered profile composition. Report unavailable
   packages or unsupported composition as blockers rather than silently changing
   branches or dependencies. Already-enabled rules remain enabled.
2. Reuse the current branch's open draft PR when it is the requested rollout PR.
   Otherwise create a work branch and **one draft PR for the complete list**,
   using the policy-neutral bootstrap described in the rollout procedure. Do not
   enable the selected rules before the draft exists.
3. Enable every selected rule in `eng/typespec-rulesets/index.ts`, preserve
   inherited profiles, and push the enablement to that same draft PR.
4. Discover every TypeSpec project under `specification` and run
   `tsp compile --warn-as-error` on every project entry point. Keep per-project
   exit codes and full diagnostics; do not stop the scan at the first failure.
5. Before editing production `.tsp` files, load the repository's
   `azure-typespec-author` skill and follow its grounding and validation
   requirements. If it is not registered with the skill tool, read its local
   `SKILL.md` and required references directly. A missing local skill or
   inaccessible required guidance is a blocker, not permission to bypass it.
6. Add justified, narrow inline suppressions only for observed diagnostics from
   the requested rules where an existing contract must be preserved. Format and
   recompile edited projects; diagnose repeated failures and classify newly
   exposed diagnostics. Continue this loop without an arbitrary pass limit.
7. After each suppression batch, rerun compilation across **all projects**,
   including consumers of shared declarations. Repeat until a complete pass has
   zero failed projects. A genuine blocker or demonstrable lack of progress
   leaves the PR draft and the rollout incomplete; never suppress unrelated
   failures just to terminate the loop.
8. Verify unchanged generated APIs, run TSV and suppression review checks,
   commit/push the final changes, and update the existing PR body and progress.
   Do not create another PR at the end or declare readiness before final CI.

## Guardrails

- Preserve upstream `extends` entries and existing overrides in the wrapper.
  Rule IDs belong to the defining linter package, not the wrapper package.
- Verify the final composed profiles, not just one wrapper entry. A later
  profile can disable an earlier enable. In particular, `client-sdk` disables
  `use-create-for-put`; defer its rollout until an ARM-only composition is
  agreed and verified. Do not enable it for data-plane projects to work around
  that conflict.
- Do not mass-edit service `tspconfig.yaml` files, introduce `linter.disable`,
  disable the rule globally again, or use `specification/suppressions.yaml` to
  hide individual linter diagnostics.
- Do not change declarations, decorators, versions, examples, generated Swagger,
  or existing suppressions to make the rollout green.
- Never blanket-suppress a namespace, file, project, or generic template to
  silence unrelated diagnostics. Inspect template diagnostic targets and shared
  declarations explicitly.
- Newly revealed diagnostics must be observed and classified, not predicted or
  suppressed speculatively. Keep processing actionable failures until all
  projects compile; report genuine blockers and stalled diagnostics explicitly.
- Use disposable worktrees for shard validation. `tsv --git-clean` deletes
  untracked work and restores tracked files; never run it in the authoring
  worktree or before committing the candidate changes in a disposable checkout.
- Do not depend on unmerged PR #45589. Its inspected harvester misses current
  TSV group headings; a zero-result harvest is not evidence of no violations.
- A local smoke test or one green shard is not repository-wide validation.
  Require all three Ubuntu and all three Windows shards for the target ref.
- Check the repository's protected-file policy for central `eng/**` changes.
  Branch push permission does not establish PR-author eligibility. Report a
  maintainer handoff when required; never change the allowlist, impersonate an
  allowed author, or treat compilation success as permission to bypass the gate.

## Completion report

Provide the supplied list and resolved rule IDs, PR link, base/head revisions,
package versions, total discovered projects, per-pass compile failures, added
suppression counts, final all-project compile result, generated-output
comparison, final validation run links, and any blockers. Distinguish local
compile convergence from final CI readiness. Never mark the rollout complete
with skipped or failing projects, omitted requested rules, or unpublished edits.
