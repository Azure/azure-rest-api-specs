# Rollout procedure

## 1. Resolve the rule-name list

The only input is a nonempty list of rule names, for example:

```text
["no-query-in-post", "no-query-in-point-op"]
```

Accept fully qualified rule IDs or unique suffixes, deduplicate, and resolve
the entire list against installed linter exports and migration sources. Reject
unknown or ambiguous names explicitly. Infer packages, API planes, profiles,
project discovery, branch name, and PR metadata; do not turn them into additional
required inputs. Use the actual repository default branch as the base. Never
silently omit a rule or substitute another rule.

Read the base branch's `pnpm-workspace.yaml`, `pnpm-lock.yaml`, and central
wrapper. Follow its Node/pnpm requirements and install locked dependencies when
needed:

```powershell
pnpm install --frozen-lockfile
```

Inspect actual installed `$linter.rules`, upstream profiles, and ordered
project profile composition. Published `next` packages are not evidence that
the base branch installs them. If any requested rule requires a dependency
upgrade or unsupported policy composition, report the prerequisite and do not
pretend the entire list can be enabled. Do not silently switch to `typespec-next`
or upgrade packages.

In particular, upstream `client-sdk` explicitly disables
`@azure-tools/typespec-client-generator-core/use-create-for-put`. For projects
extending `resource-manager` followed by `client-sdk`, the latter cancels an
earlier enable. Do not work around that blocker with mass project-config edits
or by enabling ARM-only guidance for data-plane.

Already-enabled rules remain enabled and in the requested-list report. If the
whole list is already enabled and has no work to perform, report a no-op rather
than manufacture a PR.

## 2. Create the draft PR before enabling rules

When the current branch already has the user's requested open draft rollout PR,
reuse it. Do not create another branch or PR or revert existing enablement just
to replay the bootstrap. Infer this from the checked-out branch and PR metadata;
it is not another skill input.

Check actual remote URLs, write permissions, and branch restrictions. Prefer a
new branch in `Azure/azure-rest-api-specs`; use an authorized fork only when
direct push is unavailable, and disclose that fallback. Never push to the base
branch. Use a dedicated worktree at an exact base SHA.

Also inspect `.github/workflows/src/protected-files.ts` and the actual PR
author. Central `eng/**` policy and regression-test changes can require an
allowlisted maintainer author even when the current account can push a branch.
Ordinary reviewer approval, a fork, or a successful compile does not change an
author-based gate. Surface a required maintainer handoff before presenting the
rollout as merge-ready. An explicitly requested existing draft can retain the
pilot and its validation evidence, but must remain draft with the policy blocker
recorded. Never modify the allowlist or checks, impersonate an allowed author,
or remove required enablement/tests to disguise the restriction.

GitHub needs a branch difference to open a PR. Bootstrap with a real,
**policy-neutral** commit: add explicit `false` entries for the requested,
currently disabled rules in the appropriate central `enable` maps in
`eng/typespec-rulesets/index.ts`. Do this only after verifying those rules are
already effectively disabled in the relevant compositions. Preserve all
existing overrides and never set an already-enabled rule to `false`. These
staging entries must not enable or disable any additional behavior.

Commit and push that bootstrap, then create **one draft PR for the whole list**:

```powershell
git push -u <source-remote> <work-branch>
gh pr create --repo Azure/azure-rest-api-specs --base <default-branch> `
  --head <work-branch-or-owner:branch> --draft `
  --title <inferred-title> --body-file <progress-body-path>
```

Record the returned URL and verify that the draft exists before changing the
entries to `true`. Initialize its body with the requested/resolved list, base
SHA, package versions, pending enablement, pending full compilation, and pending
suppression work. Keep logs and progress artifacts outside tracked source.

## 3. Enable all requested rules in the existing draft

Change the staging entries to `true` in their applicable central profiles.
Rule IDs belong to the defining package, not the wrapper. For example:

```ts
"resource-manager": {
  extends: ["@azure-tools/typespec-azure-rulesets-original/resource-manager"],
  enable: {
    "@azure-tools/typespec-azure-resource-manager/no-query-in-post": true,
    "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op": true,
  },
},
```

Preserve upstream `extends` and unrelated overrides. Select profiles from each
rule's actual applicability, not its package name alone. Confirm later profiles
do not disable selected rules again. Do not edit service `tspconfig.yaml` files
to bypass composition or change package versions to bypass availability checks.

