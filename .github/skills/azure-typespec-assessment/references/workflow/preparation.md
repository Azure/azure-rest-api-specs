# Preparation and Deterministic Analysis

Use a work directory that is not assessed source. The deterministic coordinator
owns repository inspection, comparison resolution, changed-file and project
discovery, dependency preflight, and sparse workspace creation.

For every fresh assessment, invoking the coordinator is the first operational
command. Do not first run `git status`, `git diff`, `git fetch`, `git worktree`,
`gh pr`, `gh api`, recursive searches, dependency checks, or manual project
discovery. If it returns a blocker, run only diagnostics needed for that
blocker.

For local assessment, use an explicitly supplied baseline ref or commit ID. If
none was supplied, ask the user to confirm `origin/main` (recommended) or
provide another ref/commit ID, using the host's user-question tool when
available. Wait for confirmation rather than accepting the script default.
This is a gate before preflight, merge-base commands, work-directory creation,
or analysis; approval to assess does not confirm a baseline. If the selected
baseline cannot be resolved, request a valid ref. If confirmation is
unavailable, report a blocker. The baseline question is the only action allowed
before the coordinator, which must run next after the answer.

For a PR, pass its URL or number directly. The coordinator resolves actual
base/head commits, fetches only missing refs, derives TypeSpec scope, and
creates the sparse checkout.

The coordinator captures committed, staged, unstaged, and relevant untracked
TypeSpec changes; creates service-scoped sparse base/current worktrees; selects
one API version per side; compiles each affected project independently with
AutoRest and TCGC using that pair; runs analyzers; records compiler-derived
documentation presence; calculates deterministic hunk coverage; writes bounded
`model-input.json` once; and builds `agent-workspace`.

Dependency setup supports npm and pnpm repositories. npm uses `npm ci`; pnpm
uses the exact version declared by `packageManager`, a frozen lockfile, and a
shared content-addressed store for the base and target worktrees. Both modes
disable lifecycle scripts and verify the installed TypeSpec toolchain against
the selected revision's lockfile.

For head, select the newest newly added API version, otherwise its latest
version. When no version was added and that head version exists in base, compile
both sides with it. When head adds a version, select base's latest stable
version, or latest preview if no stable exists. Record the pair and reasons in
the manifest and report.

## Commands

The coordinator verifies and, when necessary, installs the skill's own locked
dependencies before loading the assessment implementation. Do not run a
separate dependency-install command.

For local code, set values using the confirmed baseline:

```powershell
$Repo = $PWD
$Base = "<resolved-baseline-ref-or-commit>"
$Specification = "<project-or-spec-root>"
$Work = "<work-directory>"
$Skill = Join-Path $Repo ".github\skills\azure-typespec-assessment"

node (Join-Path $Skill "scripts\run-assessment-analysis.mjs") `
  --repo $Repo --base $Base --specification $Specification --output $Work
```

For a PR, run directly without separate metadata or checkout commands:

```powershell
$Repo = $PWD
$Work = "<work-directory>"
$Skill = "<azure-typespec-assessment-skill-directory>"

node (Join-Path $Skill "scripts\run-assessment-analysis.mjs") `
  --repo $Repo --pr "<pull-request-url-or-number>" --output $Work
```

For an immutable comparison not identified by a PR:

```powershell
node (Join-Path $Skill "scripts\run-assessment-analysis.mjs") `
  --repo $Repo --base "<base-ref-or-commit>" --head "<head-ref-or-commit>" `
  --output $Work
```

`--specification` is optional for PR and explicit-head modes; omitted scope is
derived from changed TypeSpec service roots. Do not use a full checkout or run
dimension analyzers against different inputs. Stop on the coordinator's
no-change result. If every active dimension is blocked, preserve the blocked
`not-assessed` result without Agent judgment. If only some are blocked, judge
ready items and retain every blocker reason.
