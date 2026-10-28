# @azure-tools/typespec-suppressions

A CLI tool that detects and reports changes to TypeSpec lint suppressions between two git revisions. It's designed to enforce approval workflows when new or modified suppressions are introduced in pull requests.

> **Used by CI:** this tool powers the `TypeSpec Suppressions` check on spec PRs. See the
> [CI Fix Guide](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/ci-fix.md#typespec-suppressions)
> for how the check behaves and how to respond to it.

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
