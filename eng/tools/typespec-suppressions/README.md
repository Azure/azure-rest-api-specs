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
- The curated list for this repo lives at
  `eng/tools/typespec-suppressions/check-rules.json`.

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
  renderMarkdownSummary,
} from "@azure-tools/typespec-suppressions";
```

- `analyzeTypeSpecSuppressions(options)` – git-revision-based analysis
- `analyzeTypeSpecSuppressionsFromDirectories(options)` – filesystem-directory-based analysis (useful for testing)
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

The tool is integrated into the PR lifecycle through three coordinated components:

### 1. Analysis Workflow

**File:** `.github/workflows/typespec-suppressions-code.yaml`

Triggers on every PR event (`opened`, `synchronize`, `reopened`, `edited`):

1. **Checkout** — checks out the PR head SHA with full git history (`fetch-depth: 0`)
2. **Detect impacted folders** — runs `eng/scripts/Get-TypeSpec-Folders.ps1` to diff the base and head commits, producing a list of changed TypeSpec project directories
3. **Run analysis** — executes `typespec-suppressions --base <base-sha> --head HEAD` on all impacted folders
4. **Upload artifact** — saves the JSON report as a build artifact named `typespec-suppressions-report`
5. **Step summary** — writes the Markdown report to `$GITHUB_STEP_SUMMARY` for visibility in the GitHub Actions UI

If no impacted TypeSpec folders are found, the workflow writes an empty report (`requiresApproval: false`) and exits early.

### 2. Summarize Checks (Downstream Consumer)

**File:** `.github/workflows/src/summarize-checks/summarize-checks.js`

The "Summarize PR Impact" check aggregates results from multiple PR checks, including typespec-suppressions:

1. **Finds** the most recent `TypeSpec Suppressions - Analyze Code` workflow run for the PR's head SHA
2. **Downloads** the `typespec-suppressions-report` artifact from that run
3. **Reads `requiresApproval`** from the JSON report:
   - If `false` → no action, the suppressions section is omitted
   - If `true` → renders a collapsible section titled **"TypeSpec suppressions requiring review"** in the PR comment
4. **Lists** each new and changed suppression with rule name, source location, justification, and documentation links
5. **Instructs** reviewers to apply the **`Approved-Suppression`** label if the justifications are acceptable

### 3. Test Workflow (CI for the Tool Itself)

**File:** `.github/workflows/typespec-suppressions-test.yaml`

Runs the tool's own unit and e2e tests. Triggers on:

- Pushes to `main`
- PRs that modify files under `eng/tools/typespec-suppressions/**` or related config files

Uses the shared eng/tools test workflow, which type-checks, runs `test:ci`, and format-checks the tool.

### 4. Summarize Impact (Library Consumer)

**File:** `eng/tools/summarize-impact/src/impact.ts`

The `summarize-impact` tool imports the programmatic API (`analyzeTypeSpecSuppressionsFromDirectories`) to include suppression analysis in broader impact summaries, using directory-based comparison rather than git revisions.

### Flow Diagram

```
PR opened/updated
  │
  ├─► typespec-suppressions-code.yaml
  │     ├─ Get-TypeSpec-Folders.ps1 → finds changed spec directories
  │     ├─ typespec-suppressions CLI → JSON report + Markdown summary
  │     └─ Upload artifact: "typespec-suppressions-report"
  │
  └─► summarize-checks.js (downstream)
        ├─ Download "typespec-suppressions-report" artifact
        ├─ Check report.requiresApproval
        │   ├─ false → no action
        │   └─ true → render suppression details in PR comment
        └─ Prompt reviewer for "Approved-Suppression" label
```

### Key Behaviors

- **`requiresApproval`** is computed, not configurable. It is `true` whenever there are new or changed suppressions, `false` otherwise. Removed suppressions alone do not trigger approval.
- **`--fail-on-approval`** is the only behavioral control: when set, the CLI exits with code 1 if `requiresApproval` is `true`. The PR analysis workflow does **not** use this flag — it relies on the downstream summarize-checks workflow to surface the information to reviewers instead of blocking the check.
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