Build, commit, and push enablement to the **same draft PR**:

```powershell
pnpm --filter @azure-tools/typespec-azure-rulesets build
git push
```

A matching completed base run can help identify pre-existing failures, but
baseline harvesting is not a replacement for compilation after enablement.

## 4. Compile every project

Discover all TypeSpec projects under `specification` using repository discovery,
not only changed folders or a handpicked service. From the repository root:

```powershell
$projects, $checkedAll = & .\eng\scripts\Get-TypeSpec-Folders.ps1 -CheckAll
```

Keep the complete discovery manifest, deduplicated project paths, candidate SHA,
package versions, and per-project results. Cross-check the population using
`pnpm exec tsv --all --dry-run specification`. An empty or incomplete manifest is
a failure, not a green result.

For each project with `main.tsp`, run its actual configured compile:

```powershell
pnpm exec tsp compile <project-folder> --warn-as-error
```

For a client-only project use its entry point, consistent with TSV:

```powershell
pnpm exec tsp compile <project-folder>\client.tsp --no-emit --warn-as-error
```

Resolve entry points deliberately. A config-only parent can group independently
configured child projects: record it as a grouping config, and verify all its
child entry points are in the compile manifest rather than compiling a nonexistent
parent `main.tsp`. A folder with unexplained source entry points remains a
blocker. Record each process exit
code immediately and retain stdout/stderr with project attribution. Continue
through the entire population even when earlier projects fail. Compiler
warnings count as failures because `--warn-as-error` is mandatory.

Compilation can rewrite generated files. Use a dedicated checkout, compare
against the base, and do not commit incidental generated output. If parallelizing,
use separate checkouts for workers, then validate the combined candidate.

The existing **TypeSpec Validation - All** workflow can execute a full pass:
its `Compile` check invokes the same locked `tsp compile --warn-as-error`
command (and `--no-emit` for client-only entries) in isolated shard checkouts.
Use only completed runs for the exact enabled candidate and target ref. Fetch
all three shards per operating system and reconcile their logged project paths
against the complete manifest, including grouping configs; missing, duplicate,
skipped, or truncated coverage is not a successful pass. Read the actual
`pass`/`fail`/`skip` project groups and preserve failing compiler output. A
failure before `Compile` is not proof that a project compiled. This is direct
candidate compilation by CI, not harvesting a pre-enable baseline. It avoids
duplicating a long local full scan when equivalent complete candidate evidence
already exists. Local targeted compilation remains required after source edits.

## 5. Suppress and recompile until all projects pass

For every failing project, collect exact rule IDs, files, locations, messages,
and whether the failures predate enablement. A namespaced code alone does not
prove a diagnostic is a suppressible linter rule.

Load the repository's `azure-typespec-author` skill before production `.tsp`
edits and follow its grounding and validation requirements. If it is not
registered with the skill tool, read
`.github/skills/azure-typespec-author/SKILL.md` and the workflow references
directly. This is local skill loading, not an exemption from authoring guidance.
Missing or inaccessible required guidance remains a blocker.

Suppress only observed diagnostics belonging to the **requested rule list**
where retaining an existing API contract is intentional:

```tsp
#suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing published contract exposes this boolean; preserve wire compatibility during rule enablement."
legacyFlag?: boolean;
```

Use a contract-specific reason and the narrowest declaration that actually
suppresses the diagnostic. Inspect decorators, template diagnostic targets, and
shared declarations. Do not attach directives to the preceding declaration or
an unrelated `@@` augment decorator, blanket-suppress namespaces/projects, or
widen suppression scope to hide future violations.

Repeated parameter names and documentation are common. Match the enclosing
operation/template argument as well as the property, and inspect the resulting
diff before compiling. A textual match on `@query` or its doc comment can select
a GET/DELETE parameter instead of the reported POST parameter; remove any such
misplaced directive rather than leaving an unreported suppression behind.

For a large diagnostic set, deduplicate by rule, source file, location, and
message across versions, consuming projects, and operating systems. Use the
diagnostic revision's source and compiler AST to identify each exact property
and its enclosing operation or named parameter model. Insert directives
bottom-up, before that property's decorators, preserving docs and existing
directives. Never reuse stale line numbers against an already edited file.
Before applying bulk edits, verify all targets and reasons; afterward, parse
again and prove removing only the new directives recovers the original source
byte-for-byte. For shared parameter properties, retain explicit consumer
coverage in the final full pass and document the shared declaration scope.

