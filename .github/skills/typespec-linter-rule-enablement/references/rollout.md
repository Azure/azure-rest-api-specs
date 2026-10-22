# Rollout procedure

## 1. Refresh the inventory and choose a branch

Use GitHub CLI to enumerate merged migration PRs:

```powershell
gh pr list --repo Azure/typespec-azure --state merged --limit 100 `
  --search '"[Swagger Linter Migration]" in:title' `
  --json number,title,mergedAt,url
```

Paginate further if the result reaches the limit. Check subsequent reverts and
replacement implementations. Multiple `(origin)` PRs can implement the same
rule; two old Swagger checks can also map to one TypeSpec rule. Inspect current
`$linter.rules`, package exports, upstream `ruleSets`, and the spec repository's
wrapper rather than counting titles.

Read `pnpm-workspace.yaml` and `pnpm-lock.yaml` on the intended spec branch.
Compare the actual installed `$linter.rules` exports with the candidate IDs,
and check that the rule is not already inherited or explicitly enabled.
`npm view <package> dist-tags --json` is publication evidence only: the target
branch's lockfile and installed export determine whether CI can execute a rule.
A rule present only in `next` needs a compatible, separately validated dependency
update or a rollout against `typespec-next`; do not assume a merged TypeSpec PR
is available on spec `main`. Preserve the upstream package alias.

Check actual remote URLs, permissions, and branch policies. Prefer a new branch
in `Azure/azure-rest-api-specs` when write access permits; otherwise use an
authorized fork and disclose the fallback. Never push to the base branch.

## 2. Establish a baseline, then opt in

Use a dedicated worktree at an exact base SHA. Follow the checked-out branch's
Node and pnpm requirements and setup action. Install its locked dependencies:

```powershell
pnpm install --frozen-lockfile
pnpm --filter @azure-tools/typespec-azure-rulesets build
pnpm --filter @azure-tools/typespec-validation check
pnpm exec tsv --all --dry-run specification
```

Archive the discovery list, package versions, baseline logs, and exact revision.
Run baseline validation before enabling the rule, or reuse a completed baseline
run only if its SHA, dependencies, project set, and target ref match.

Add one fully qualified rule ID to `enable` in the appropriate
`$linter.ruleSets` entry in `eng/typespec-rulesets/index.ts`. Merge into existing
maps; do not replace unrelated policy. For example:

```ts
"data-plane": {
  extends: ["@azure-tools/typespec-azure-rulesets-original/data-plane"],
  enable: {
    "@azure-tools/typespec-azure-core/no-boolean": true,
  },
},
```

Select `data-plane` or `resource-manager` from the rule's intended applicability;
do not enable a core rule for both planes solely because it is in the core
package. `client-sdk` is for SDK rules, not a shortcut to reach every project.

Check the **complete ordered profile composition** in representative project
configs. An inherited `disable` in a later profile can remove an earlier
enable. For example, upstream `client-sdk` explicitly disables
`@azure-tools/typespec-client-generator-core/use-create-for-put` in stable
and next. Enabling it in `resource-manager` alone does not work for projects
that subsequently extend `client-sdk`. A final project-local enable works
technically but violates this rollout's central-policy/no-mass-config-edit
boundary. Defer this rule until an ARM-only profile composition or an upstream
plane-aware rule/policy change is approved and tested; do not remove the
data-plane safeguard globally.

Build the wrapper again. Start with one representative project and confirm the
selected rule actually fires. An unknown rule, a missing export, or zero
diagnostics in a non-violating template does not establish successful opt-in.
Then scan every applicable project with the candidate override:

```powershell
pnpm exec tsv --all specification
```

This full scan can be expensive and can modify generated files and formatting.
Use the disposable scan checkout, retain complete per-project logs, and compare
against baseline. Do not commit incidental scan output. A wrapper edit affects
all projects using that named ruleset, not only projects changed in the PR.

For parallel execution use the existing three-shard convention, with a distinct
checkout per shard:

```powershell
pnpm exec tsv --all --shard=1/3 specification
```

Repeat for `2/3` and `3/3`. Do not run concurrent shards in one checkout.
The checked-in workflow uses `--git-clean` only in disposable CI checkouts;
candidate enablement and suppressions must be committed before using that flag.

## 3. Suppress observed legacy violations

Retain exact rule ID, project, file, line, message, and baseline/candidate
distinction. Exclude pre-existing failures and all diagnostics from other rules.
Namespaced diagnostics are not automatically safe: confirm the ID is an
exported **linter rule**, not just a library/compiler diagnostic.

Invoke `azure-typespec-author` before production TypeSpec edits. Read the
declaration and its decorators, templates, and versioning context. For each
accepted legacy exception, insert:

```tsp
#suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing published contract exposes this boolean; preserve wire compatibility during rule enablement."
legacyFlag?: boolean;
```

Use the actual contract-specific reason, not a generic claim that the rule was
migrated. Insert before the targeted declaration's decorators/doc comments as
required by the parser and formatter; do not attach it to the previous
declaration or an unrelated `@@` augment decorator. For templates or shared
models, validate all consuming projects and demonstrate the chosen scope does
not mask future unrelated violations.

Recompile after edits and inspect which diagnostics remain. A repeated
diagnostic usually means the directive targets the wrong declaration. Correct
placement rather than widening scope. A newly revealed diagnostic must pass the
same selected-rule and legacy-contract checks. Limit this loop to three passes
per project and report remaining blockers.

Do not use `specification/suppressions.yaml` here. It controls TSV checks such as
`FolderStructure/MustUseV2` and `Compile/ExtraSwagger`, not individual TypeSpec
linter rules; current TSV's `Compile` rule is not globally suppressible.

## 4. Validate the candidate

From each edited project's directory, run the formatter in the same scope TSV
uses, and inspect all resulting changes:

```powershell
pnpm exec tsp format "../**/*.tsp" tspconfig.yaml
```

From the repository root:

```powershell
pnpm exec tsv <project-folder>
pnpm --filter @azure-tools/typespec-azure-rulesets build
pnpm --filter @azure-tools/typespec-validation check
```

TSV compiles with `--warn-as-error`, checks formatting, and compares generated
files. It can also rewrite files. Review the full diff and reject any API
contract, generated-output, or unrelated formatting change. Pre-existing
failures must be documented and separated; they are not permission to add
unrelated suppressions. Repeat the complete population scan with the final
suppression set, including consumers of changed shared declarations.

Commit the candidate before revision-based analysis. Compare the PR merge base
with the candidate commit, not uncommitted working-tree files:

```powershell
pnpm exec typespec-suppressions --base <merge-base-sha> --head HEAD `
  --json-output <report-path> <project-folder>
```

Include every touched project/consumer as appropriate. Inspect counts and
structural anchors for unexpectedly broad scope. The workflow also supplies
`--check-rules-file eng/tools/typespec-suppressions/check-rules.json
--fail-on-approval`; only that curated subset is approval-gated. Do not edit
the curated list or approval mechanism to bypass review. The unfiltered report
is still needed for rules outside the list.

Require **TypeSpec Validation - All** on the candidate PR head/merge candidate:
all three Ubuntu and all three Windows shards for its target ref. An
`eng/typespec-rulesets/index.ts` change matches this workflow's `eng/**` PR
trigger. Scheduled runs additionally validate `typespec-next`; push and PR runs
normally cover only their default checkout, so check actual matrix refs.
A green baseline run does not validate a changed override.

## 5. Open an atomic draft PR

Include central enablement and all required narrow suppressions together.
Separate dependency upgrades or substantial API fixes when needed; do not land
enablement before the existing violations are accounted for. A suppression-only
preparation PR is not completed enablement and needs explicit sequencing and
fresh validation when the follow-up policy PR is prepared.

The draft PR body should identify:

- Selected rule, Swagger predecessor(s), migration PR, plane, package versions,
  base revision, and candidate revision.
- Total applicable projects, scan coverage, projects with violations, number of
  diagnostics and added suppressions, and why these contracts are grandfathered.
- Baseline versus candidate failures, generated-output comparison, targeted
  checks, full matrix run link, suppression report, and review requirements.
- Every blocked project or incomplete check. Do not mark ready while any
  applicable project remains unaccounted for.

Create the draft against the intended branch, not automatically `main` for a
`typespec-next` experiment. Never auto-merge or resolve reviewer threads.

## Why PR #45589 is not the bootstrap step

At the inspected head, [PR #45589](https://github.com/Azure/azure-rest-api-specs/pull/45589)
is unmerged. It harvests existing TSV-All logs and opens suppression-only PRs;
it does not opt disabled migration rules into the central rulesets. Existing
green runs therefore contain none of their potential violations.

There is also a concrete compatibility failure: its parser expects
`##[group]Validating <folder>`, but current TSV prints
`##[group]pass <folder>`, `fail <folder>`, or `skip <folder>`. Against a current
failing next-shard log it reported zero folders and zero failures. It must be
updated and tested against current logs before reuse. Require nonzero expected
project coverage, all expected shards, successful log downloads, and run/head/
dependency provenance; never treat missing coverage as a clean run.

Its general ideas remain useful: harvest already-produced **candidate**
validation logs, preserve exact diagnostic locations, prefer narrow inline
suppressions, classify infrastructure errors separately, bound iteration, and
validate both operating systems. Do not copy its broad diagnostic eligibility
or folder-level suppression policies into this selected-rule rollout.
