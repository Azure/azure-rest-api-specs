# @azure-tools/typespec-suppressions

A CLI tool that detects and reports changes to TypeSpec lint suppressions between two git revisions. It's designed to enforce approval workflows when new or modified suppressions are introduced in pull requests.

## Location

```
eng/tools/typespec-suppressions/
```

## What It Does

This tool:

1. **Extracts suppressions** from TypeSpec projects by scanning:
   - **Inline suppressions**: `#suppress` directives in `.tsp` files
   - **Config suppressions**: `linter.disable` entries in `tspconfig.yaml`

2. **Diffs suppressions** between a base revision (e.g., `origin/main`) and a head revision (e.g., `HEAD`) to identify:
   - **New** suppressions added
   - **Removed** suppressions deleted
   - **Changed** suppressions (same rule/location but different justification)
   - **Unchanged** suppressions

3. **Enriches metadata** by resolving rule descriptions and documentation URLs from installed linter packages (e.g., `@azure-tools/typespec-azure-core`).

4. **Reports results** as:
   - JSON (full structured report)
   - Markdown (human-readable summary for PR comments)
   - GitHub Actions inline `::warning` annotations (via `--github-annotations`), anchored to each suppression's source location so they surface on the PR diff

5. **Gates approval** by setting `requiresApproval: true` when new or changed suppressions exist, and optionally exits with code 1 via `--fail-on-approval`.

## Usage

```bash
npx typespec-suppressions --base <commitish> [--head <commitish>] [options] <spec-folder> [<spec-folder> ...]
```

### Arguments

| Argument        | Description                                                                       |
| --------------- | --------------------------------------------------------------------------------- |
| `<spec-folder>` | One or more paths to TypeSpec project directories (must contain `tspconfig.yaml`) |

### Options

| Option                      | Default      | Description                                                                                                                                                                    |
| --------------------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--base`                    | _(required)_ | Base git revision to compare against (e.g., `origin/main`, a commit SHA)                                                                                                       |
| `--head`                    | `HEAD`       | Head git revision to analyze                                                                                                                                                   |
| `--json-output <path>`      | stdout       | Write JSON report to a file instead of stdout                                                                                                                                  |
| `--markdown-output <path>`  | _(none)_     | Write a Markdown summary to a file                                                                                                                                             |
| `--check-rules-file <path>` | _(none)_     | Path to a JSON file listing the lint rules whose suppressions require approval. Enables **checked-only mode** (see below). Resolved relative to the current working directory. |
| `--github-annotations`      | `false`      | Emit a GitHub Actions `::warning` annotation for each new/changed suppression, anchored to its source file and line so it renders as an inline warning on the PR diff          |
| `--fail-on-approval`        | `false`      | Exit with code 1 if new/changed suppressions require approval                                                                                                                  |

### Check rules (scoped approval)

By default (no `--check-rules-file`), the tool reports **all** new/changed
suppressions and `requiresApproval` reflects the full diff (**legacy mode**).

When `--check-rules-file <path>` is provided, the tool runs in **checked-only
mode**: it additionally emits a `checkedSuppressions` block scoped to the listed
rules (exact, fully-qualified rule-name match), and the Markdown summary / gating
focus on that subset. The full diff is still retained at the top level for other
flows.

The file is a JSON object:

```json
{
  "name": "New TypeSpec ruleset",
  "description": "optional",
  "rules": [
    "@azure-tools/typespec-azure-core/no-enum",
    "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response"
  ]
}
```

Behavior notes:

- **Mode is determined by the presence of the flag, not the number of rules.**
  Passing the flag with an empty `rules` array still enables checked-only mode
  (with nothing gated).
- **Graceful degradation:** if the file is missing, unreadable, not valid JSON,
  or lacks a `rules` string array, a warning is logged and the tool proceeds with
  zero rules (no suppressions require approval). It never hard-fails.
- The curated ruleset is optional and supplied explicitly via
  `--check-rules-file <path>`. There is no hardcoded default location: when the
  flag is omitted the tool runs in legacy mode (all suppressions reported, none
  gated).

### Examples

```bash
# Compare HEAD against origin/main for a single spec
npx typespec-suppressions --base origin/main specification/widget/resource-manager/Microsoft.Widget/Widget

# Compare two specific commits, output to files
npx typespec-suppressions --base abc123 --head def456 \
  --json-output report.json \
  --markdown-output report.md \
  --fail-on-approval \
  specification/foo/Service

# Emit inline PR annotations from a GitHub Actions workflow
npx typespec-suppressions --base origin/main --github-annotations \
  specification/foo/Service