Repeat the following loop:

1. Add narrow suppressions for the current, classified selected-rule diagnostics.
2. Format the edited scope, inspect the diff, and recompile the edited projects.
3. Investigate repeated diagnostics as possible placement mistakes. Correct
   placement instead of broadening scope. Classify newly exposed diagnostics
   before adding any further suppression.
4. Recompile **every project**, including consumers of changed shared files,
   with all requested rules still enabled. Record the complete pass results.
5. If any actionable selected-rule violations remain, repeat. Finish the compile
   loop only when a complete pass has **zero failed projects**.

There is **no fixed iteration limit**. Do not stop after an arbitrary number of
passes or after only touched projects compile. A repeated identical failure
after attempted corrections, an unavailable authoring prerequisite, a genuine
API design defect, a rule bug, an unrelated compiler error, or infrastructure
failure is an explicit blocker, not permission to loop blindly or suppress
unrelated diagnostics. Continue independent actionable work, record blockers in
the existing draft, and never claim convergence while they remain.

Never use `linter.disable`, global disablement, or
`specification/suppressions.yaml` to make this loop pass. The latter controls TSV
checks such as `FolderStructure/MustUseV2` and `Compile/ExtraSwagger`, not
individual linter diagnostics. Do not change API declarations, versions,
examples, decorators, existing suppressions, or generated Swagger.

## 6. Validate and finalize the same PR

From edited project directories, format the scope TSV uses:

```powershell
pnpm exec tsp format "../**/*.tsp" tspconfig.yaml
```

Run the final full compile pass **after all formatting and suppression edits**.
Rediscover projects and reconcile the manifest so added or previously missed
projects cannot escape the final pass. Verify generated API output is unchanged.

Compilation success is the loop's convergence condition, not a replacement for
the remaining repository checks. From the repository root:

```powershell
pnpm exec tsv <edited-project-folder>
pnpm --filter @azure-tools/typespec-azure-rulesets build
pnpm --filter @azure-tools/typespec-validation check
```

Review all resulting diffs. Commit and push the final enablement/suppression
set, then inspect revision-based suppression changes:

```powershell
pnpm exec typespec-suppressions --base <merge-base-sha> --head HEAD `
  --json-output <report-path> <edited-project-folder>
```

Include every touched project and shared consumer as appropriate. Check counts
and structural anchors for broad scope. CI additionally passes
`--check-rules-file eng/tools/typespec-suppressions/check-rules.json
--fail-on-approval`; do not alter that list or approval mechanism to bypass review.
Inspect the unfiltered report even for rules outside the curated subset.

Require **TypeSpec Validation - All** for the final candidate: all three Ubuntu
and all three Windows shards for the target ref. Central `eng/**` edits trigger
this workflow. A green baseline, a partial scan, or an earlier candidate is not
final validation. Use `tsv --git-clean` only in clean disposable validation
checkouts containing committed candidate edits; it discards tracked/untracked
work and must never run in the authoring checkout.

Update the **existing** draft PR with the requested/resolved list, package
versions, base/head SHAs, total project coverage, per-pass failure counts, added
suppressions, final compile outcome, unchanged-output evidence, suppression
report, CI links, and unresolved blockers. Keep central enablement and all
required suppressions together; do not create a second PR at the end, merge
partial enablement, auto-merge, or resolve reviewer threads.

Report compile convergence separately from merge readiness. In particular,
record a failing Protected Files check and its actual maintainer requirement;
do not characterize it as a compiler failure or claim reviewer approval alone
will clear an author-based restriction.

## Why PR #45589 is not the bootstrap step

At the inspected head, [PR #45589](https://github.com/Azure/azure-rest-api-specs/pull/45589)
is unmerged. It harvests existing logs rather than enabling disabled rules.
Its parser expects `##[group]Validating <folder>`, but current TSV prints
`pass`/`fail`/`skip` headings. Against a current failing shard it reported zero
folders and failures. Do not use that empty result as evidence of successful
compilation.

Candidate logs can supplement this workflow only after all requested rules are
enabled and the full project population is proven present. Verify every expected
log/shard download and candidate/dependency provenance. The direct
`tsp compile` loop above is the required execution path, not optional harvesting
of pre-enable CI.
