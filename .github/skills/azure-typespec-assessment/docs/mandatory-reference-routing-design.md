# Reference-Category Tags and Mandatory Guidance

Status: implemented; sequential corpus benchmark pending

## Decision

Keep semantic intent grouping unchanged. After grouping is complete, attach
deterministic reference-document category tags to each intent.

Replace global document scoring and ranking with direct, intent-scoped document
selection. Fetch the shared union of required documents, with targeted
discovery only for specific guidance gaps. Do not maintain a global top-four
list or fetch extra documents to satisfy a minimum count.

This supersedes the earlier proposal to classify atomic hunks before grouping,
replace `normal` with category-specific intent types, or split and merge
intents according to document categories. It also supersedes keeping global
ranking for supplemental retrieval.

Three different concepts remain separate:

| Concept | Purpose | Change |
| --- | --- | --- |
| Existing grouping tags | Help existing heuristics decide which hunks form an intent | None |
| Existing `intentType` | Distinguish ordinary assessment from informational version intents | None |
| New `referenceCategories` | Identify relevant reference-document categories for a completed intent | Additive metadata |

Keep the existing three `intentType` values:

- `normal`
- `api-version-publication`
- `api-version-wide-change`

The existing code name is `api-version-wide-change`, not
`api-version-side-change`.

## Problem

The previous Azure Guidelines retrieval ranked the reference catalog globally
and fetched the first four retrievable documents. Governing guidance for one
intent could be displaced by higher-ranked documents relevant to other intents.

The reassessment of Azure/azure-rest-api-specs#44988 illustrates the problem:
the ConnectionAnalyzer intent contained ARM operations and
`Legacy.RoutedOperations` evidence, but ARM resource operations and the ARM
interface reference ranked below the retrieval cutoff. The intent received
`no-applicable-guidance` without those documents being reviewed.

The solution is to annotate the already-grouped intent and route its guidance,
not to change its boundaries.

## Architecture

```text
changed TypeSpec
  -> existing hunk/declaration units
  -> existing grouping and operation selection
  -> existing publication consolidation and hunk deduplication
  -> existing intentType assignment and stable IDs
  -> NEW: deterministic reference-category annotation
  -> category-based guidance routing
  -> deduplicated required-document retrieval
  -> targeted discovery and retrieval for uncovered guidance needs
  -> Agent compliance judgment
```

Annotation runs after the existing semantic analysis has finalized its units.
It must not feed data back into grouping, operation selection, or ID generation.
Downstream consumers use the same units with additional metadata.

The following remain identical for the same inputs:

- intent counts, order, IDs, actions, and `intentType`;
- source, hunk, and declaration membership;
- operation mappings, selected operations, and `ownedOperationIds`;
- grouping tags, grouping reasons, and `groupingEvidence`;
- small-new-version, feature, SDK-compatibility, and publication grouping;
- informational filtering and REST/downstream candidate ownership.

In particular, do not reinterpret or repair existing grouping heuristics in
this change. Existing grouping tags such as `transform:client-name` and
`behavior:lro` remain intact.

## Reference categories

Use the eight category headings from
[the reference catalog](../references/reference-document-links.md), in the
user-selected order:

| Category tag | Catalog heading |
| --- | --- |
| `arm-resource-type` | ARM Resource Type |
| `arm-resource-operation` | ARM Resource Operation |
| `api-versioning` | API Versioning |
| `long-running-operation` | Long-Running Operations (LRO) |
| `paging` | Paging |
| `models-and-enums` | Models and Enums |
| `decorators` | Decorators |
| `warnings` | Warnings |

`referenceCategories` is a deduplicated array in the above order. An intent can
have multiple tags because the existing group can contain several kinds of
changes. There is no primary category, precedence between categories, or
category-based regrouping.

Use `[]` when no category can be established. This is not a new `intentType`,
not a compliance pass, and not a reason to discard the intent. It remains
eligible for targeted discovery using its changed constructs and source
evidence.

The separate five-dimensional `intentClassification` object, expanded intent
enum, `relatedGuidanceCategories`, and new merge-edge structures from earlier
drafts are no longer proposed.

## Reference catalog updates

Keep `references/reference-document-links.md` aligned with the eight headings:

- retain the existing official document URLs;
- remove the standalone Resource Semantics heading;
- place TypeSpec.Rest decorators under ARM Resource Type;
- place Azure.ResourceManager decorators under ARM Resource Operation;
- combine ARM Paging and Data-Plane Paging under Paging, preserving the
  ARM-template caveat and both plane-specific documents;
