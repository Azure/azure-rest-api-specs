# ARM API Reviewer — Evaluation Suite

Evaluation tests for the **ARM API Reviewer** agent. Tests are available in two
frameworks — [waza](https://github.com/microsoft/waza) and
[evaluate](https://github.com/microsoft/evaluate) (vally). Both frameworks
share the same `fixtures/` directory; choose whichever fits your toolchain.

## Directory Structure

```
arm-api-reviewer/
├── eval.yaml              # Waza eval config
├── tasks/                 # Waza task definitions (21 files)
│   ├── 010001-missing-crud-ops.yaml
│   └── ...
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
├── fixtures/              # Shared test fixtures (24 files)
│   ├── arm-openapi/       # ARM OpenAPI specs with seeded violations
│   ├── examples/          # Example JSON files (good and bad)
│   ├── readme/            # readme.md suppression files
│   └── version-pairs/     # Version pairs for breaking change detection
└── README.md              # This file
```

## Test Categories (21 test cases)

| ID     | Category                  | Stimuli | Description |
| ------ | ------------------------- | ------- | ----------- |
| 01xxxx | ARM resource structure    | 2       | Missing CRUD ops, missing provisioningState |
| 02xxxx | Property design           | 4       | Secrets, naming, descriptions, enums |
| 03xxxx | Operations                | 4       | PATCH, PUT, DELETE, LRO violations |
| 04xxxx | Breaking changes          | 3       | Removed property, type change, enum narrowing |
| 05xxxx | Suppression analysis      | 2       | Missing reason, security rule suppressions |
| 06xxxx | Example file validation   | 2       | Bad resource ID, realistic secrets |
| 09xxxx | True negatives            | 2       | Clean spec, clean example (false-positive resistance) |
| 10xxxx | Classification            | 1       | NEW vs EXISTING issue tagging |
| 11xxxx | Report format             | 1       | Line numbers, rule IDs, structured output |

## Fixtures (shared)

All 24 fixture files live in `fixtures/` and are referenced by both frameworks:

- **11 ARM OpenAPI specs** in `arm-openapi/` — 1 clean + 10 with seeded violations
- **3 example JSON files** in `examples/` — 1 clean + 2 with issues
- **2 readme.md files** in `readme/` — suppression scenarios
- **8 version-pair files** in `version-pairs/` — 4 pairs for breaking change detection

## Running with Waza

```bash
cd .github/skills
waza run evals/arm-api-reviewer/eval.yaml -v
```

See the [waza documentation](https://github.com/microsoft/waza) for installation
and additional options (`--parallel`, `--task`, `--model`, etc.).

## Running with Evaluate (vally)

```bash
cd .github/skills/evals/arm-api-reviewer

# Run a single category
npx vally run evaluate/eval-arm-resource-structure.yaml

# Run all categories
for f in evaluate/eval-*.yaml; do npx vally run "$f" -v; done
```

See the [evaluate documentation](https://github.com/microsoft/evaluate) for
installation and additional options.

## Grader Types

### Waza

| Grader             | Purpose |
| ------------------ | ------- |
| `skill_invocation` | Verify the `azure-api-review` skill is invoked |
| `prompt`           | LLM-as-judge evaluation of agent output |

### Evaluate (vally)

| Grader             | Purpose |
| ------------------ | ------- |
| `skill-invocation` | Verify the `azure-api-review` skill is invoked |
| `output-matches`   | Regex match on agent output (rule IDs, keywords) |

> **Note:** The evaluate framework's LLM-as-judge grader support is pending
> confirmation. Once available, the waza `prompt` graders can be ported to
> evaluate for deeper semantic validation.

## Adding New Tests

1. **Add a fixture** in `fixtures/` (or reuse an existing one).
2. **Waza:** Create a task YAML in `tasks/` and reference it in `eval.yaml`.
3. **Evaluate:** Add a `stimulus` entry in the appropriate `evaluate/eval-*.yaml`.
4. Follow the naming convention: `{category}{sequence}-{description}`.
