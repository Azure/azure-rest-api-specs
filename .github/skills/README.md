# skills

## Getting Started

1. Create a new skill:

   ```bash
    waza new skill my-skill
   ```

2. Edit your skill:
   - Update `skills/my-skill/SKILL.md` with your skill definition
   - Customize eval tasks in `evals/my-skill/tasks/`
   - Add test fixtures to `evals/my-skill/fixtures/`

3. Run evaluations:

   ```bash
   waza run                    # run all evals
   waza run my-skill           # run one skill's evals
   ```

4. Check compliance:

   ```bash
   waza check                  # check all skills
   waza dev my-skill           # improve with real-time scoring
   ```

5. Push to trigger CI:

   ```bash
   git push
   ```

---

## ARM API Reviewer

The **ARM API Reviewer** agent
([`.github/agents/arm-api-reviewer.agent.md`](../agents/arm-api-reviewer.agent.md))
is a read-only PR review agent that checks Azure REST API specifications
for conformance to Azure REST API Guidelines, ARM RPC rules, and
repository conventions. It reviews OpenAPI JSON, TypeSpec, example
files, and suppression configurations.

The agent depends on the **azure-api-review** shared skill
([`skills/azure-api-review/`](azure-api-review/)) and three
instruction files:

- [`instructions/armapi-review.instructions.md`](../instructions/armapi-review.instructions.md)
  -- ARM-specific rules (100+ rule IDs)
- [`instructions/openapi-review.instructions.md`](../instructions/openapi-review.instructions.md) -- generic OpenAPI rules
- [`instructions/typespec-review.instructions.md`](../instructions/typespec-review.instructions.md) -- TypeSpec rules

### Installing waza

