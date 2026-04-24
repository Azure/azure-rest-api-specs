# skills

## Getting Started

1. Create a new skill:
   - Create `skills/my-skill/SKILL.md` with your skill definition

2. Edit your skill:
   - Update `skills/my-skill/SKILL.md` with your skill definition
   - Customize eval stimuli in `evals/my-skill/evaluate/`
   - Add test fixtures to `evals/my-skill/fixtures/`

3. Push to trigger CI:

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

### Installing evaluate (vally)

Clone [microsoft/evaluate](https://github.com/microsoft/evaluate), then
install and build:

```bash
git clone https://github.com/microsoft/evaluate.git
cd evaluate
npm install && npm run build
```

### Running the ARM API Reviewer evals

From the `.github/skills/evals/arm-api-reviewer/` directory:

```bash
# Run a single eval category
npx --prefix /path/to/evaluate vally eval -e evaluate/eval-arm-resource-structure.yaml --verbose

# Run all eval categories
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

### Eval suite structure

```text
evals/arm-api-reviewer/
  .vally.yaml                        # Vally project config (skill discovery, eval paths)
  evaluate/
    eval-arm-resource-structure.yaml  # ARM resource structure & CRUD (01xxxx)
    eval-property-design.yaml         # Property design (02xxxx)
    eval-operations.yaml              # PATCH / PUT / DELETE / LRO (03xxxx)
    eval-breaking-changes.yaml        # Breaking changes (04xxxx)
    eval-suppressions.yaml            # Suppression analysis (05xxxx)
    eval-examples.yaml                # Example file validation (06xxxx)
    eval-true-negatives.yaml          # True negatives (09xxxx)
    eval-classification.yaml          # NEW vs EXISTING tagging (10xxxx)
    eval-report-format.yaml           # Report format validation (11xxxx)
  fixtures/
    arm-openapi/           # ARM OpenAPI JSON specs with seeded violations
    examples/              # Example JSON files (valid and invalid)
    readme/                # Suppression readme.md files
    version-pairs/         # Previous/current version pairs for breaking change tests
```

### Test category naming convention

Tests follow a `{category}{number}-{description}` pattern:

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

### Adding a new test case

1. **Create a fixture** under `fixtures/` with a seeded violation (or
   a clean spec for true negatives). Use an existing fixture as a
   starting point -- `clean-spec.json` for ARM OpenAPI specs, or
   `example-clean.json` for example files. Each fixture should be
   self-contained (inline definitions, standard security block, and
   parameter refs at the bottom).
2. **Add the fixture to `environment.files`** in the appropriate eval
   YAML under `evaluate/`.
3. **Add a stimulus** to the eval YAML with:
   - `name` -- short descriptive identifier
   - `prompt` -- the review prompt referencing the fixture file path
   - `constraints.expect_skills` -- `[azure-api-review]`
   - `graders` -- `output-contains`, `output-matches`, and/or `prompt`
   - `rubric` -- list of criteria for the prompt grader
4. **Run the eval**:
   ```bash
   npx --prefix /path/to/evaluate vally eval -e evaluate/eval-<category>.yaml --verbose
   ```

### Gating changes

Changes to any of these files should pass the eval suite before merging:

- `.github/agents/arm-api-reviewer.agent.md`
- `.github/instructions/*review*.instructions.md`
- `.github/skills/azure-api-review/**`
- `.github/skills/evals/arm-api-reviewer/**`

Run all eval categories locally before pushing and verify no regressions.

### Submitting changes

When proposing changes to the agent, instruction files, or shared
skill, include a test report so reviewers can verify quality:

```bash
# Run all evals and save results
for f in evaluate/eval-*.yaml; do
  npx --prefix /path/to/evaluate vally eval -e "$f" --verbose \
    --output-dir ./results
done
```

Attach the following to your PR description or as a comment:

1. **Console summary** -- copy the results summary from the terminal
   output (success rate, per-stimulus breakdown).
2. **Results files** (`results/`) -- upload as a PR comment attachment
   or paste the summary section.
3. **Failure details** -- for any failed stimuli, include the grader
   output explaining what was missed or incorrectly flagged.

Reviewers should verify:

- Success rate has not regressed from the previous baseline.
- No previously passing stimuli now fail (regressions).
- New stimuli (if added) pass consistently.