- place API Versioning third, after the two ARM categories.

Section membership organizes documents; it does not limit the scope of a
document's actual guidance. For example, TypeSpec.Rest decorators may also
govern operation roles or data-plane resource semantics. Routing may reuse an
existing catalog entry across categories without duplicating its URL or
classifying data-plane changes as ARM.

The classifier uses explicit stable tag-to-heading mappings, not generated
slugs or fuzzy title matching. Validate that mapped categories exist exactly
once. Resolve mandatory documents through the canonical catalog, not invented
or copied opaque catalog IDs. Verify the catalog parser's ID and ordering
behavior when moving entries between sections; regenerate dependent artifacts
consistently rather than mixing catalog revisions.

## Deterministic annotation

### Inputs

Use complete canonical evidence for each finalized intent:

- changed declarations and their associated hunks, on both revisions;
- exact resolved symbols, decorators, templates, and compiler relationships;
- service plane from project/source evidence;
- existing operation identities and relevant LRO/paging contract metadata;
- API-version comparison context and existing informational intent type;
- changed diagnostic suppressions and their exact diagnostic identifiers.

Do not classify from Agent-authored titles, summaries, catalog scores, or
previous reports. Do not use truncated `model-input.json` summaries as the
classification source.

Existing grouping tags are not sufficient classification proof: for example,
the current LRO grouping heuristic also matches `Location` and `@extension`.
Likewise, `ownedOperationIds` currently includes transitive matches; it must not
be treated as proof that an operation declaration itself changed.

### Category rules

| Tag | Evidence to establish relevance |
| --- | --- |
| `arm-resource-type` | ARM resource definitions, identity, parent/scope relationships, or resource templates associated with the changed declarations |
| `arm-resource-operation` | Changed ARM operations or operation containers, including lifecycle roles, actions, standard templates, or legacy/custom routed implementations |
| `api-versioning` | Versioning decorators or declarations, or a changed API element whose evolution is established by version context |
| `long-running-operation` | LRO templates/decorators or changed polling, status-monitor, or final-state contracts |
| `paging` | Paging templates/decorators or changed paged-response/traversal contracts; retain the service plane for document selection |
| `models-and-enums` | Model/property, enum/union, scalar, or ARM common-type changes that require modeling guidance |
| `decorators` | Generic or specialized decorator changes not fully described by a more specific category, such as naming, constraints, or OpenAPI metadata |
| `warnings` | Added, removed, or modified suppressions and diagnostic-specific evidence |

Rules are multi-label and evidence-based. A model used by an ARM operation does
not receive `arm-resource-operation` solely because it affects that operation.
An unchanged LRO consuming a modified model does not automatically make the
model change an LRO change.

Do not require standard ARM templates to be present to assign the ARM operation
tag. Custom or legacy implementations need the same governing template
guidance; otherwise the original false negative would remain.

Do not add every generic category merely because specialized constructs use
models and decorators internally. Retain additional tags when the changed
evidence independently warrants their guidance.

Consider removed constructs using baseline evidence, not only head symbols.
When required source/compiler evidence is unavailable or conflicts, record an
explicit diagnostic. Do not silently assign an ARM plane or pretend that a
blocked classification is a completed no-match.

### Informational intents

Tag both informational API-version types with `api-versioning` for report
navigation. Their existing assessment eligibility remains unchanged:

- they are excluded from assessed model-input units and compliance requests;
- their tags do not add mandatory documents to the retrieval union;
- they do not create Guidelines findings or breaking-change relationships.

The category is descriptive metadata, not permission to assess these intents.

## Semantic output contract

The current canonical artifact is
`dimensions/semantic-intents-input.json`. Add two fields to each `reviewUnits`
entry: the category tags and their deterministic evidence.

Illustrative diff; identifiers below are placeholders:

```diff
 {
   "id": "semantic-example",
   "intentType": "normal",
   "action": "add",
   "hunkIds": ["hunk-example"],
   "declarationIds": ["declaration-example"],
   "operations": [...],
   "groupingEvidence": {...},
+  "referenceCategories": ["arm-resource-operation"],
+  "referenceCategoryEvidence": [
+    {
+      "category": "arm-resource-operation",
+      "ruleId": "arm-legacy-routed-operations",
+      "hunkIds": ["hunk-example"],
+      "declarationIds": ["declaration-example"],
+      "evidence": [
+        "symbol:Azure.ResourceManager.Legacy.RoutedOperations"
+      ]
+    }
+  ]
 }
```

