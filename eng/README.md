# `eng` directory

The `eng` directory contains source code for automated tooling running on this repository pull requests.

For context on this directory, see [Design guidelines for spec repos validation tooling] (Microsoft-internal).

## Contributor readiness

Contributor readiness runs only for PRs that change `specification/`, including
mixed specification and engineering changes. Engineering-only PRs are skipped
without account checks or a readiness comment/check, including review events and
manual `/azsdk check-access` requests. The PR-event notifier uses a path filter;
the publisher verifies current changed files for every trigger.

The advisory **Contributor readiness** check reports public Microsoft/Azure
membership visibility and effective repository access for the PR author, commit
authors/committers, and all submitted reviewers. It does not change merge rules.
Missing public membership produces conditional internal-onboarding guidance, not
a claim that an external contributor is unauthorized.

The comment groups findings by affected user: 🔴 marks a confirmed issue and 🟡
marks checks that could not be verified. It links to
[setup and access renewal](https://aka.ms/azsdk/access); users without findings
are omitted to keep the report short. The job summary shows the same report.
Organization names in membership findings link to the organization's People page,
with the affected user's login prefilled in the search.

After changing access, comment `/azsdk check-access` on the PR. The PR author,
resolved commit participants, submitted reviewers and maintainers can refresh,
including affected participants without write access. One bot comment is updated
when findings exist and resolved when they are fixed; clean PRs receive only the
check. Permission changes alone do not trigger an automatic refresh.

The check uses `GITHUB_TOKEN`: no additional credentials, bot service or Azure
resources are needed. Private memberships, team membership, manager approvals,
access expiry dates and Azure DevOps roles are not inspected. CODEOWNER coverage
and other approval rules remain GitHub's responsibility. Unmapped identities,
inaccessible API results, and PRs exceeding the commits API's 250-commit limit are
reported as incomplete rather than silently passing.

PR opening, reopening, new commits, ready-for-review transitions and submitted
reviews use an unprivileged notification workflow followed by a trusted
`workflow_run` publisher. The notifier has no checkout or token permissions;
the publisher runs only default-branch code and resolves PRs from GitHub metadata.
No `pull_request_target` trigger is used.

Editing or dismissing a review does not rerun the check; those reviewers remain
included. Fork workflow approval policies can delay automatic refreshes. The
comment command runs from the default branch and remains available without
waiting for the notifier. Do not make this advisory check required.

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
(including drafts) are skipped. Long-lived names and prefixes such as `dev-`,
`release-`, `feature/`, `published/`, and `archive/` are also excluded; the complete
list is at the top of the [script](../.github/workflows/src/branch-cleanup.ts).
Keep a long-lived branch by protecting it or adding it to those exclusions.
Candidates and their SHAs are logged, and SHA-guarded Git pushes refuse to delete
changed tips. API and deletion failures fail the workflow.

## Repository labels

Repository label definitions live in [`.github/labels.yaml`](../.github/labels.yaml).
Keep service and team labels in their own section, separate from repository and
workflow labels, and sort entries alphabetically within each section.
Add or edit labels through a pull request, keeping names unchanged unless a
separate migration is intended. Names, six-digit hex colors, and descriptions are
validated before synchronization. Empty descriptions are allowed. Label
authorization remains separate in `.github/protected-labels.yml`; defining a
label does not grant permission to apply it.

After installing dependencies from the repository root, validate or preview:

```bash
pnpm --dir .github labels
pnpm --dir .github labels --preview
```

Validation is offline. Preview reads upstream labels without changing anything;
set `GITHUB_TOKEN` to authenticate if needed. It lists proposed creates, metadata
updates (including unarchiving), archives, expired archives to delete, and
unconfigured labels. It does not enumerate replacement assignments.

[Sync repository labels](../.github/workflows/sync-repo-labels.yaml) runs after
relevant changes on `main`, when repository label definitions change, and daily.
The schedule also catches changes made by workflows using `GITHUB_TOKEN`, which
do not trigger further label-event workflows. Manual runs default to dry-run.
Mutating runs use the upstream default branch and are disabled on forks. PR
validation never changes GitHub labels.

The current `unconfiguredLabels: preserve` policy creates/updates configured
labels and warns about unconfigured ones. It does not automatically import,
archive, or delete them. Removing an entry from YAML therefore leaves its GitHub label and
assignments intact. Resolve warnings by adding legitimate labels through a PR
or reviewing the unwanted labels separately.

### Disabled archive lifecycle

Archival and deletion are implemented but **disabled**. Only a reviewed change to
`unconfiguredLabels: archive` enables them; manual workflow inputs cannot override
the catalog policy. Do not enable it until migration is complete and external
automation, affected-item volume, and audit retention have been reviewed.

In archive mode, an active label absent from the catalog is natively archived
in GitHub and given this description:

> Archived by label sync: absent from .github/labels.yaml. Eligible for deletion after 14 days.

Archiving preserves existing assignments and prevents new ones. GitHub records
the archive date in `archived_at`; subsequent synchronization does not reset it.
The daily workflow only considers a label for deletion when it is still absent
from the catalog, has been archived for at least **14 full days**, and still has
that exact warning description. Manually archived labels without the warning
are left alone, even if they are old. Missing or invalid archive timestamps fail
validation rather than being inferred.

Adding a label back to the catalog unarchives it and restores its configured
description and color, including in migration mode. This cancels its deletion.
Removing it again starts a new grace period on the next archive.

After the grace period, the existing replacement safeguard still applies: all
affected issues and PRs, including closed and merged items, receive the reserved
`label-deleted` label before the archived label is deleted. Other labels are
preserved, and **no comments are posted**. An unused expired label is deleted
without applying the marker anywhere.

Each run uploads `label-audit-before-<run-id>-<attempt>` before applying changes.
It records original label metadata, archive timestamps, and, for expired labels,
affected item numbers, types, URLs, and states.
`label-audit-outcome-<run-id>-<attempt>` records
operations and failures. Download them from the workflow run's **Artifacts**
section. Artifacts request 90-day retention, subject to repository policy; they
are not permanent history. Export them before expiration if permanent retention
is needed.

Discovery, audit upload, or marker failures prevent deletion. Catalog changes,
renamed labels, changed archive timestamps/warnings, or new unaudited assignments
also stop replacement. On partial
failure, some items may have both the original label and the marker. Inspect the
outcome artifact, resolve the error, and rerun; marker additions are idempotent.
If a run is interrupted, `pending` operations may or may not have completed:
compare the audit with live state before recovery.

GitHub does not provide an atomic replacement-and-deletion transaction. The
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
pnpm build       # Run each tooling package's build script with pnpm -r
pnpm test        # Run all Vitest projects (watch mode locally)
pnpm test:ci     # Run all projects once with coverage
pnpm check       # Workspace validation, build, lint, format:check, and test:ci
```

Root `pnpm build` delegates to `.github`, `.github/shared`, `eng/scripts`, and
each tool's build script. It excludes the `eng/tools` aggregate package to avoid
building the tools twice; that package's local `pnpm build` remains available.
Builds perform type checking only, with no JavaScript output.

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
CI's sparse checkout only needs `.github` and `eng`, along with the root configuration
files. The ARM resource-provider tests retain their existing behavior when
`specification/` is absent. Resolve test fixture paths from `import.meta.dirname`,
not the invocation working directory, to support both modes.
Mirrored `eng/common` packages and arbitrary specification projects are not part
of the tooling workspace.

The `.mts` extension keeps the root Vitest config as ESM without changing the
repository's default module type. Root `tsconfig.json` checks this config and is
also covered by the GitHub package build.

[Eng](../.github/workflows/eng.yml) validates the workspace, type-checks once on Linux,
and runs the Vitest workspace on Ubuntu and Windows with Node 24.
New tools do not need their own workflows. `github-test.yaml` separately verifies
production-only module imports, workflow YAML, and compiled agentic workflow locks.

## Linting and formatting

- Run `pnpm lint` from the repository root to lint the enabled packages
  in `.github` and `eng/tools`, plus root `vitest.config.mts`, in one oxlint invocation.
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
  check `.github`, `eng/tools`, and `vitest.config.mts` in one Oxfmt invocation. Package-local commands
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
