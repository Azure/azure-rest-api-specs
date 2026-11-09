# Source Association After Judgment

Only pipeline-version-2 runs use this separate phase. Judgment materialization
must succeed first; never copy old decisions and label them a fresh judgment.

```powershell
node (Join-Path $Skill "scripts\source-association.ts") --work $Work
```

The builder verifies frozen canonical and judgment hashes, selects approved REST
and downstream findings, deduplicates items sharing a verified contract, and
builds source contexts. Zero items generate a validated not-applicable result
without an AI invocation.

Otherwise, run the following in a **separate source-only AI context**, not a
continuation containing all rejected candidates and guidance decisions:

1. Read `source-association\agent-index.json` once.
2. Read its bounded `source-association-input.json` and indexed decision schema
   once. The input contains accepted deltas, relevant compact facts, complete
   canonical declaration snippets, shared contexts, and frozen hashes.
3. Review every item. Keep a correct complete minimal proposal, refine an
   existing proposal, associate missing source, or record evidence-backed
   unresolved source. Rejected candidates do not receive decisions here.
4. When necessary, use the indexed query command with the item ID and exact
   canonical qualified declaration name. The resolver registers provenance-bound
   results inside the item's source scope; an empty result does not establish a
   mapping. Run queries serially: they update shared registrations and workflow
   hashes. Do not recursively scan artifacts or rewrite canonical input.
5. Write `source-association\agent-decisions.json`, retaining bound hashes.

Select only canonical IDs from the item's context or registered query results.
For model changes, preserve the complete owning model and relevant decorators,
not an isolated property. For operation/template changes, select the complete
operation construct and necessary support, not unrelated models in the same
file. Do not author TypeSpec or revise frozen judgment, severity, or grouping.

```powershell
node (Join-Path $Skill "scripts\source-association.ts") --work $Work --materialize
```

Materialization validates exact item/finding coverage, canonical selections,
outcome semantics, and hashes. It writes `source-association.json` without
changing `assessment-judgment.json`. Missing source may remain explicitly
unresolved while the breaking finding stays intact. Tool failure, changed
hashes, or invalid selections are errors, not fabricated unresolved decisions.

Only then proceed to [guarded finalization](finalization.md). Correct only this
phase's decision artifact if its validation fails; do not rerun judgment or
preparation to repair source selection.
