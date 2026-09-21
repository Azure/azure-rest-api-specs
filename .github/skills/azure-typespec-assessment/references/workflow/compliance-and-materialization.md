# Azure Guidelines Search and Materialization

This phase completes `agent-workspace\agent-decisions.json` and converts it into
validated deterministic artifacts.

Follow the [agentic search procedure](../agentic-search.md) and use only the
[official document catalog](../reference-document-links.md).

Resolve every `complianceSearchRequest` through the referenced
`dimensions/compliance-search-requests.json` when full evidence is needed.
Read canonical required-document selections from bounded `guidanceRouting`,
resolve their URLs through `mandatoryGuidanceCatalog`, and reuse sufficient
deduplicated content already available in this
session. Fetch missing documents concurrently with `web_fetch`. Complete
explicit targeted-discovery requests without full-catalog scoring or a
four-document quota. Record selections, original retrieval provenance and
bytes, actual retrieval source, failed attempts, extracted guidance, and
per-intent `reviewedCatalogIds`. Missing required content blocks the owning
intent; an unrelated fetched document is not a replacement.

When there are no compliance search requests, skip discovery and document
retrieval. Leave discovery results, retrieval results, search blockers, and
compliance judgments empty.

Do not place declaration IDs on guidance excerpts or reconstruct opaque IDs.
Declaration linkage uses the prefilled qualified `declarationNames` in the
intent-owned compliance judgment that cites the catalog ID and section.
`compliance-search-request.mjs` only creates requests in `model-input.json`;
`compliance-assessment.mjs` later consumes and validates evidence.

The same compact file contains the Semantic review, REST/downstream coverage,
inference results when requested, and one Azure Guidelines decision per
compliance search request. Documentation decisions are deterministic and
excluded from Agent authorship.

Run the indexed deterministic materializer:

```powershell
node (Join-Path $Skill "scripts\materialize-assessment-results.mjs") `
  --work $Work
```

It verifies canonical hashes, selection/review coverage, and exact ID ownership;
derives provenance and accounting; resolves each qualified name to an
unambiguous declaration identity in its canonical request; derives retained guidance applicability from citing
judgments; drops uncited excerpts; and atomically writes `inference.json` when
required, `compliance-search-evidence.json`, and
`assessment-judgment.json`. It preserves original network or session-reuse provenance and
never retrieves network content or authors judgment.

After successful materialization, proceed directly to
[guarded finalization](finalization.md).