Install the [waza](https://github.com/microsoft/waza) CLI
(requires Go 1.26+ for source builds, or download a pre-built binary):

```bash
# Binary install (Linux/macOS)
curl -fsSL https://raw.githubusercontent.com/microsoft/waza/main/install.sh | bash

# Binary install (Windows) -- download from GitHub releases
# https://github.com/microsoft/waza/releases/latest

# Verify installation
waza --version
```

### Running the ARM API Reviewer evals

From the `.github/skills/` directory:

```bash
# Run all ARM API Reviewer eval tasks
waza run evals/arm-api-reviewer/eval.yaml -v

# Run a single task by name pattern
waza run evals/arm-api-reviewer/eval.yaml --task "020001*" -v

# Run tasks filtered by tag
waza run evals/arm-api-reviewer/eval.yaml --tags "security" -v

# Save results to a JSON file
waza run evals/arm-api-reviewer/eval.yaml -v -o results/arm-reviewer-results.json

# Check skill readiness
waza check skills/azure-api-review
```

### Eval suite structure

```text
evals/arm-api-reviewer/
  eval.yaml                          # Eval config (metrics, graders, task list)
  tasks/
    010001-missing-crud-ops.yaml     # ARM resource structure & CRUD
    010002-missing-provisioning-state.yaml
    020001-secret-property.yaml      # Property design (secrets)
    020002-naming-violations.yaml    # Naming conventions
    020003-missing-descriptions.yaml # Missing descriptions
    020004-enum-violations.yaml      # Enum best practices
    030001-patch-violations.yaml     # PATCH body violations
    030002-put-response-mismatch.yaml# PUT 200/201 schema mismatch
    030003-delete-violations.yaml    # DELETE response violations
    030004-lro-violations.yaml       # LRO pattern violations
    040001-breaking-removed-property.yaml  # Breaking changes
    040002-breaking-type-change.yaml
    040003-breaking-enum-narrowing.yaml
    050001-suppression-no-reason.yaml      # Suppression analysis
    050002-suppression-security-rule.yaml
    060001-example-bad-resource-id.yaml    # Example file validation
    060002-example-realistic-secret.yaml
    090001-clean-arm-spec.yaml       # True negatives (false positive resistance)
    090002-clean-example.yaml
    100001-new-vs-existing-classification.yaml  # NEW vs EXISTING tagging
    110001-report-format-structure.yaml    # Report format validation
  fixtures/
    arm-openapi/           # ARM OpenAPI JSON specs with seeded violations
    examples/              # Example JSON files (valid and invalid)
    readme/                # Suppression readme.md files
    version-pairs/         # Previous/current version pairs for breaking change tests
```

### Task naming convention

Tasks follow a `{category}{number}-{description}.yaml` pattern:

| Prefix   | Category                                                  |
| -------- | --------------------------------------------------------- |
| `01xxxx` | ARM resource structure & CRUD                             |
| `02xxxx` | Property design (secrets, naming, descriptions, enums)    |
| `03xxxx` | PATCH / DELETE / LRO operations                           |
| `04xxxx` | Breaking changes & version comparison                     |
| `05xxxx` | Suppression analysis                                      |
| `06xxxx` | Example file validation                                   |
| `09xxxx` | True negatives (clean specs -- false positive resistance) |
| `10xxxx` | New vs. existing classification                           |
| `11xxxx` | Report format & output structure                          |

### Metrics and thresholds

The eval suite measures four metrics (defined in `eval.yaml`):

| Metric                    | Weight | Threshold | Description                              |
| ------------------------- | ------ | --------- | ---------------------------------------- |
| `issue_detection`         | 0.40   | 0.80      | Detects all known violations in fixtures |
| `false_positive_rate`     | 0.30   | 0.85      | Avoids flagging compliant specs          |
| `classification_accuracy` | 0.15   | 0.80      | Correctly tags [NEW] vs [EXISTING]       |
| `report_format`           | 0.15   | 0.90      | Output follows required report structure |

### Shared prompt templates

Common review prompts are defined once in `eval.yaml` under `inputs`
and referenced by tasks via `{{.Vars.<key>}}`. This avoids duplicating
the same prompt across many task files.

| Variable                 | Used by                        | Prompt summary                                           |
| ------------------------ | ------------------------------ | -------------------------------------------------------- |
| `review_arm_new_service` | 01xxxx, 02xxxx, 03xxxx, 09xxxx | Standard ARM spec review (new service, no prior version) |
| `review_example_get`     | 060001, 090002                 | Example file review for GET operations                   |

Tasks with specialized prompts (e.g., secret focus, breaking-change
comparison, classification) keep their prompts inline.

### Judge model

The LLM used for prompt-based grading is set once via
`config.judge_model` in `eval.yaml`. Individual task graders inherit
this setting automatically -- do **not** add `model:` to task-level
grader configs.

### Adding a new test case

1. **Create a fixture** under `fixtures/` with a seeded violation (or
   a clean spec for true negatives). Use an existing fixture as a
   starting point -- `clean-spec.json` for ARM OpenAPI specs, or
   `example-clean.json` for example files. Each fixture should be
   self-contained (inline definitions, standard security block, and
   parameter refs at the bottom).
2. **Create a task YAML** under `tasks/` following the naming convention. Include:
   - `inputs.prompt` -- use a shared prompt template from `eval.yaml` `inputs`
     when possible (e.g., `"{{.Vars.review_arm_new_service}}"`), or write a
     custom prompt inline for specialized tasks.
   - `inputs.files` -- paths to fixture files (relative to `fixtures/`)
   - `expected.output_contains` -- rule IDs or keywords the agent must mention
   - `graders` -- a `prompt`-type grader for nuanced verification. The judge
     model is set globally via `config.judge_model` in `eval.yaml`; do **not**
     add `model:` to individual task graders.
3. **Add the task** to the `tasks:` list in `eval.yaml`.
4. **Run the task**: `waza run evals/arm-api-reviewer/eval.yaml --task "your-task-id" -v`

### Gating changes

Changes to any of these files should pass the eval suite before merging:

- `.github/agents/arm-api-reviewer.agent.md`
- `.github/instructions/*review*.instructions.md`
- `.github/skills/azure-api-review/**`
- `.github/skills/evals/arm-api-reviewer/**`

Use `waza run evals/arm-api-reviewer/eval.yaml` locally before
pushing. Exit code 0 means all tasks passed; exit code 1 means one or
more tasks failed.

### Submitting changes

When proposing changes to the agent, instruction files, or shared
skill, include a test report so reviewers can verify quality:

```bash
# Generate JSON results and JUnit XML report
waza run evals/arm-api-reviewer/eval.yaml -v \
  -o results/arm-api-reviewer-run.json \
  --reporter junit:results/arm-api-reviewer-run.xml
```

Attach the following to your PR description or as a comment:

1. **Console summary** -- copy the `BENCHMARK RESULTS` block from the
   terminal output (success rate, aggregate score, per-task breakdown).
2. **JSON results** (`results/arm-api-reviewer-run.json`) -- upload as
   a PR comment attachment or paste the summary section. Reviewers can
   use `waza compare` to diff against a baseline run.
3. **Failure details** -- for any failed tasks, include the grader
   output explaining what was missed or incorrectly flagged.

Reviewers should verify:

- Success rate has not regressed from the previous baseline.
- No previously passing tasks now fail (regressions).
- New tasks (if added) pass consistently.
- The aggregate score meets or exceeds the metric thresholds defined
  in `eval.yaml`.

<details>
<summary>Example report (click to expand)</summary>

<!-- This is a representative report from the initial eval suite run.
     Actual numbers may vary slightly between runs due to LLM
     non-determinism. -->

```text
===================================================
 BENCHMARK RESULTS
===================================================

Total Tests:    21
Succeeded:      20
Failed:         1
Errors:         0
Success Rate:   95.2%
Aggregate Score: 0.95
Duration:       22m10s

---------------------------------------------------
 PER-TASK BREAKDOWN
---------------------------------------------------
  ✓ ARM: Detect missing CRUD operations          avg=1.00
  ✓ ARM: Detect missing provisioningState         avg=1.00
  ✓ Property: Detect secret properties            avg=1.00
  ✓ Property: Detect naming convention violations avg=1.00
  ✓ Property: Detect missing descriptions         avg=1.00
  ✓ Property: Detect enum violations              avg=1.00
  ✓ Operations: Detect PATCH body violations      avg=1.00
  ✓ Operations: Detect PUT 200/201 mismatch       avg=1.00
  ✓ Operations: Detect DELETE response violations avg=1.00
  ✓ Operations: Detect LRO pattern violations     avg=1.00
  ✓ Breaking: Detect removed property             avg=1.00
  ✓ Breaking: Detect property type change         avg=1.00
  ✓ Breaking: Detect enum value narrowing         avg=1.00
  ✓ Suppression: Detect suppressions w/o reason   avg=1.00
  ✓ Suppression: Detect security rule suppress.   avg=1.00
  ✓ Example: Detect invalid resource ID           avg=1.00
  ✓ Example: Detect realistic secrets             avg=1.00
  ✓ True Negative: Clean ARM spec                 avg=1.00
  ✓ True Negative: Clean example file             avg=1.00
  ✓ Classification: NEW vs EXISTING               avg=1.00
  ✗ Format: Verify report structure               avg=0.00

Failed Tests:
  - Format: Verify report structure
    error: transient copilot-sdk execution error
```

</details>
