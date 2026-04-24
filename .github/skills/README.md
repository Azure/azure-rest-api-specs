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

### Evaluation suite

The ARM API Reviewer eval suite uses the
[evaluate](https://github.com/microsoft/evaluate) (vally) framework. It
contains **21 stimuli** across **9 eval files** covering ARM resource
structure, property design, operations, breaking changes, suppressions,
examples, true negatives, classification, and report format.

See [`evals/arm-api-reviewer/README.md`](evals/arm-api-reviewer/README.md)
for the full eval suite documentation — directory structure, fixture
catalog, grader types, running instructions, and contribution guide.

### Quick start

```bash
# Prerequisites: clone and build evaluate
git clone https://github.com/microsoft/evaluate.git
cd evaluate && npm install && npm run build && cd -

# Run all eval categories
cd .github/skills/evals/arm-api-reviewer
for f in evaluate/eval-*.yaml; do
  npx --prefix /path/to/evaluate vally eval -e "$f" --verbose
done
```

### Gating changes

Changes to any of these files should pass the eval suite before merging:

- `.github/agents/arm-api-reviewer.agent.md`
- `.github/instructions/*review*.instructions.md`
- `.github/skills/azure-api-review/**`
- `.github/skills/evals/arm-api-reviewer/**`
