# ARM API Reviewer — Evaluation Suite

Evaluation tests for the **ARM API Reviewer** agent using the
[evaluate](https://github.com/microsoft/evaluate) (vally) framework.

## Directory Structure

```
arm-api-reviewer/
├── .vally.yaml            # Vally project config (skill discovery, eval paths)
├── evaluate/              # Evaluate (vally) eval definitions (9 files)
│   ├── eval-arm-resource-structure.yaml
│   ├── eval-property-design.yaml
│   ├── eval-operations.yaml
│   ├── eval-breaking-changes.yaml
│   ├── eval-suppressions.yaml
│   ├── eval-examples.yaml
│   ├── eval-true-negatives.yaml
│   ├── eval-classification.yaml
│   └── eval-report-format.yaml
├── fixtures/              # Test fixtures (24 files)
│   ├── arm-openapi/       # ARM OpenAPI specs with seeded violations
│   ├── examples/          # Example JSON files (good and bad)
│   ├── readme/            # readme.md suppression files
│   └── version-pairs/     # Version pairs for breaking change detection
└── README.md              # This file
```

## Test Categories (21 test cases across 9 eval files)

| ID     | Category                | Count | Description                                           |
| ------ | ----------------------- | ----- | ----------------------------------------------------- |
| 01xxxx | ARM resource structure  | 2     | Missing CRUD ops, missing provisioningState           |
| 02xxxx | Property design         | 4     | Secrets, naming, descriptions, enums                  |
| 03xxxx | Operations              | 4     | PATCH, PUT, DELETE, LRO violations                    |
| 04xxxx | Breaking changes        | 3     | Removed property, type change, enum narrowing         |
| 05xxxx | Suppression analysis    | 2     | Missing reason, security rule suppressions            |
| 06xxxx | Example file validation | 2     | Bad resource ID, realistic secrets                    |
| 09xxxx | True negatives          | 2     | Clean spec, clean example (false-positive resistance) |
| 10xxxx | Classification          | 1     | NEW vs EXISTING issue tagging                         |
| 11xxxx | Report format           | 1     | Line numbers, rule IDs, structured output             |

## Fixtures

All 24 fixture files live in `fixtures/`:

- **11 ARM OpenAPI specs** in `arm-openapi/` — 1 clean + 10 with seeded violations
- **3 example JSON files** in `examples/` — 1 clean + 2 with issues
- **2 readme.md files** in `readme/` — suppression scenarios
- **8 version-pair files** in `version-pairs/` — 4 pairs for breaking change detection

## Running with Evaluate (vally)

Prerequisites: Clone [microsoft/evaluate](https://github.com/microsoft/evaluate),
then `npm install && npm run build`.

The `.vally.yaml` at `.github/skills/evals/arm-api-reviewer/` configures skill
auto-discovery (via `paths.skills`) and eval file location. Skills are discovered
automatically — individual eval files do not need to declare `environment.skills`.

```bash
# Run a single category
cd .github/skills/evals/arm-api-reviewer
npx --prefix /path/to/evaluate vally eval -e evaluate/eval-arm-resource-structure.yaml --verbose

# Run all categories
for f in evaluate/eval-*.yaml; do
  npx --prefix /path/to/evaluate vally eval -e "$f" --verbose
done

# Save results to a directory (includes results.jsonl + eval-results.md)
npx --prefix /path/to/evaluate vally eval \
  -e evaluate/eval-arm-resource-structure.yaml \
  --output-dir ./results --verbose
```

Replace `/path/to/evaluate` with the path to your local clone of
`microsoft/evaluate`. See the
[evaluate documentation](https://github.com/microsoft/evaluate) for additional
options (`--workers`, `--runs`, `--judge-model`, `--junit`, etc.).

## Grader Types

| Grader               | Purpose                                                           |
| -------------------- | ----------------------------------------------------------------- |
| `output-contains`    | Substring match on agent output (keywords, rule IDs)              |
| `output-matches`     | Regex match on agent output                                       |
| `output-not-matches` | Negative regex match (e.g., no em dashes)                         |
| `prompt`             | LLM-as-judge evaluation of agent output against `rubric` criteria |

Vally eval files also use `constraints.expect_skills` to verify the
`azure-api-review` skill is activated during each stimulus.

## Including Test Reports in PRs

When submitting a PR that modifies the ARM API Reviewer agent, its instruction
files, or the `azure-api-review` skill, run the eval suite and include the
results in your PR description or as a comment:

1. Run the eval suite (see commands above).
2. Attach the `results.jsonl` and/or `eval-results.md` from the
   `--output-dir` directory to your PR.
3. Summarize pass/fail counts in the PR description so reviewers can quickly
   assess the impact of your changes.

## Adding New Tests

1. **Add a fixture** in `fixtures/` (or reuse an existing one).
2. Add a `stimulus` entry in the appropriate `evaluate/eval-*.yaml`
   file. Include `rubric` criteria for the `prompt` grader.
3. Follow the naming convention: `{category}{sequence}-{description}`.
4. Run the eval to verify the new test works before submitting.
