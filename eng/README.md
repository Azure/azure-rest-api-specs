# `eng` directory

The `eng` directory contains source code for automated tooling running on this repository pull requests.

For context on this directory, see [Design guidelines for spec repos validation tooling] (Microsoft-internal).

## Spec PR Validation

[Spec PR Validation](tools/spec-pr-validation/) checks the existing TypeSpec
Requirement policies for committed specification changes:

```bash
node eng/tools/spec-pr-validation/src/index.ts --base-commitish HEAD^ --head-commitish HEAD
```

Repository administrators must update required-check settings from **TypeSpec
Requirement** to **Spec PR Validation** when deploying the workflow rename.

## Protected files

The **Protected Files** check keeps repository-managed files out of specification
contributions. It is a contribution-scope check, not a request for code-owner approval.
Contributor guidance is in the [CI Fix Guide](../documentation/ci-fix.md#protected-files).

Maintenance-only PRs pass this check without a merge bypass. A PR is
maintenance-only when it does not change `specification/`, including deletions or
either side of a rename. Mixed specification and protected-file changes still
fail, regardless of the author's
ownership or reviews.

GitHub's existing CODEOWNERS review requirements determine who approves
maintenance changes; Protected Files does not maintain an author roster or
resolve team membership. Any contributor can propose a maintenance-only PR, but
all applicable code-owner reviews and other merge requirements still apply.
The read-only `pull_request` check evaluates the PR merge commit against its
base-branch parent, so policy changes are exercised on the PR that introduces
them. CODEOWNERS reviews still gate changes to the policy itself.
The existing trusted `azure-sdk` and
`azure-sdk-automation[bot]` author exemptions remain unchanged.

## Contributor readiness

Contributor readiness runs only for PRs that change `specification/`, including
mixed specification and engineering changes. Engineering-only PRs are skipped
without account checks or a readiness comment/check, including review events and
manual `/azsdk check-access` requests. The PR-event notifier uses a path filter;
the publisher verifies current changed files for every trigger.

Internal contributors need **Azure organization membership and repository write
access** for the PR workflow to work correctly. Microsoft organization membership
is not required by this check. The **Contributor readiness** check reports public
Azure membership visibility and effective repository access for the PR author,
commit authors/committers, and reviewers with an `APPROVED` review. Comments,
requests for changes, pending reviews and dismissed reviews do not add reviewer
participants. Authors and commit participants remain included independently.
The check is non-blocking and does not change merge rules, but the access
requirements are not optional for the internal workflow. External fork
contributions remain allowed.

The comment starts with a highlighted warning about the risk to PR approvals and
pipeline runs, then groups findings by affected user and separates access issues
from their **PR impact**. A PR author without repository write access cannot run
Azure DevOps pipelines for that PR. A reviewer without write access cannot provide
an approval that counts toward required reviews (GitHub's green approval check).
That reviewer must set up or renew their own access, not the PR author.
Users with both roles see both consequences; commit-only participants do not
receive author or reviewer consequences. Other GitHub approval rules still apply.

🔴 marks a confirmed issue and 🟡 marks checks that could not be verified. Private
or missing public membership is not evidence of missing repository write access.
Membership-only findings and unavailable permission lookups do not establish
pipeline or review failures; their PR impact is reported as undetermined.
The report links to [setup and access renewal](https://aka.ms/azsdk/access).
When findings exist, a
collapsed **Contributors with verified access** section lists human participants
whose public Azure membership and effective repository write access were both
confirmed, together with their roles. Unverified and unchecked users are never
listed as passing. Each section shows at most 100 entries. Clean reports omit
the details section and do not create a comment. The job summary shows the same
report.
Organization names in membership findings link to the organization's People page,
with the affected user's login prefilled in the search.

After changing access, comment `/azsdk check-access` on the PR. The PR author,
resolved commit participants, approving reviewers and maintainers can refresh,
including affected participants without write access. One bot comment is updated
when findings exist and resolved when they are fixed; clean PRs receive only the
check. Permission changes alone do not trigger an automatic refresh.

The check uses `GITHUB_TOKEN`: no additional credentials, bot service or Azure
resources are needed. Private memberships, team membership, manager approvals,
access expiry dates and Azure DevOps roles are not inspected. CODEOWNER coverage
and other approval rules remain GitHub's responsibility. Unmapped identities,
inaccessible API results, and PRs exceeding the commits API's 250-commit limit are
reported as incomplete rather than silently passing.

PR opening, reopening, new commits, ready-for-review transitions, submitted
reviews and review dismissals use an unprivileged notification workflow followed
by a trusted `workflow_run` publisher. The notifier has no checkout or token permissions;
the publisher runs only default-branch code and resolves PRs from GitHub metadata.
No `pull_request_target` trigger is used.

Editing review text does not rerun the check. Dismissing an approval refreshes
the report so it no longer includes that reviewer solely for the dismissed review.
Fork workflow approval policies can delay automatic refreshes. The comment
command runs from the default branch and remains available without
waiting for the notifier. Do not make this non-blocking check required.

## Branch cleanup

[Cleanup stale branches](../.github/workflows/branch-cleanup.yaml) runs weekly on
Monday at 05:23 UTC. Scheduled runs delete eligible branches automatically.
Manual runs default to **dry-run**, which logs candidates without deleting anything.
Run the workflow from the default branch; it is disabled on forks.

A branch is eligible when its last commit is older than **90 days** for `copilot/*`,
or **2 years (730 days)** for other branches. Closed-unmerged and no-PR branches
are included; recent comments on a closed PR do not extend retention.

Manual runs can override these cutoffs independently using `copilot-days` and
`other-days`. Both must be positive whole numbers. Scheduled runs always use the
90-day and 730-day defaults. For example, to preview a shorter range:

```bash
gh workflow run branch-cleanup.yaml --repo Azure/azure-rest-api-specs --ref main \
  -f dry-run=true -f copilot-days=30 -f other-days=365
```

The default branch, protected branches, and sources and targets of open PRs
(including drafts) are skipped. Long-lived names and prefixes such as `release-`,
`feature/` and `archive/` are also excluded; the complete list is at the top of the
[script](../.github/workflows/src/branch-cleanup.ts).
`dev-`, `dev/`, and `published/` branches are eligible under the same age cutoff as
other non-Copilot branches.
Keep a long-lived branch by protecting it or adding it to those exclusions.
Candidates and their SHAs are logged, and SHA-guarded Git pushes refuse to delete
changed tips. API and deletion failures fail the workflow.

## Initial issue triage

[Issue Triage](../.github/workflows/issue-triage.md) classifies newly opened human
issues as repository engineering (`EngSys`), service-contract/runtime issues
(`Service Attention`), or uncertain (`needs-team-triage`). High-confidence service
issues can also receive a service label and API-plane label; clear issue kinds
receive `bug`, `feature-request`, `question`, or `documentation`.
It processes internal and external reports, preserves existing labels, and leaves
one concise comment explaining the routing, with a possible duplicate link or
one missing-information question when useful. Re-running updates that workflow's
existing comment rather than creating another. It does not assign owners, set
priorities, close issues, or establish that a request is still relevant.
Repository policy continues to handle customer-reported labels separately.
That policy may clear `needs-triage` when another label is added; the triager
itself only adds labels.
Label names and candidate areas come from the checked-in catalogs, not a copied
inventory or assumed color palette. Ownership-dependent reasoning consults the
current `CODEOWNERS` entries rather than embedding service-to-owner mappings.

The workflow runs only on upstream `main`. It skips bot-authored, closed, locked,
and non-actionable reports. Manual dispatch defaults to a dry run:

```bash
gh workflow run issue-triage.lock.yml --repo Azure/azure-rest-api-specs --ref main \
  -f issue-number=123 -f dry-run=true
```

Set `dry-run=false` to apply the labels and comment. An issue changed during
investigation is left unchanged and the run fails with a refresh instruction;
dispatch again to triage its current content.
Eligibility, content, and labels are refreshed immediately before the first write.
Agent and applier failures are reported in workflow logs, not by creating
additional failure-report issues, including during dry runs.
The pinned gh-aw runtime can still record threat-detection warnings or failures
in its shared tracking issue; that framework logging is separate from the
triage decision and is not disabled by dry-run mode.
The separate Backlog Triage workflow investigates old issues for resolution or
obsolescence; initial triage does not replace that investigation.

## Repository labels

Repository label configuration starts at [`.github/labels.yaml`](../.github/labels.yaml).
It extends local definition files under `.github/labels/`: `common.yaml` contains
shared process/triage labels, `services.yaml` contains service/team labels
(both shared and repository-specific), and `workflow.yaml` contains
repository-specific process labels. Shared labels follow the SDK registry's
classification: color `e99695` identifies its service/area labels. These are
checked-in definitions, not live imports from another repository.
Sort entries alphabetically within each file.
Add or edit labels through a pull request, keeping names unchanged unless a
separate migration is intended. Names, six-digit hex colors, and descriptions are
validated before synchronization. Empty descriptions are allowed. Label
authorization remains separate in `.github/protected-labels.yml`; defining a
label does not grant permission to apply it.

### Extending label catalogs

```yaml
unconfiguredLabels: archive
extends:
  - ./labels/common.yaml
  - ./labels/services.yaml
  - ./labels/workflow.yaml
labels:
  - name: example
    color: "123456"
    description: A repository-specific label
```

Each base file can also contain `extends` and `labels`. Paths are relative to
the declaring file and must resolve within `.github/labels/` (or to the root
catalog). URLs and cross-repository imports are not supported. Only the root
defines `unconfiguredLabels`; reusable files contain definitions, not cleanup
policy.

Labels merge by case-insensitive name. An extending file can override individual
fields while inheriting the rest. Conflicting fields from sibling bases must be
overridden explicitly in the extending file; file order does not silently decide
them. Duplicate names in one file, cycles, invalid paths, missing files, and
incomplete resolved labels fail the entire load before any mutation.

Canonical labels may declare `aliases` to retire older names:

```yaml
labels:
  - name: DoNotMerge
    color: "b60205"
    description: Hold merge after approval
    aliases: ["Do Not Merge", "do-not-merge"]
```

Aliases must be unique across the resolved catalog and cannot also be configured
label names. In archive mode, the workflow first adds the canonical label to all
issues and PRs carrying each alias, including closed items, then archives the
alias. Assignment failures prevent archival. Keep the mapping through the grace
period so canonical assignments are verified before final deletion. Preserve
mode and dry runs do not migrate assignments.

The shared SDK registry still contains `Do Not Merge`. Running its separate
sync script against this repository can recreate that alias; retire or exclude
that provisioning path before relying on the name staying absent.

The CLI and workflow use the same loader. Audits record every loaded source and
its hash. Before applying changes, the workflow resolves the complete catalog
from one default-branch commit and compares all source hashes, so a change to an
inherited file invalidates the plan just like a change to the root.

After installing dependencies from the repository root, validate or preview:

```bash
pnpm --dir .github labels
pnpm --dir .github labels --preview
```

Validation is offline. Preview reads upstream labels without changing anything;
set `GITHUB_TOKEN` to authenticate if needed. It lists proposed creates, metadata
updates (including unarchiving), archives, expired archives to delete, and
unconfigured labels and alias migrations. It does not enumerate affected items.

[Sync repository labels](../.github/workflows/sync-repo-labels.yaml) runs after
relevant changes on `main`, when repository label definitions change, and daily.
The schedule also catches changes made by workflows using `GITHUB_TOKEN`, which
do not trigger further label-event workflows. Manual runs default to dry-run.
Mutating runs use the upstream default branch and are disabled on forks. PR
validation never changes GitHub labels.

The `unconfiguredLabels: archive` policy creates/updates configured labels and
archives labels absent from the catalog. This applies repository-wide, including
labels created manually or by other automation. Add legitimate labels through
a PR before consumers begin using them. Removing a catalog entry starts the
archive lifecycle described below on the next synchronization.

To pause archival and deletion, change the policy to `unconfiguredLabels: preserve`
through a reviewed PR. That mode still synchronizes configured labels but only
warns about unconfigured ones. Manual workflow inputs cannot override the
checked-in policy.

### Archive lifecycle

In archive mode, an active label absent from the catalog is renamed in place to
`archived: <original name>`, natively archived in GitHub, and given this description:

> Archived by label sync: absent from .github/labels.yaml. Eligible for deletion after 14 days.

The prefix makes the status visible on existing issues and PRs. Renaming preserves
the label's ID and assignments, but changes name-based searches and automation;
any automation needing the original label should define it in the catalog.
The `archived: ` prefix is reserved and cannot be used in catalog definitions.

Archiving preserves existing assignments and prevents new ones. GitHub records
the archive date in `archived_at`; subsequent synchronization does not reset it.
The daily workflow only considers a label for deletion when it is still absent
from the catalog, has been archived for at least **14 full days**, and still has
that exact warning description. Manually archived labels without the warning
are left alone, even if they are old. Missing or invalid archive timestamps fail
validation rather than being inferred.

Adding the original name back to the catalog restores the same label's name,
description, and color and removes its archived state, including in preserve
mode. The synchronizer recognizes the prefix together with the exact warning;
it does not create a duplicate. This cancels its deletion.
Removing it again starts a new grace period on the next archive.

Name collisions stop synchronization for manual resolution, including when both
the original and managed archived name already exist. Prefixing a name longer
than 40 characters exceeds GitHub's 50-character limit and also fails explicitly:
rename it deliberately before removing it from the catalog. Names are never
silently truncated. Earlier managed archives without the prefix acquire it on
the next archive-mode run without resetting their timestamp, unless already
eligible for deletion.

After the grace period, the archived label is deleted without adding a generic
replacement label. Its existing assignments remain intact until deletion;
deletion then removes those assignments from GitHub. Explicit alias mappings
preserve the corresponding canonical classification. Other labels are preserved,
and **no comments are posted**.

Each run uploads `label-audit-before-<run-id>-<attempt>` before applying changes.
It records original label metadata, archive timestamps, and, for alias migrations
and expired labels, affected item numbers, types, URLs, and states.
`label-audit-outcome-<run-id>-<attempt>` records
operations and failures. Download them from the workflow run's **Artifacts**
section. Artifacts request 90-day retention, subject to repository policy; they
are not permanent history. Export them before expiration if permanent retention
is needed.

Discovery, audit upload, or alias migration failures prevent deletion. Catalog changes,
renamed labels, changed archive timestamps/warnings, or new unaudited assignments
also stop cleanup. On partial
failure, some items may have both the alias and canonical label. Inspect the
outcome artifact, resolve the error, and rerun; canonical additions are idempotent.
If a run is interrupted, `pending` operations may or may not have completed:
compare the audit with live state before recovery.

GitHub does not provide an atomic migration-and-deletion transaction. The
workflow rechecks assignments before deletion, but concurrent manual changes can
still race it. Restoring a deleted label does not restore its assignments; use
the audit to guide manual recovery. This workflow detects/reconciles label
creation afterward, rather than preventing creation in the GitHub UI.

## Code conventions

Below are code convention we strive to follow in `eng` directory:

### package.json

- We align `package.json` dependencies versions across all `package.json` files.
- We align `package.json` dependencies numbers with [microsoft/typespec package.json].
  In few cases we allow more frequent update cadence.
- We avoid doing package overrides where possible.
- We order `package.json` keys as follows: `name private type main bin scripts engines dependencies devDependencies`.

### pnpm and the lock file

- This repo uses [pnpm] workspaces. **Do not use `npm` or `yarn`.** Running
  `npm install`, `npm ci`, or `yarn` fails fast (npm cannot resolve the `catalog:` and
  `workspace:` dependency protocols), so contributors must use pnpm.
- You must have pnpm installed globally on your machine. The simplest way is to run
  `npm run install-pnpm`, which installs the exact pinned pnpm version via
  `npm install -g pnpm@<version>` (the version is read from the root `package.json`
  `packageManager` field). The command is idempotent and supports `--dry-run`. You can
  also install pnpm yourself with `npm install -g pnpm`.
- Once a global pnpm exists, the `packageManager` field keeps it on the pinned version:
  pnpm self-versions, so running any `pnpm` command auto-downloads and switches to the
  pinned version. This only works when pnpm is already installed — it cannot bootstrap
  the initial install, which is what `npm run install-pnpm` is for.
- Install dependencies from the repo root with `pnpm install`. There is a single
  top-level `pnpm-lock.yaml`; do not add other lock files.
- We maintain a single `pnpm-workspace.yaml` at the root that lists workspace packages
  and a shared dependency `catalog:`. All external dependencies must reference the
  catalog with `catalog:` (or `catalog:<name>` for a named catalog); use `workspace:`
  for local workspace dependencies.
- Run `pnpm check:workspace` from the repo root to validate catalog usage and lockfile
  portability. The [Eng workflow](../.github/workflows/eng.yml) runs these checks in CI.
  It checks `dependencies`, `devDependencies`, `peerDependencies`, and
  `optionalDependencies` in the root and all packages selected by pnpm. Manifests
  outside the workspace, including test fixtures and specification projects, are
  not checked. pnpm validates catalog entries themselves during installation.
  `catalogMode: strict` only controls `pnpm add`, so it does not replace this check.
  Unused entries in default and named catalogs produce warnings, not failures.
  The lockfile check rejects explicit tarball resolutions for registry packages,
  which can point to environment-specific proxies. Git-hosted dependencies
  (`gitHosted: true`) are allowed to retain their tarball URLs.
- When you add, modify, or remove `package.json` dependencies, run `pnpm install` and
  commit the resulting `pnpm-lock.yaml` changes so the lock file stays in sync and free
  of unused dependencies.
- CI installs the pinned pnpm version via `.github/actions/setup-node-install-deps`
  (which reads the `packageManager` field) and runs `pnpm ci`.
- In repeated validation loops, run installed Node.js tools directly rather than starting
  `pnpm exec` or `npm exec` for each file or project. TypeScript consumers can use
  `execNodeBin` from `@azure-tools/specs-shared/exec`; PowerShell scripts can invoke
  `node` with a CLI entrypoint anchored to the repository or script directory. Keep pnpm
  for dependency installation and package-management operations.

## Building and testing

Run these commands from the repository root after `pnpm install`:

```bash
pnpm build       # Build tooling and TypeSpec libraries with pnpm -r
pnpm test        # Run all Vitest projects (watch mode locally)
pnpm test:ci     # Run all projects once with coverage
pnpm check       # Workspace validation, build, lint, format:check, and test:ci
```

Root `pnpm build` delegates to `.github`, `.github/shared`, `eng/scripts`,
each tool's build script, and libraries under `libs/`. It excludes the `eng/tools` aggregate package to avoid
building the tools twice; that package's local `pnpm build` remains available.
Tooling builds perform type checking only, with no JavaScript output. TypeSpec
libraries compile with the library linter enabled and warnings treated as errors.
Foundry Core also type-checks its TypeScript without emitting JavaScript. Its
workspace exports load TypeScript directly; only packing emits JavaScript for
npm consumers.

Root `vitest.config.mts` defines one workspace using `test.projects` and exports
`defaultVitestConfig` for standalone package configs. Packages inherit shared
defaults without inheriting the workspace project list, so their existing local
Vitest commands, watch/run behavior, and coverage flags remain available:

```bash
pnpm test --project @azure-tools/typespec-validation
pnpm --filter @azure-tools/typespec-validation run test:ci
```

Shared coverage defaults exclude CLI wrappers, test code, and generated coverage.
Workspace runs write reports to root `coverage/` and enforce 100% coverage for
shared-library sources across the selected projects. Standalone runs write
reports in the package and honor local overrides, including the shared package's
independent 100% gate. The two integration-only packages retain their standalone
coverage-free commands. `typespec-migration-validation` has no Vitest project
and participates only in the root build.

The full test run requires PowerShell (`pwsh`). The conversion smoke test uses a
self-contained Swagger fixture under `eng/tools/tsp-client-tests/test/fixtures/`.
CI's sparse checkout only needs `.github`, `eng`, and `libs`, along with the root configuration
files. The ARM resource-provider tests retain their existing behavior when
`specification/` is absent. Resolve test fixture paths from `import.meta.dirname`,
not the invocation working directory, to support both modes.
Mirrored `eng/common` packages and arbitrary specification projects are not part
of the tooling workspace.

The `.mts` extension keeps the root Vitest config as ESM without changing the
repository's default module type. Root `tsconfig.json` checks this config and is
also covered by the GitHub package build.

[Eng](../.github/workflows/eng.yml) validates the workspace, builds once on Linux,
and runs the Vitest workspace on Ubuntu and Windows with Node 24. Its dedicated
GitHub Actions lint job runs actionlint and zizmor without installing workspace dependencies.
New tools do not need their own workflows. `github-test.yaml` separately verifies
production-only module imports and compiled agentic workflow locks.

## Publishing TypeSpec libraries

Publishable TypeSpec libraries live under `libs/` and participate in the pnpm
workspace. [Foundry Core](../libs/foundry-core/README.md) is the initial package.

The [publish-libraries pipeline](pipelines/publish-libraries.yml) builds and
packs Foundry Core into a `packages` pipeline artifact when `libs/` changes on
`main`. PR validation remains in the `Eng` GitHub workflow. It follows the
[TypeSpec publishing pipeline](https://github.com/microsoft/typespec/blob/main/eng/tsp-core/pipelines/publish.yml):
1ES builds produce package artifacts, and a separate release job publishes them
to npm through ESRP. `pnpm pack` resolves catalog dependencies in the published
manifest. Foundry Core's `prepack` script compiles its runtime to JavaScript, and
`publishConfig` switches the packed exports from source TypeScript to that output.
No Chronus or scheduled nightly releases are configured.

Internal `main` CI runs automatically publish development versions to the
`latest` npm tag. The version is `<major>.<minor>.<patch>-dev.<change-count>`,
counting first-parent Git commits that changed the library folder. Every folder change,
including documentation or tests, produces a new version. Version changes happen
only in the build workspace, not in Git.

Reruns and unrelated commits keep the same version. The build does not query npm
for publication status; repeat publishing is handled by the existing publishing job.

Before the first release, an Azure SDK pipeline administrator must register this
YAML as a pipeline in the **internal** Azure DevOps project, authorize its 1ES
templates, agent pools, and Azure SDK ESRP service connection, and configure the
`package-publish` environment with the required approvers. Confirm authorization
to publish `@azure-tools/typespec-foundry-core` in the `@azure-tools` npm scope.
These are external setup steps, not resources created by the YAML.

For an explicit release of the version in `package.json`:

1. Update `libs/foundry-core/package.json` to an unpublished version, run
   `pnpm install`, and merge the changes into `main`.
2. Queue the pipeline with `Publish` left **false** to inspect the package artifact.
3. Queue the same commit on `main` with `Publish` set to **true**, then approve the
   release environment. Publishing is available only from this public repository's
   `main` branch in the internal Azure DevOps project.

Manual runs with `Publish` **false** only build the artifact. With `Publish`
**true**, the shared publishing job uses `beta` for prerelease manifest versions
and `latest` for stable versions.
Automatic development releases intentionally use `latest`, so default installs
receive development builds; consumers requiring a fixed release should pin its
version.

To inspect a package locally without publishing:

```bash
pnpm --filter @azure-tools/typespec-foundry-core build
pnpm --filter @azure-tools/typespec-foundry-core pack --pack-destination "$PWD/tmp/packages"
```

## Linting and formatting

- Run `pnpm lint` from the repository root to lint the enabled packages
  in `.github`, `eng/tools`, and `libs`, plus root `vitest.config.mts`, in one oxlint invocation.
  Use `pnpm lint:fix` to apply
  safe fixes. File selection lives in the root `.oxlintrc.json`, so the root command
  is simply `oxlint .`; other repository folders and root-level files are excluded.
- The root `.oxlintrc.json` is the single lint configuration. It preserves the previous
  ESLint recommended and TypeScript recommended type-checked rules, with type-aware
  linting provided by `oxlint-tsgolint`. Duplicate arguments and octal literals are
  rejected by strict-mode parsing instead of separate lint rules.
- `.github/workflows/lint.yaml` runs linting once on Linux for all packages, outside
  the test OS matrix. Build/test jobs must not invoke code linting again.
  Package-local `pnpm lint` scripts
  remain available for development.
- `openapi-diff-runner` and `typespec-migration-validation`
  are excluded in the root configuration. Their type checks and tests run separately.
  Unused suppressions in linted packages fail linting.
- Discuss any desired rule divergences and explain them in the configuration.
- Run `pnpm format` or `pnpm format:check` from the repository root to format or
  check `.github`, `eng/tools`, `libs`, and `vitest.config.mts` in one Oxfmt invocation. Package-local commands
  remain available and inherit the root `.oxfmtrc.json`.
- `.github/workflows/format.yaml` checks formatting once on Linux, outside the
  test OS matrix. Do not add formatting steps to build/test jobs.
- Tooling uses a line width of 100 with the existing fixture, generated-file, and
  unmanaged-content exclusions. Import organization and package.json sorting are
  intentionally disabled; lint/type checks still report unused imports.
- Swagger/OpenAPI definitions and examples under `specification/**/*.json` are
  excluded from Oxfmt. The custom Prettier plugin and root Prettier dependency
  remain in use for these JSON files, preserving numeric literals such as `100.00`.
  The existing Swagger PrettierCheck pipeline and root `.prettierrc.json` are
  unchanged. Run `pnpm exec prettier --write <path-to-example.json>` to format an
  example.
  TypeSpec validation uses `tsp format` for both `.tsp` files and `tspconfig.yaml`.
  Run `pnpm exec tsp format "../**/*.tsp" tspconfig.yaml` from the TypeSpec project
  folder to format both.
- Install the recommended Oxc VS Code extension for tooling formatting, Prettier
  for Swagger/example JSON, and the TypeSpec extension for `.tsp` files. For JSON
  excluded from Oxfmt, use **Format Document With... > Prettier** without changing
  the default formatter for tooling files.

[pnpm]: https://pnpm.io
[Design guidelines for spec repos validation tooling]: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1153/Design-guidelines-for-spec-repos-validation-tooling
[microsoft/typespec package.json]: https://github.com/microsoft/typespec/blob/main/package.json
[npm/cli #7384]: https://github.com/npm/cli/issues/7384