```

## How It Works

### Suppression Identity

Each suppression is uniquely identified by the tuple:

- `specPath` – the TypeSpec project folder
- `sourceKind` – `"inline"` or `"tspconfig"`
- `ruleName` – the suppressed rule (e.g., `@azure-tools/typespec-azure-core/no-enum`)
- `anchorPath` – structural location (e.g., `namespace:Foo/model:Bar/property:baz` for inline, or `tspconfig:linter.disable.<rule>` for config)

If the identity matches between base and head but the justification differs, it's classified as a **changed** suppression.

### Inline Suppression Extraction

The tool parses `.tsp` files using the TypeSpec compiler AST and walks the tree to find `#suppress` directives. It tracks the structural scope (namespace, model, property, operation, etc.) to build the `anchorPath`.

### Config Suppression Extraction

Parses `tspconfig.yaml` using the `yaml` library and reads entries under `linter.disable`, recording each disabled rule and its justification.

### Rule Metadata Enrichment

For each suppressed rule, the tool attempts to dynamically import the linter package and look up the rule definition to attach:

- Rule description
- Documentation URL
- Azure guideline codes (if available)

### Programmatic API

The tool also exports functions for use in other tools:

```typescript
import {
  analyzeTypeSpecSuppressions,
  analyzeTypeSpecSuppressionsFromDirectories,
  loadCheckRulesFile,
  renderMarkdownSummary,
} from "@azure-tools/typespec-suppressions";
```

- `analyzeTypeSpecSuppressions(options)` – git-revision-based analysis
- `analyzeTypeSpecSuppressionsFromDirectories(options)` – filesystem-directory-based analysis (useful for testing)
- `loadCheckRulesFile(path)` – loads and validates a check-rules JSON file, returning the list of rules (empty on any read/parse error)
- `renderMarkdownSummary(params)` – renders a Markdown report from analysis results

## Output Schema

The JSON report follows the `SuppressionReport` interface:

```typescript
interface SuppressionReport {
  repoRoot: string;
  baseRevision: string;
  headRevision: string;
  specPaths: string[];
  checkRules?: string[]; // normalized rules when --check-rules-file is used
  requiresApproval: boolean; // true if new or changed suppressions exist (full diff)
  counts: {
    specs: number;
    base: number;
    head: number;
    new: number;
    removed: number;
    changed: number;
    unchanged: number;
  };
  specs: SpecSuppressionReport[];
  newSuppressions: SuppressionRecord[];
  removedSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
  // Present only in checked-only mode (--check-rules-file provided), scoped to checkRules:
  checkedSuppressions?: {
    checkRules: string[];
    requiresApproval: boolean;
    counts: { new: number; removed: number; changed: number };
    newSuppressions: SuppressionRecord[];
    removedSuppressions: SuppressionRecord[];
    changedSuppressions: SuppressionChange[];
  };
}
```

## PR Integration Workflow

The tool is integrated into the PR lifecycle as an **independent `TypeSpec Suppressions` check category**. Like other repository checks (e.g. Swagger ModelValidation), it is split into an _Analyze Code_ workflow that does the work and a _Set Status_ workflow that publishes the required commit status. Two additional consumers — Summarize Checks and Summarize Impact — surface the results and drive the review labels.

### 1. Analyze Code

**File:** `.github/workflows/typespec-suppressions-code.yaml` — check name **"TypeSpec Suppressions - Analyze Code"**

Triggers on PR events (`opened`, `synchronize`, `reopened`, `edited`):

