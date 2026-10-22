---
name: typespec-linter-rule-enablement
description: "Enable migrated Swagger linter rules in azure-rest-api-specs using the repository-owned TypeSpec rulesets and narrowly scoped suppressions for existing contracts. Use for migration-rule readiness inventories, opt-in rollout experiments, and suppression PRs. Not for implementing rules in typespec-azure, suppressing arbitrary CI failures, or changing API contracts."
---

# Enable migrated TypeSpec linter rules

Roll out one rule at a time without changing existing API contracts. Enable the
rule centrally and grandfather only verified existing violations with inline
`#suppress` directives. New unsuppressed violations must still fail validation.

Read [the rollout procedure](references/rollout.md) before executing. The
[initial investigation](references/initial-inventory.md) is a dated starting
point, not a permanent allowlist.

## Required decisions and evidence

1. Identify the fully qualified rule ID, defining package, API plane, migration
   PR, and intended target branch. Default to a separate PR per rule.
2. Refresh the readiness inventory against the target branch's **installed**
   packages. Count unique rules, not PRs or legacy Swagger rule names. Distinguish
   merged implementation, published package, installed package, disabled default,
   and completed repository-wide rollout.
3. Establish a clean baseline, enable exactly that rule in
   `eng/typespec-rulesets/index.ts`, and compile the affected project population
   with the changed ruleset. Existing CI logs from before enablement cannot show
   violations of a disabled rule.
4. Classify every newly reported diagnostic. Suppress only the selected linter
   rule where preserving an existing contract is intentional. Genuine design
   defects, rule bugs, compiler errors, and infrastructure failures need separate
   handling, not automatic suppression.
5. Before editing production `.tsp` files, invoke the repository's
   `azure-typespec-author` skill and follow its grounding and validation
   requirements. If the skill is unavailable, report that limitation; do not
   silently bypass the authoring workflow.
6. Add a justified directive at the narrowest declaration that actually suppresses
   the observed diagnostic. Reformat and revalidate each edited project, then
   validate the complete affected population with the rule still enabled.
7. Prove generated API output is unchanged, inspect the suppression diff, and
   open a draft PR containing **both** central enablement and its necessary
   suppressions. Report unresolved failures rather than claiming a partial scan
   establishes rollout readiness.

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
- Stop a project after three suppression/revalidation passes. Newly revealed
  diagnostics must be observed and classified, not predicted or suppressed
  speculatively. A blocked project blocks claiming a complete rule rollout.
- Use disposable worktrees for shard validation. `tsv --git-clean` deletes
  untracked work and restores tracked files; never run it in the authoring
  worktree or before committing the candidate changes in a disposable checkout.
- Do not depend on unmerged PR #45589. Its inspected harvester misses current
  TSV group headings; a zero-result harvest is not evidence of no violations.
- A local smoke test or one green shard is not repository-wide validation.
  Require all three Ubuntu and all three Windows shards for the target ref.

## Completion report

Provide the inventory date and source revisions; counts of unique rules by
readiness category; selected rule and package versions; baseline and candidate
coverage; affected projects and suppression counts; generated-output comparison;
validation run links; draft PR link; and any blockers. Distinguish a procedure
smoke test from a real service rollout. Never mark a rule enabled merely because
its implementation PR merged.
