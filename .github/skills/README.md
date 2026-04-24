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

## Evaluation Framework

Evaluations use the [evaluate](https://github.com/microsoft/evaluate) (vally)
framework. Each eval suite lives under `evals/<agent-or-skill-name>/` with a
`.vally.yaml` project config, `evaluate/` YAML files, and shared `fixtures/`.

### Prerequisites

Clone [microsoft/evaluate](https://github.com/microsoft/evaluate), then
install and build:

```bash
git clone https://github.com/microsoft/evaluate.git
cd evaluate
npm install && npm run build
```

---

## ARM API Reviewer

The **ARM API Reviewer** agent
([`.github/agents/arm-api-reviewer.agent.md`](../agents/arm-api-reviewer.agent.md))
is a read-only PR review agent that checks Azure REST API specifications
for conformance to Azure REST API Guidelines, ARM RPC rules, and
repository conventions.

The agent depends on the **azure-api-review** shared skill
([`skills/azure-api-review/`](azure-api-review/)) and three
instruction files:

- [`instructions/armapi-review.instructions.md`](../instructions/armapi-review.instructions.md)
  -- ARM-specific rules (100+ rule IDs)
- [`instructions/openapi-review.instructions.md`](../instructions/openapi-review.instructions.md) -- generic OpenAPI rules
- [`instructions/typespec-review.instructions.md`](../instructions/typespec-review.instructions.md) -- TypeSpec rules

**Eval suite**: 21 stimuli across 9 eval files covering ARM resource
structure, property design, operations, breaking changes, suppressions,
examples, true negatives, classification, and report format.

See [`evals/arm-api-reviewer/README.md`](evals/arm-api-reviewer/README.md)
for the full eval suite documentation, fixture catalog, running instructions,
and contribution guide.
