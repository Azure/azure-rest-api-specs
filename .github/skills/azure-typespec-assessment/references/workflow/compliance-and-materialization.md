# Azure Guidelines Search, Materialization, and Source Association

Stage 2 runs inside a single AI agent context with two sequential steps:
**Step 2a** (compatibility + guidelines judgment and materialization) followed
immediately in the same AI turn by **Step 2b** (post-judgment TypeSpec source
association for confirmed REST and downstream breaking findings).

## Step 2a — Guidelines Search and Judgment Materialization

Complete `agent-workspace\agent-decisions.json` and convert it into validated
frozen judgment artifacts. In full mode with compliance search requests, follow the
[agentic search procedure](../agentic-search.md) and use only the
[official document catalog](../reference-document-links.md).

Resolve every `complianceSearchRequest` through the referenced
`dimensions/compliance-search-requests.json`. Combine query profiles, score the
complete catalog once, fetch the four highest-ranked retrievable documents once
with `web_fetch`, and record compact scores, retrieval provenance and bytes,
failed attempts, and extracted guidance in the decision file. Preserve failed
retrievals and use the next-ranked catalog entry as the search procedure
specifies.

When there are no compliance search requests, skip catalog scoring and document
retrieval. Leave catalog scores, retrieval results, search blockers, and
compliance judgments empty.

Fast mode intentionally produces no compliance search requests. Do not read
the guideline search procedure or catalog in this mode. This is a
completed skipped dimension, not a passing guideline assessment or a blocker.

Do not place declaration IDs on guidance excerpts or reconstruct opaque IDs.
Declaration linkage uses the prefilled qualified `declarationNames` in the
intent-owned compliance judgment that cites the catalog ID and section.
`compliance-search-request.ts` only creates requests in `model-input.json`;
`compliance-assessment.ts` later consumes and validates evidence.

The same compact file contains the Semantic review, REST/downstream coverage,
inference results when requested, and one Azure Guidelines decision per compliance
search request. Pipeline-version-2 decisions use `schemaVersion: 2` and omit
`sourceReviews`; legacy `schemaVersion: 1` retains one source review per candidate.
Documentation decisions are deterministic and excluded from Agent authorship.

Run the indexed `materialization.command`:

```powershell
node (Join-Path $Skill "scripts\materialize-assessment-results.ts") `
  --work $Work
```

It verifies canonical hashes and exact ID ownership; calculates score totals,
ranks, and accounting; resolves each qualified declaration name uniquely in
its canonical request; derives retained guidance applicability from citing
judgments; drops uncited excerpts; atomically writes `inference.json` when
required, `compliance-search-evidence.json`, and frozen `assessment-judgment.json`;
and automatically performs the pipeline-version-2 source-association handoff:

- **Zero confirmed REST/downstream breakings (`sourceAssociationRequired: false`, `itemCount: 0`):**
  Automatically writes `not-applicable` `source-association.json`, transitions
  `workflow-state.json` to `ready-for-finalization`, and prints
  `"status": "ready-for-finalization"`. Proceed directly to
  [finalization](finalization.md).
- **One or more confirmed REST/downstream breakings (`sourceAssociationRequired: true`, `itemCount > 0`):**
  Deduplicates confirmed REST/downstream findings (including approved inferred
  breaking findings) by rule-aware contract owner, writes
  `agent-workspace\source-association-input.json` and
  `agent-workspace\source-association-decisions.draft.json`, transitions
  `workflow-state.json` to `awaiting-source-association`, and prints
  `"status": "awaiting-source-association"`. Continue **immediately in the same
  AI turn** to Step 2b below (do not spawn a separate subagent).

## Step 2b — Post-Judgment Source Association (Same AI Turn)

Read `agent-workspace\source-association-input.json` once (and
`scripts\source-association-decisions.schema.json` from
`agent-index.json.requiredOutputs.resolvedSchemas.sourceAssociationDecisions`
if needed). Do not modify `assessment-judgment.json` or revise frozen verdicts,
severities, or candidate coverage.

For each item in `source-association-input.json`:

1. Compare `proposal`, `declarations`, and `facts` against `deltas`:
   - Distinguish a member's **declaring model** from its referenced value type:
     removed, newly required, retyped, or nullable-restricted properties belong
     to the declaring model; definition-level enum/union changes belong to that
     enum/union.
   - Select the complete minimal canonical declaration set
     (`selectedDeclarationIds`): complete owning model for model/property
     findings, or complete operation/template invocation plus relevant
     decorators and direct helpers for operation/method findings. Exclude
     unrelated declarations from shared files or hunks.
2. Choose the item's `outcome`:
   - `keep`: keep `proposal.declarationIds` unchanged when
     `proposal.status === "associated"` is already complete and minimal
     (`rationale` is optional for `keep`).
   - `refine`: replace or narrow/expand an existing `associated` proposal using
     canonical declaration IDs (`rationale` required).
   - `associate`: select canonical declaration IDs when
     `proposal.status === "unresolved"` (`rationale` required).
   - `unresolved`: record `selectedDeclarationIds: []` with a concise
     `rationale` when canonical changed TypeSpec source cannot be proven.
3. **Targeted / Batch Declaration Lookup (only when needed):**
   Never scan `source/source-index.json` or repository `.tsp` files broadly. If
   `proposal` lacks a required declaration in `allowedSourceChangeIds` (check
   `availableDeclarationNames` when present on unresolved items), query scoped
   declarations via `materialization.querySourceCommand` (batch multiple lookups
   in a single command with repeatable `--query`):

   ```powershell
   node (Join-Path $Skill "scripts\materialize-assessment-results.ts") `
     --work $Work --query-source `
     --query "<item-id>=<qualified-declaration-name>"
   ```

   Single-item `--item <item-id> --name <qualified-declaration-name>` is also
   supported. Only declarations returned as `"status": "matched"` are registered
   for selection on that item.

4. Write `agent-workspace\source-association-decisions.json` with the exact
   `judgmentHash` and `sourceIndexHash` from `source-association-input.json`,
   then run `materialization.sourceAssociationCommand`:

   ```powershell
   node (Join-Path $Skill "scripts\materialize-assessment-results.ts") `
     --work $Work --source-association
   ```

Once `--source-association` transitions the workflow to
`ready-for-finalization`, proceed immediately to [finalization](finalization.md).
Historical single-phase (`schemaVersion: 1`) runs proceed directly from Step 2a
to [finalization](finalization.md).
