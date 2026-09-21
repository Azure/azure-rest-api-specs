# Agentic Search

## Input

Use each assessed intent's read-only `referenceCategories`, query summary,
source evidence, and `guidanceRouting` in `model-input.json`. Categories annotate
existing groups; never regroup intents or change their `intentType`.
Informational API-version intents remain excluded.

## Procedure

1. **Read required selections.** Resolve canonical document IDs, URLs, and
   titles from `model-input.json.mandatoryGuidanceCatalog` or the exported
   `readComplianceCatalog()` in `scripts/compliance-assessment.mjs`. Use the
   [official catalog](reference-document-links.md) for discovery gaps, not
   global ranking. There are no catalog scores, top-four cutoff, or filler
   documents.
2. **Obtain selected content once.** Deduplicate canonical URLs across intents.
   Reuse relevant document content and original retrieval provenance already
   available in the same session. Otherwise call `web_fetch` for independent
   missing documents concurrently. Preserve `retrievalSource` as `network` or
   `session-reuse`, the original retrieval timestamp, content hash, byte count,
   and actual failure details. Hash the retrieved content, not fabricated
   evidence. No persistent cache, TTL, or cache loader is required.
3. **Resolve targeted discovery.** Complete every supplied discovery request
   with `selected`, `no-match`, or `blocked` and a rationale. Search catalog
   descriptions for that exact uncovered concern; do not score every entry or
   fetch entire categories. Cross-category selection is allowed. Additional
   required references found in content must retain their source document,
   section, and owning intent in `additionalSelections`; supplied requests use
   `discoveryResults`. A `classification-blocked` request must remain blocked;
   Agent discovery cannot clear unavailable/conflicting deterministic evidence.
   Never invent IDs or URLs. A necessary reference absent from the catalog is
   an explicit coverage blocker, not a successful no-match.
4. **Extract normative guidance.** Search retrieved content for changed
   constructs and nearby requirements. Retain concise verbatim excerpts and
   directly relevant TypeSpec examples. Catalog descriptions are selection
   metadata, not guidance evidence. Excerpts do not carry declaration IDs;
   only citing judgments select prefilled, intent-owned qualified
   `declarationNames`.
5. **Review each intent once.** Review all required and positively discovered
   documents for that intent and record `reviewedCatalogIds`. Shared content
   is retrieved once but reviewed for each owning intent. Do not reuse an
   earlier compliance judgment. Record `applicable-pass`, `applicable-fail`,
   `no-applicable-guidance`, or `not-assessed`. Applicable decisions require
   governing excerpts; failures require a demonstrated contradiction and a
   title/severity. Complete no-match searches count as assessed, not as proof
   that all guidelines passed. Missing required content or blocked discovery
   requires `not-assessed` for the affected intent.
6. **Materialize.** Write only `agent-workspace/agent-decisions.json` using the
   indexed schema, then run the indexed materializer. It validates immutable
   routing, selection/review coverage, provenance, and declaration ownership.
   It does not retrieve content or author judgments.

## Reuse and limits

A remembered title, hash, summary, or prior conclusion is not reusable
document content. Fetch missing sections if the earlier response was truncated,
insufficient for this intent, or lost after context compaction. Honor explicit
refresh requests. Do not claim a new network retrieval when reusing content.
Repeated or cyclic references must not cause repeated fetches.

Observe the supplied retrieval and input budgets. Required selections cannot
be silently dropped or replaced by unrelated documents to satisfy a limit.
Zero new network requests is valid when all selected content is reusable;
an empty document set requires completed no-match discovery or no assessed
intents.

## Scope of guidance

For existing-version API evolution, **Evolving APIs** is primary even when no
version decorator changed. A `versioned-api-evolution-guidance` selection makes
that document governing: cite it in every completed judgment. Existing-version
evolution without a changed versioning decorator is `applicable-fail`; unchanged
wire shape does not make changed generated-client behavior compliant. Category
order is not relevance ranking. For ARM
lists, assess standard operation templates rather than requiring authors to
repeat the low-level data-plane paging decorators supplied by templates.

A changed `#suppress` only silences a diagnostic. Retain its exact diagnostic
and justification, then compare the construct against actual guidance and any
documented exception. Neither suppression nor a legacy helper proves
compliance. Do not run lint or search unrelated source to judge suppressions.
An added model, interface, or operation that directly or transitively uses an
`Azure.ResourceManager.Legacy` construct is `applicable-fail` and cites current
standard ARM modeling or operation guidance. A valid fixed route does not make
new legacy template usage compliant.
