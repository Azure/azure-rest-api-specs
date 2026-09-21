# Agentic Search

## Input

- **Semantic intents** — action, changed constructs, up to three representative
  source excerpts, aggregate operation counts, and up to three representative
  operation IDs from `model-input.json`.
- **Azure Guidelines goal** — compare the changed TypeSpec with applicable official
  guidance without inventing requirements.

## Procedure

1. **Build query profiles** — derive exact terms from every Semantic intent.
   Keep symbols such as decorators, templates, base resource
   types, operation interfaces, paging/LRO constructs, and versioning
   decorators.
   For changes to an existing versioned API, consider **Evolving APIs** first
   for versioning implications, even when no version decorator changed.
   Distinguish ARM list templates from data-plane paging decorators; do not
   transfer template requirements between service planes.
2. **Score catalog once** — combine all query profiles, read
   [reference-document-links.md](reference-document-links.md), and score every
   document once using these additive signals:
   - **Exact symbol (4):** title or description names an exact changed TypeSpec
     construct.
   - **Pattern/category (3):** catalog section matches the changed resource,
     operation, versioning, LRO, paging, model, enum, decorator, or warning.
   - **Service plane (2):** document applies to one or more intents' ARM or
     data-plane service kind.
   - **Change context (1):** document matches the action or stable/preview
     version transition.
     Scores range from 0 through 10. Rank by descending total and break ties by
     catalog order.
     Obtain canonical titles, URLs, and `catalogOrder` values with the exported
     `readComplianceCatalog()` in `scripts/compliance-assessment.mjs`; preserve
     them exactly instead of reconstructing metadata or renumbering entries.
     This helper only reads catalog metadata; scoring and judgment remain Agent
     work.
3. **Fetch once** — call `web_fetch` for the four URLs concurrently and extract
   markdown. If one cannot be fetched, record the failure and replace it with
   the next-ranked URL until four documents are retrieved or the catalog is
   exhausted.
4. **Search** — search each fetched document for terms from all query profiles
   and nearby normative guidance. Retain the smallest relevant sections,
   concise excerpts and directly relevant TypeSpec examples. Record only
   prefilled intent-owned qualified declaration names in compliance judgments
   that cite the section.
5. **Compare each intent once** — synthesize applicable shared guidance and
   compare it with each Semantic intent as one assessment unit. Do not rerank
   or refetch documents for an intent. Do not assess each affected
   operation or build a document-by-declaration matrix. Catalog descriptions
   select documents; they are not Azure Guidelines evidence.
6. **Record compact evidence** — write score signals and rationale keyed by
   each catalog entry's stable `catalogId` in `agent-decisions.json`. Record
   each fetched document's `web_fetch` timestamp, content hash, byte count,
   extracted guidance, and failed attempts once. Guidance excerpts omit
   declaration IDs. Do not repeat canonical catalog metadata, calculated
   totals/ranks, query profiles, source IDs, or hunk IDs.
7. **Judge every intent** — write exactly one `complianceJudgments` entry per
   Semantic intent. Use `applicable-pass`, `applicable-fail`,
   `no-applicable-guidance`, or `not-assessed`. Cite fetched sections only when
   they contribute to the decision. When the search completes but no fetched
   guidance governs the changed behavior, return `no-applicable-guidance` with
   changed-code evidence and a clear rationale. Reserve `not-assessed` for
   an incomplete or blocked Azure Guidelines assessment.
   Every `applicable-fail` also supplies a concise finding title and `high`,
   `medium`, or `low` severity.
   Select `declarationNames` only from the owning judgment's prefilled eligible
   names; never reconstruct opaque declaration IDs.
   Never synthesize a requirement or recommended code example.
8. **Materialize** — run the command advertised in `agent-index.json`. The
   deterministic materializer verifies canonical hashes and exact ownership,
   derives stable ranking and accounting, derives each retained excerpt's
   declaration applicability from the citing judgments, preserves
   Agent-supplied retrieval provenance, and atomically writes
   `compliance-search-evidence.json` and `assessment-judgment.json`. It never
   calls the network or creates evidence.

## Suppressions

For a changed construct with `#suppress` in the supplied source evidence,
retain the diagnostic code and justification as context. A suppression only
silences a diagnostic; it neither proves compliance nor automatically creates
a finding. Compare the construct with fetched guidance, including any
documented exception and its conditions. Cite an unmet requirement for a
failure; do not treat a justification alone as an exemption. If the relevant
source or guidance is unavailable, record that limitation rather than infer
approval. Do not run lint or search unrelated source to judge suppressions.