Every category has at least one supporting rule record. Evidence refers only
to existing canonical declarations, hunks, and facts; no Agent-authored
ownership is accepted. Informational version tags can cite the existing
`intentType` and corresponding version evidence.

Sort and deduplicate evidence deterministically. Do not include either new
field in semantic ID calculation, including later publication consolidation.

## Model input and downstream propagation

The bounded model input carries the tags, not a copy of every evidence record:

```diff
 {
   "semanticReviewUnits": [
     {
       "reviewUnitId": "semantic-example",
       "intentType": "normal",
+      "referenceCategories": ["arm-resource-operation"],
       "evidenceSetId": "evidence-set-example"
     }
   ],
   "complianceSearchRequests": [
     {
       "requestId": "compliance-search-example",
       "reviewUnitId": "semantic-example",
       "querySummary": {...},
+      "guidanceRouting": {
+        "mandatoryCatalogIds": ["catalog-entry-example"]
+      }
     }
   ]
 }
```

Full classification evidence is available through existing `evidenceSetId` and
`artifactReferences` mechanisms. The Agent reads canonical tags; it does not
write or override them in its decisions.

| Artifact | Proposed change |
| --- | --- |
| `dimensions/semantic-intents-input.json` | `referenceCategories` and `referenceCategoryEvidence` |
| `dimensions/compliance-search-requests.json` | Canonical category tags, required-document routing, and explicit discovery requests for uncovered needs |
| `model-input.json` | Compact tags on semantic units; required IDs and discovery requests on compliance requests |
| `agent-workspace/agent-decisions.json` | Remove `catalogScores`; add targeted-discovery results and per-intent `reviewedCatalogIds`; distinguish network retrieval from same-session reuse |
| `compliance-search-evidence.json` | Replace `catalogRanking` and `rankedDocuments` with intent-scoped `documentSelections` and shared `documents`; persist discovery outcomes and original retrieval provenance |
| `assessment-judgment.json` | Materialized per-intent review accounting |
| `assessment.json` | Category tags on semantic items; required/reviewed document coverage in compliance |

Tagging alone does not change the Agent decision schema or retrieval policy.
Those changes belong to the subsequent routing phase. Removing required
ranking fields is a breaking contract change: bump the affected schema
versions and update their producers, validators, readers, and fixtures
together. Absence of tags in an old artifact is not proof of no matching
category; rerun annotation and document selection before using the new routing
workflow. Do not reinterpret old ranked evidence as satisfying the new
per-intent selection contract.

Do not alter REST/downstream candidate shapes, inference contracts,
documentation-completeness rules, or raw AutoRest/TCGC outputs.

## Mandatory document routing

For assessed intents, use the tags and retained deterministic evidence to
select governing documents. Not every document in a tagged section is
automatically mandatory.

| Category | Initial routing policy |
| --- | --- |
| ARM Resource Type | ARM resource types and modeling; specialized resource or decorator guidance when the corresponding construct changes |
| ARM Resource Operation | ARM resource operations and Azure.ResourceManager interface reference; relevant lifecycle-decorator guidance when applicable |
| API Versioning | Evolving APIs as the primary mandatory guidance for changes to existing versioned APIs |
| Long-Running Operations (LRO) | ARM or Azure.Core LRO guidance according to service plane |
| Paging | ARM operation-template/paging guidance or data-plane pagination guidance according to service plane |
| Models and Enums | Models, Enums, Scalars, or ARM common types according to changed declarations and governing scope |
| Decorators | Exact applicable decorator-family document; use targeted discovery for cases without a deterministic document mapping |
| Warnings | Directives and applicable diagnostic-specific guidance |

For unions, do not assume the Enums document governs every union construct.
Use targeted discovery or report explicit catalog-coverage limits where the
catalog has no governing document.

Evolving APIs is primary for existing-version evolution; it is not globally
more important than all other categories. The eight-category display order
does not define document relevance or retrieval priority.

### Direct retrieval

1. For each assessed intent, resolve required documents from its categories,
   service plane, and specific construct evidence.
