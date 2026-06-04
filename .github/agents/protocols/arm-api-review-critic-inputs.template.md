<!-- Source of truth for the Critic-invocation input block. Both the
     Reviewer (Step 7) and the Critic (Operating mode) link here.
     Schema definitions live in `arm-api-review-critic.protocol.md`; this file
     is the **literal template** the Reviewer copies into every dispatch
     prompt and every session-handoff paste. -->

# Critic input-block template

The Reviewer MUST embed exactly one fenced YAML block with this schema
in the prompt body it sends to the Critic dispatch (or pastes into the
session-handoff prompt). The Critic MUST refuse to validate any
invocation whose prompt does not contain exactly one such block. Field
semantics, the empty-list rule, and the sentinel-string contract are
defined in [`arm-api-review-critic.protocol.md` → Inputs the Reviewer passes
to the Critic](./arm-api-review-critic.protocol.md#inputs-the-reviewer-passes-to-the-critic).

## Template (copy verbatim; substitute placeholders)

````markdown
```yaml
# critic-inputs/v1
pr_url: https://github.com/<owner>/<repo>/pull/<number>
session_sha: <full-40-char-sha> # Input #2
files_reviewed: # Input #4
  - path/to/file-a.json
  - path/to/file-b.tsp
previous_version: # Input #5; null when new service
  base_sha_or_ref: <sha-or-ref>
  path: specification/<service>/.../stable/<prev-version>
prior_fail_sets: # Input #7; [] on iteration 1
  iteration_n_minus_1: []
  iteration_n_minus_2: []
considered_and_declined: [] # Input #8; [] on iteration 1
graphs_produced: true # Input #9; true | false | downgraded | degraded
iteration: 1 # Input #10; 1..3
```

## Step 6 findings report

<verbatim Step 6 report from the Reviewer>

## Step 5.5 reconciliation plan

<verbatim Step 5.5 plan from the Reviewer, or the literal string `reconciliation skipped`>
````

## Required invariants

- The `# critic-inputs/v1` header comment is part of the contract;
  removing it FAILs Critic input validation.
- Inputs #7 and #8 MUST be explicit empty containers (`[]` or `none`)
  on iteration 1, not omitted.
- Input #6 is either a real plan under the `## Step 5.5 reconciliation
plan` heading or the literal sentinel `reconciliation skipped` --
  never an empty plan or omitted heading.
- `session_sha` is the full 40-char commit SHA; short SHAs are a
  validation failure.
- `iteration` is `1`, `2`, or `3` -- the iteration cap (see
  [protocol → Iteration discipline](./arm-api-review-critic.protocol.md#critic-verdict-tracks)).

## When something cannot be assembled

If a required field cannot be filled in (e.g., session SHA never pinned
because Step 1 failed), do **not** dispatch the Critic. Surface the gap
to the human per Reviewer Step 7's fallback ladder; the Critic will
return `Finding accuracy = FAIL` reason `missing-inputs` against any
incomplete block.