1. **Checkout** — checks out the PR head SHA with full git history (`fetch-depth: 0`)
2. **Detect impacted folders** — runs `eng/scripts/Get-TypeSpec-Folders.ps1` to diff the base and head commits, producing a list of changed TypeSpec project directories
3. **Run analysis** — executes `typespec-suppressions --base <base-sha> --head HEAD --check-rules-file eng/tools/typespec-suppressions/check-rules.json` on all impacted folders
4. **Upload artifact** — saves the JSON report as a build artifact named `typespec-suppressions-report`
5. **Step summary** — writes the Markdown report to `$GITHUB_STEP_SUMMARY` for visibility in the GitHub Actions UI
6. **Inline annotations** — emits `::warning` annotations for new and changed [checked](#check-rules-scoped-approval) suppressions directly on the PR diff

If no impacted TypeSpec folders are found, the workflow writes an empty report (`requiresApproval: false`) and exits early.

> **Note on `edited` events.** The `edited` trigger is kept so the analysis re-diffs when the PR **base branch** changes. However, `edited` also fires for title/description edits, which re-run the workflow on the same head commit. Because GitHub aggregates `::warning` annotations across every check run on a commit, inline annotations are emitted **only** for non-`edited` events or `edited` events that actually changed the base (`github.event.changes.base`) — otherwise the inline warnings would appear duplicated. The report, PR comment, and status still refresh on every run.

### 2. Set Status

**File:** `.github/workflows/typespec-suppressions-status.yaml` — check name **"TypeSpec Suppressions"**

Uses the shared `_reusable-set-check-status.yaml` to publish a single, stable required commit-status check named **"TypeSpec Suppressions"** that mirrors the Analyze Code result. This follows the Analyze Code / Set Status split used by other repository checks, so branch protection can require the stable `TypeSpec Suppressions` status regardless of the underlying workflow run.

### 3. Summarize Checks (Downstream Consumer)

**Files:** `.github/workflows/src/summarize-checks/summarize-checks.js`, `.github/workflows/src/summarize-checks/labelling.js`

The "Summarize PR Impact" check renders a dedicated TypeSpec suppressions section and drives the review labels:

1. **Finds** the most recent `TypeSpec Suppressions - Analyze Code` workflow run for the PR's head SHA and **downloads** the `typespec-suppressions-report` artifact
2. **Renders** a collapsible section titled **"TypeSpec suppressions requiring review"**, listing each new and changed **checked** suppression (`report.checkedSuppressions`) with rule name, source location, justification, documentation links, and a per-row **Status** column (✅ once approved, ❌ while pending)
3. **Enforces** the review-label rule: when the `TypeSpecSuppressionReviewRequired` label is present, `Approved-TypeSpecSuppression` is required for merge. Reviewers apply `Approved-TypeSpecSuppression` once every justification is acceptable.

Only suppressions whose rule name appears in [`check-rules.json`](#check-rules-scoped-approval) are counted (the `checkedSuppressions` subset). An empty rule list reports nothing for review.

### 4. Test Workflow (CI for the Tool Itself)

**File:** `.github/workflows/typespec-suppressions-test.yaml`

Runs the tool's own unit and e2e tests. Triggers on:

- Pushes to `main`
- PRs that modify files under `eng/tools/typespec-suppressions/**` or related config files

Uses the shared eng/tools test workflow, which type-checks, runs `test:ci`, and format-checks the tool.

### 5. Summarize Impact (Library Consumer)

**File:** `eng/tools/summarize-impact/src/impact.ts`

The `summarize-impact` tool imports the programmatic API (`analyzeTypeSpecSuppressionsFromDirectories`) to compute the `TypeSpecSuppressionReviewRequired` label from the **checked** subset, using directory-based comparison rather than git revisions.

### Labels

| Label                               | Applied by                                                                       | Meaning                                                                                                         |
| ----------------------------------- | -------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `TypeSpecSuppressionReviewRequired` | Automatically (Summarize Impact), when any checked suppression is new or changed | Marks the PR as having suppressions that require reviewer approval                                              |
| `Approved-TypeSpecSuppression`      | Reviewer                                                                         | Approves the checked suppressions; satisfies the merge requirement gated by `TypeSpecSuppressionReviewRequired` |

### Flow Diagram

```
PR opened/updated
  │
  ├─► TypeSpec Suppressions - Analyze Code (typespec-suppressions-code.yaml)
  │     ├─ Get-TypeSpec-Folders.ps1 → finds changed spec directories
  │     ├─ typespec-suppressions CLI → JSON report + Markdown summary + inline annotations
  │     └─ Upload artifact: "typespec-suppressions-report"
  │
  ├─► TypeSpec Suppressions - Set Status (typespec-suppressions-status.yaml)
  │     └─ Publish required commit status "TypeSpec Suppressions" (mirrors Analyze Code)
  │
  ├─► Summarize Checks (summarize-checks.js + labelling.js)
  │     ├─ Download "typespec-suppressions-report" artifact
  │     ├─ Render checked suppressions in the PR comment
  │     └─ Require Approved-TypeSpecSuppression when TypeSpecSuppressionReviewRequired is set
  │
  └─► Summarize Impact (impact.ts)
        └─ Compute TypeSpecSuppressionReviewRequired from checkedSuppressions
```

### Key Behaviors

- **Rollout is report-only.** Suppressions are surfaced (report artifact, PR comment, inline annotations) but do **not** block merges yet: `summarize-impact` computes `TypeSpecSuppressionReviewRequired` from the check-rules, then currently forces it off. Enabling gating is a single-line change in `processTypeSpecSuppression` (`impact.ts`).
- **`requiresApproval`** is computed, not configurable. It is `true` whenever there are new or changed suppressions, `false` otherwise. Removed suppressions alone do not trigger approval. In [checked mode](#check-rules-scoped-approval) only suppressions matching `check-rules.json` count toward it (`checkedSuppressions`).
- **`--fail-on-approval`** is the only CLI-level behavioral control: when set, the CLI exits with code 1 if `requiresApproval` is `true`. The PR Analyze Code workflow does **not** use this flag — gating is driven by the label mechanism above rather than by failing the check.
- **Suppression identity** is based on structural anchors (spec path + source kind + rule name + anchor path), not line numbers, making the diff resilient to code reformatting and reordering.

## Development

```bash
# Type-check
npm run build

# Run tests
npm run test

# Run tests once with coverage (CI mode)
npm run test:ci

# Format check
npm run format:check
```

Requires Node.js >= 24.14.1.
