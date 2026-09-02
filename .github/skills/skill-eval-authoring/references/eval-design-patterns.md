# Eval design patterns

## The four-layer pattern

Pick the layer(s) that match what you're actually trying to catch — most
evals only need one or two, not all four.

1. **Routing** — does the right skill get invoked (and the wrong one not)?
   Grader: `skill-invocation` (`required`/`disallowed`). Lives in
   `trigger.eval.yaml`.
2. **Tool-use** — given the skill triggered, does it call the right
   tools, in roughly the right order, and avoid calling ones it shouldn't?
   Grader: `tool-calls` (`required`/`disallowed`/ordered; `name` matched as
   regex).
3. **Output-shape** — is the response structured the way downstream
   consumers expect (specific fields, format, citations)? Graders:
   `output-matches` / `output-not-matches`, `output-contains` /
   `output-not-contains`, `file-exists` / `file-contains` / `file-matches`.
4. **Judgment** — everything else that needs a holistic quality read (tone,
   completeness, correctness of a synthesized recommendation). Grader:
   `prompt` (LLM-judge) — use sparingly; it's slower and noisier than the
   other three.

## Grader quick picks

| You want to check... | Grader |
| --- | --- |
| Skill X (not Y) gets invoked | `skill-invocation` |
| Skill calls tool A but never tool B | `tool-calls` |
| A file got created/updated with expected content | `file-exists` / `file-contains` / `file-matches` |
| Response text matches/avoids a pattern | `output-matches` / `output-not-matches` |
| A command actually ran and produced the right exit/output | `run-command` |
| The run finished without erroring out | `completed` |
| Nothing structural captures it — needs holistic judgment | `prompt` |

## Anti-patterns to avoid

- **Vacuous grading**: a `trigger.eval.yaml` stimulus with only
  `output-contains` and no `skill-invocation` grader doesn't actually prove
  routing happened.
- **Meaningless anti-triggers**: an anti-trigger stimulus needs a genuine
  competing skill mounted in `environment.skills` (or via `.vally.yaml`
  auto-discovery); otherwise "skill X did not trigger" trivially passes
  because nothing else could have triggered either.
- **Tautological judging**: a `prompt` grader whose judge prompt just repeats
  a substring already checked by `output-contains` adds cost without adding
  signal.
- **Missing/inconsistent scoring**: `scoring.weights` not summing to `1.0`,
  or `scoring.threshold` left unset (this repo's convention: `0.8`).
- **Missing `trigger.eval.yaml`**: every new skill needs one — capability
  evals alone don't prove the skill is reachable at all.
- **Tool-name typos in `required`/`disallowed`**: `tool-calls` `name` is
  matched as a regex, so a typo silently matches nothing (false pass) instead
  of erroring.
- **One environment for everything**: reusing a single heavyweight
  environment for stimuli that don't need it slows every run down; scope
  `environment` to what each stimulus actually needs.