2. Record every owning intent and matched routing rule for each selection.
3. Deduplicate the union by canonical catalog identity/URL. Reuse selected
   content already available in the same Agent session; fetch only content
   that is missing. Share it across owning intents.
4. Search the retrieved content for applicable guidance and necessary
   additional references.
5. Resolve specific uncovered needs through targeted discovery, applying the
   same session-reuse check to newly selected documents.
6. Judge each intent against its required and discovered guidance once
   retrieval and discovery are complete.

There is no relevance score, global priority competition, or minimum document
count. If selection requires two documents, obtain two; if it requires six,
obtain six. Network fetches may be fewer, including zero, when the selected
content is already available in the session. An empty selected-document set is
allowed only when there are no assessed intents or all applicable discovery
requests complete with no selectable guidance. A retrieval failure does not
count as a successful no-match.

Use canonical catalog order only for reproducible serialization or scheduling,
not to exclude lower-positioned required documents. A failed required
retrieval makes owning intents `not-assessed`; another unrelated successful
document cannot replace that obligation.

### Same-session reuse: initial scope

For the initial implementation, rely on Agent instructions to avoid retrieving
the same available content repeatedly within one session. This applies across
intents and across assessments performed in that same session.

Do not introduce a persistent document cache, cache-aware loader, cache
directory, TTL policy, conditional HTTP requests, or cross-process locking.
Continue using the host's existing retrieval tool when content is needed.
The materializer remains offline and does not manage a cache.

The `references/agentic-search.md` instructions require:

1. Before retrieving a selected URL, check whether its relevant content and
   original retrieval provenance remain available in the current session.
2. Reuse that content when available. Do not fetch it again just because a
   different intent or assessment selected the same document.
3. Review the content against the current intent and retain applicable
   excerpts; never reuse an earlier compliance judgment as a new judgment.
4. Fetch missing content when the earlier response was truncated, did not
   include the required section, or is no longer accessible after context
   compaction. A remembered title, summary, or hash alone is insufficient.
5. Honor an explicit request for refreshed guidance. If required content
   cannot be obtained, record a blocker rather than inventing excerpts.

This is best-effort session reuse, not a durable caching guarantee. There is
no automatic freshness revalidation within the session and no promised reuse
in a new session. Additional persistent caching is deferred until observed
duplicate retrieval cost justifies it.

Use `retrievalSource: "network"` or `"session-reuse"` in the new retrieval
contract. For reused content, preserve the original URL, `retrievedAt`,
`contentHash`, and available provenance rather than assigning a new fetch
timestamp. Each assessment still records its selected documents and excerpts
so the final report does not depend on access to a past conversation.

### Targeted discovery

Discovery is a bounded exception path, not a new name for full-catalog ranking:

| Trigger | Scope |
| --- | --- |
| No category can be established from otherwise complete evidence | Search catalog descriptions for the intent's exact changed constructs and context |
| A category is known but no rule covers a changed construct | Search for that uncovered construct, rather than fetching the entire category |
| Retrieved guidance identifies a necessary additional reference | Resolve the reference and record the source document and section |
| Retrieved documents do not address a changed concern | Search specifically for that concern and explain the remaining gap |

The Agent may search across categories; category tags are not an exclusion
filter. It must not rescore the whole catalog or add filler documents. Group
equivalent requests to avoid repeated discovery, while retaining per-intent
outcomes.

Canonical compliance requests expose known gaps with a stable request ID,
owning intent, trigger, and evidence reference. Each gets a recorded outcome:
`selected`, `no-match`, or `blocked`, with selected catalog IDs where
applicable and a rationale. Additional needs discovered in fetched text cite
that text's document and section and remain associated with the owning intent.
The Agent cannot rewrite categories or remove deterministic requirements.

Use canonical catalog entries for selected documents. If a necessary reference
is not in the catalog, report the catalog-coverage gap rather than inventing a
catalog ID or silently treating assessment as complete. Extending the catalog
is a separate change, not automatic unbounded web crawling.

A completed search with no evidence that guidance is missing may yield
`no-match`. Unresolved necessary references, unavailable evidence, and budget
or retrieval failures yield `blocked`. Merely having no mapped document does
not establish that no guidance applies.

### Retrieval budget

The previous proposed three-document-per-intent cap is unsuitable when one
unchanged intent has several category tags. Measure selected unions, discovery
attempts, and content sizes on the 12-report corpus before finalizing limits;
sixteen total documents is only a candidate limit, not an established
sufficient bound.

