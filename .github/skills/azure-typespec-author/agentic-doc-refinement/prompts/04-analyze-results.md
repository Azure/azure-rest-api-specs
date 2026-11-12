# Prompt 04 — Analyze eval results

You are analyzing Vally **code-quality (forced)** eval results for the
`azure-typespec-author` skill.

## Inputs

One or more `results.jsonl` files (possibly across several timestamped run directories),
downloaded from the ADO benchmark build. Each JSON line is one graded stimulus except the
final `type: run-summary` line (skip it).

Per record fields you use:

- `status` — exclude records with `status: "error"` from pass-rate and documentation-gap
  calculations. Report them separately as infrastructure/executor failures.
- `gradeResult.stimulusName` — the case name (e.g. `002008-ARM-add-parameters`). Use it
  directly; do not match against prompts.
- `gradeResult.passed` — boolean overall pass.
- `gradeResult.details[]` — each grader: `name`, `kind`, `passed`, `score`, `evidence`;
  LLM graders also carry `metadata.rubric_scores[]`.
- `trajectory.output` — the agent's final message.
- `trajectory.stimulus.tags.suite` — the suite (each suite is a separate jsonl file).

## Task

1. Compute a **per-case pass rate** across all runs (passes / total runs), plus a
   per-suite roll-up.
2. Report `status: "error"` records in a separate infrastructure-failures section. Do
   not count them as case failures or use them to infer documentation gaps.
3. For **every failing case**, determine the concrete failure reason from the failing
   grader(s): which grader kind failed, the evidence, and (for LLM graders) which rubric
   line lost points. Classify recurrence only when there are at least two independent
   observations of the case:
   - **Systemic** — the failure recurs across multiple observations.
   - **Flaky** — the case has both passing and failing observations.
   - **Insufficient recurrence data** — only one non-error observation exists. Do not
     call a single failure flaky merely because it occurred once.
4. For each supported failure classification, decide whether the root cause is a **documentation-coverage
   gap** (the skill's references/`SKILL.md` do not tell the agent how to do this) versus a
   skill-logic or eval-scoring issue. Justify with the evidence.

## Output

A structured analysis (markdown) that step 5 will turn into the report:

- Per-case pass-rate table (ascending) + per-suite roll-up.
- Infrastructure/executor failures excluded from pass-rate calculations.
- For each failing case: reason, recurrence classification, and doc-gap? (yes/no + why).
- A short list of candidate documentation gaps, each tied to the cases it explains.
