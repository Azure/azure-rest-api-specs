# Azure Guidelines Search and Materialization

This phase completes `agent-workspace\agent-decisions.json` and converts it into
validated deterministic artifacts. Follow the
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

Do not place declaration IDs on guidance excerpts or reconstruct opaque IDs.
Declaration linkage uses the prefilled qualified `declarationNames` in the
intent-owned compliance judgment that cites the catalog ID and section.
`compliance-search-request.ts` only creates requests in `model-input.json`;
`compliance-assessment.ts` later consumes and validates evidence.

The same compact file contains the Semantic review, REST/downstream coverage,
inference results when requested, exactly one source review per candidate
decision, and one Azure Guidelines decision per compliance search request.
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

After successful materialization, proceed directly to
[guarded finalization](finalization.md).