Bound unique documents, discovery attempts, and retained content explicitly.
Do not drop required documents or unanswered discovery requests to meet the
budget. Record owning-intent blockers; the materializer rejects a completed
decision when its coverage is incomplete. Cyclic or repeated references must
not cause repeated retrieval or open-ended discovery.

## Selection provenance instead of ranking

Remove the following from the proposed workflow and contracts:

- `4 + 3 + 2 + 1` catalog scoring and full-catalog scoring rationales;
- `catalogScores`, `catalogRanking`, numeric document `rank`, and `score`;
- the `rankedDocuments` name and four-document maximum;
- `catalogEntriesScored` accounting;
- first-four, contiguous-ranked-prefix, and fourth-success stopping checks;
- fallback to the next globally ranked document;
- instructions to fetch enough documents to reach four.

Keep canonical catalog metadata, query terms, source ownership, content hashes,
original retrieval timestamps, failed attempts, and normative excerpts. Record
same-session reuse explicitly; do not label it as a new network retrieval.

In `compliance-search-evidence.json`, `documentSelections` records why a
document belongs to an intent. `documents` stores successful retrievals once,
without rank or score. Required selections are materialized from canonical
routing; discovery selections are materialized from validated Agent discovery
results, not fabricated deterministic rule matches.

Illustrative required-selection record; IDs are placeholders:

```json
{
  "reviewUnitId": "semantic-example",
  "catalogId": "catalog-entry-example",
  "basis": "category-rule",
  "category": "arm-resource-operation",
  "ruleId": "arm-operation-template-guidance",
  "evidenceSetId": "evidence-set-example"
}
```

Discovery selections instead identify their discovery request, trigger,
rationale, and source evidence or linked-reference provenance. A shared
document can have several selection records, but only one retrieved content
record. A deterministic requirement remains required even if discovery also
selects the same document.

Replace scored-entry counts with selection, unique-document, and discovery
outcome counts. Distinguish network fetches from session-reused documents:
reused content still contributes to document processing and excerpt size, but
not to bytes newly fetched in this assessment.
The Agent output, materialized evidence, final assessment, and report UI must
all describe selection provenance rather than presenting obsolete rankings.

## Review accounting and report behavior

The Agent records `reviewedCatalogIds` for each assessed intent. Materialization
must verify that:

- reviewed IDs belong to documents with valid network or same-session reuse
  provenance and retained guidance evidence;
- every required or positively selected discovery document was reviewed before
  accepting a completed decision;
- every canonical discovery request has an outcome, and linked-reference
  discoveries have traceable provenance;
- incomplete required retrieval or unresolved necessary discovery requires
  `not-assessed` and an owning-intent blocker;
- citations refer to reviewed documents and retained normative excerpts;
- classification and routing agree with immutable canonical artifacts;
- fetched documents have selection provenance; no document is fetched merely
  to fill a quota.

Do not prefill review completion just because a document was required.
`reviewedCatalogIds` is accounting, not proof of a violation.

`no-applicable-guidance` is valid only after required review and any targeted
discovery complete without blockers, and no governing guidance was found. It
must not be presented as proof that all Azure Guidelines passed. Category tags
themselves create neither passes nor findings.

The report shows the same semantic intents with category badges or filters,
not separate copied intents per category.

## Implementation

1. Keep the catalog's eight-category reorganization and validate its mappings.
2. Add a deterministic post-grouping annotation helper,
   `reference-category-tags.mjs`.
3. Invoke it after final semantic analysis, before canonical serialization and
   compact input construction. Leave all grouping and intent-type predicates
   untouched.
4. Propagate tags into model input and final semantic output; retain full
   evidence in the canonical artifact.
5. Replace global ranking with category-based routing and targeted discovery
   as a separate phase, including retrieval/review accounting.
6. Migrate affected schemas and validators together; update
   `build-agent-workspace.mjs`, `materialize-assessment-results.mjs`,
   `compliance-assessment.mjs`, assembly, and final validation to consume
   selection provenance rather than ranking.
7. Update `SKILL.md`, `references/agentic-search.md`, output/workflow
   instructions, and directly related design documentation to remove global
   scoring, ranked fallback, and four-document retrieval requirements. Require
   same-session content reuse before retrieval, without adding a cache helper.
8. Update report presentation and fixtures; run corpus comparisons.

