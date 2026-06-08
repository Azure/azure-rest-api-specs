<!-- Source of truth for the Critic-invocation input block. Both the
     Reviewer (Step 7) and the Critic (Operating mode) link here.
     Field semantics live in `arm-api-review-critic.protocol.md`; this file
     is the **literal template** the Reviewer copies into every dispatch
     prompt and every session-handoff paste. -->

# Critic input template

Paste this prelude at the top of the Critic dispatch prompt (or the
session-handoff paste), then the report sections. Fields are read as
prose; missing optional fields fall back to sensible defaults. There is
no rigid YAML schema and no header marker -- the Critic does best-effort
parsing.

## Template

```markdown
PR: <owner>/<repo>#<number>
Head SHA: <full-40-char-sha>
Base: <full-40-char-base-sha-or-ref> (or: new service)
Iteration: 1
Graphs: true (or: false on fast path)

## Step 6 findings report

<verbatim Step 6 report from the Reviewer>

## Step 5.5 reconciliation plan

<verbatim Step 5.5 plan from the Reviewer, or the literal string `reconciliation skipped`>
```

## Field notes

- **PR, Head SHA, Iteration** are required. Head SHA must be the full
  40-character commit SHA so the Critic can pin re-fetches to the same
  tree the Reviewer judged.
- **Base** is required only when a previous API version exists; write
  `new service` otherwise.
- **Graphs** defaults to `true`; set to `false` on fast-path PRs where
  Step 3.5 was skipped by design.
- **Iteration** is `1`, `2`, or `3` (Step 7 hard cap).
- **Step 6 findings report** -- include verbatim; the Critic re-reads it
  end-to-end every iteration. If the Reviewer wants to suppress
  re-surfacing of a `Likely missed violations` candidate that was
  already evaluated and declined, just note it inline in the report
  under a "Considered and declined" heading; no separate input is
  needed.
- **Reconciliation plan** -- include verbatim, or write the literal
  string `reconciliation skipped` if Step 5.5 ran in the skipped mode.
  A plan whose every row is `POST-NEW` is still a plan; pass it
  verbatim.

## When something cannot be assembled

If `PR`, `Head SHA`, or the findings report cannot be assembled, do
**not** dispatch the Critic. Surface the gap to the human per Reviewer
Step 7's fallback ladder.

## Compact mode (iteration >= 2, prompt-size escape valve only)

When iteration `>= 2` **and** the full-report dispatch is hitting a
host-side prompt-size limit (Rung-1 zero-content / "Agent completed with
no output" return), replace the `## Step 6 findings report` section with
the two-part compact-mode body defined in [the protocol's Compact-mode
iteration prompt](./arm-api-review-critic.protocol.md#compact-mode-iteration-prompt-iteration--2-only):

```markdown
## Step 6 findings report (compact mode -- iteration N)

### Changed findings (re-verify from scratch)

<verbatim full body of every finding added, modified, or dropped since iteration N-1>

### Carry-over verdicts (unchanged since iteration N-1)

| #   | Rule          | Path:line    | Prior iteration | Prior Critic verdict |
| --- | ------------- | ------------ | --------------- | -------------------- |
| 3   | RPC-Put-V1-01 | foo.json:L57 | 1               | pass                 |

...
```

Compact mode is **not the default**. Use full report on iteration 1
always, and on iteration >= 2 unless the host is rejecting the full
prompt. The protocol section above defines the Critic's contract for
re-fetching cited files and adopting carry-over verdicts.
