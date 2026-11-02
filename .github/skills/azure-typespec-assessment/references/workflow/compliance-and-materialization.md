# Azure Guidelines Search and Materialization

This phase completes `agent-workspace\agent-decisions.json` and converts it into
validated deterministic artifacts. In full mode with compliance search
requests, follow the
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
inference results when requested and one Azure Guidelines decision per compliance
search request. New pipeline-version-2 decisions use schemaVersion 2 and omit
source reviews; legacy schemaVersion 1 retains one source review per candidate.
Documentation decisions are deterministic and excluded from Agent authorship.

Run the indexed deterministic materializer:

```powershell
node (Join-Path $Skill "scripts\materialize-assessment-results.ts") `
  --work $Work
```

It verifies canonical hashes and exact ID ownership; calculates score totals,
ranks, and accounting; resolves each qualified declaration name uniquely in
its canonical request; derives retained guidance applicability from citing
judgments; resolves reviewed declaration IDs to canonical locations; validates
keep/refine/associate/unresolved/not-applicable semantics; drops uncited
excerpts; and atomically writes `inference.json` when required,
`compliance-search-evidence.json`, and
`assessment-judgment.json`. It preserves supplied `web_fetch` provenance and
never retrieves network content or authors judgment.

After successful materialization, pipeline-version-2 runs proceed to
[source association](source-association.md), then guarded finalization.
Historical single-phase runs proceed directly to [finalization](finalization.md).