Production scripts implement this flow. Annotation runs in the coordinator
after the unchanged semantic analyzer. Compact decisions, search evidence, and
judgment use schema versions 2, 3, and 2 respectively. The implementation does
not include the earlier atomic classifier, category-aware merge algorithm,
expanded intent enum, primary-subject precedence, grouping-edge diagnostics,
or persistent cache code.

`preparation-manifest.json.timings` records `referenceCategoryAnnotationMs`
separately from semantic analysis. `guidanceRoutingMs` includes canonical
request/query-profile construction and catalog validation, not only the new
routing work.

## Validation and acceptance criteria

### Grouping invariance

- For identical canonical inputs, strip only the new annotation fields and
  deep-compare semantic analysis output with the existing implementation.
- Require identical IDs, types, count/order, membership, grouping evidence,
  selected operations, actions, facts, and blockers from semantic analysis.
- Cover same-tag cross-file merging, same-file supporting hunks, connected
  components, small new-version merging, feature and SDK-compatibility groups,
  publication consolidation, and version-wide informational detection.
- Compare REST/downstream candidate identity and ownership, inference coverage,
  and documentation-completeness output before and after annotation.

### Annotation and routing

- Every intent has a deterministic category array containing only the eight
  allowed values; every assigned tag has traceable evidence.
- Several tags can coexist without splitting the intent or changing its ID.
- Data-plane changes do not acquire ARM tags solely from generic resource
  decorators or transitive operation references.
- Model-only edits do not acquire LRO or operation tags from unrelated
  unchanged consumers.
- Baseline evidence supports removals; generic symbols such as `Location` do
  not alone prove LRO relevance.
- Missing/conflicting evidence produces explicit diagnostics, not a silent
  completed classification.
- The two informational types retain their original exclusions despite their
  descriptive `api-versioning` tags.
- Required documents are selected directly without scores or ranks; duplicate
  URLs are fetched once and accounted for per owning intent.
- Agent changes to tags/routing and false review accounting are rejected.
- No-match category arrays and unmapped constructs receive explicit targeted
  discovery requests.

### Selection, discovery, and migration

- With no session reuse, two required documents lead to two fetches, not four;
  six required documents remain selected when within budget.
- Fully covered intents require no discovery or full-catalog scoring output.
- Every fetch has owning-intent selection provenance and retained content
  provenance; filler fetches are rejected.
- Every discovery request has a justified result. Missing or blocked outcomes
  prevent a completed compliance decision for the owning intent.
- Failed required retrieval cannot be replaced by an unrelated document;
  discovered necessary references are subject to the same coverage rules.
- Cross-category discovery remains possible without inventing catalog IDs.
- Repeated and cyclic references do not trigger duplicate fetches.
- Budget exhaustion explicitly blocks affected intents rather than silently
  truncating their document sets.
- Informational-only assessments request no scores, discovery, or documents.
- New schemas and consumers contain no dependency on ranks, scores, or a
  four-document count; old artifacts cannot bypass new coverage checks.

### Same-session reuse

- In a same-session workflow evaluation, later intents or assessments reuse
  previously retrieved content when it is still available and sufficient.
- Reused documents retain original retrieval provenance and receive new
  intent-specific review accounting, without a fabricated fresh timestamp.
- Missing sections or lost context trigger retrieval of the needed content,
  not unsupported citations or an assumed pass.
- Fully reused selected documents require zero new network fetches but still
  appear in each assessment's evidence.
- Schema checks validate reuse provenance; they do not claim to guarantee
  that the Agent never issued an unnecessary tool call.
- No persistent cache implementation or cross-session reuse is required.

### Regression reports

For Azure/azure-rest-api-specs#44988, preserve the ConnectionAnalyzer intent
and add `arm-resource-operation`, plus other categories only where supported.
Require ARM resource operations and interface-reference retrieval/review;
do not require a predetermined violation without normative evidence.

Run the existing 12-report corpus to compare category accuracy, guidance
recall, selection and findings, discovery gaps and outcomes, input size,
document count, and retrieval/judgment time. Separate fresh-session runs from
same-session reuse runs and count actual network fetches and reused documents;
do not attribute warm-session savings to deterministic routing alone.
Check previously relevant
documents and findings as well as newly required documents; selecting the
expected ARM references alone is not sufficient to prove unchanged quality.
Intent boundaries and IDs must remain unchanged. Treat any grouping change as
a regression, not an expected improvement.
