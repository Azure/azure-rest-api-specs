# Output Contract

## Agent workspace

After deterministic analysis, read
`agent-workspace\agent-index.json` and its referenced bounded
`model-input.json` exactly once. The index must remain compact and provides
exact assessed Semantic intent, informational Semantic intent, candidate,
inference-request, and Azure Guidelines request coverage.
`agent-decisions.draft.json` is the structural template with intentionally
invalid unresolved placeholders; it is never a valid output. Read its schema
from `agent-index.json.requiredOutputs.schemas.agentDecisions` exactly once.
Resolve that path relative to the skill directory and do not search for it.

## Compact Agent decisions

Write `agent-workspace\agent-decisions.json` conforming to
`scripts\agent-decisions.schema.json`. It contains only Agent-authored
summaries, REST/downstream choices, optional inference, targeted discovery
results keyed by supplied request IDs, document provenance and bytes,
extracted guidance, failed retrievals, compliance judgments, confidence, and
blockers. Do not repeat catalog metadata, query profiles, source/hunk IDs,
canonical category/routing evidence, calculated accounting, or final output wrappers. Guidance excerpts
omit declaration IDs. Each compliance judgment selects from its prefilled
intent-scoped qualified `declarationNames` and cites guidance by `catalogId`
plus section. The materializer requires every name to resolve to an unambiguous
compiler declaration identity within that owning intent, retaining its matching
before/current declaration IDs.

Version 2 uses `discoveryResults` (`requestId`, `intentId`, `outcome`,
`catalogIds`, `rationale`) for canonical requests. `additionalSelections` records
`intentId`, `sourceCatalogId`, `sourceSection`, `trigger` (`linked-reference` or
`uncovered-concern`), `outcome`, `catalogIds`, and `rationale`. Outcomes are
`selected`, `no-match`, or `blocked`. Deterministic `classification-blocked`
requests require `blocked`; the Agent cannot clear missing/conflicting evidence
with a no-match. Search blockers are scoped by `reviewUnitId`.

Run `materialize-assessment-results.mjs --work <work-directory>`. It verifies
canonical hashes, required selection/review coverage, and exact ownership; derives canonical
linkage, guidance applicability, and accounting; drops uncited excerpts; and
atomically writes the existing inference, evidence, and judgment formats. It
never fetches documents or invents provenance, evidence, or judgment.

`api-version-publication` and `api-version-wide-change` intents are excluded
from Agent coverage. The latter is identified by a `Versions` declaration, no
directly owned operation, and only version-transition/governance mappings, not
by an operation-count threshold. Guarded finalization adds them back as
deterministic informational Semantic intents with their canonical affected
operations. They do not require inference or Azure Guidelines decisions,
create findings, or receive
relationships from other findings.

## Azure Guidelines search evidence

The materializer writes `compliance-search-evidence.json` conforming to
`scripts\compliance-search-evidence.schema.json`. Preserve one unchanged query
profile per `complianceSearchRequests` item, then store intent-scoped
`documentSelections`, shared `documents`, and targeted discovery outcomes.
There are no scores, ranks, or minimum document counts. The shared search
records original retrieval provenance, `retrievalSource` (`network` or
`session-reuse`), declaration applicability, guidance, and actual failed
attempts. Every required or discovered document must be reviewed before a
completed owning-intent decision. Catalog descriptions select documents but never serve
as guidance.

## Optional inference

`model-input.json` contains `deterministicCoverage` for every Semantic review
unit and one `inferenceRequests` item per `unknown` hunk. Do not create
`inference.json` when the request array is empty.

When requests exist, the materializer writes `inference.json` conforming to
`scripts\inference.schema.json`. Cover every request exactly once with
`candidates`, `no-impact`, or `blocked`. Inferred candidates must remain within
the request's IDs and allowed REST/downstream dimensions. They require final
Agent judgment like deterministic candidates.

## Agent judgment

The materializer writes one `assessment-judgment.json` conforming to `scripts\assessment-judgment.schema.json`:

```json
{
  "schemaVersion": 2,
  "semanticIntents": [
    {
      "reviewUnitId": "semantic-...",
      "title": "...",
      "summary": "..."
    }
  ],
  "restDecisions": [
    {
      "candidateId": "rest-...",
      "decision": "approve",
      "severity": "high",
      "rationale": "..."
    }
  ],
  "downstreamDecisions": [
    {
      "candidateId": "downstream-...",
      "decision": "reject",
      "rationale": "..."
    }
  ],
  "complianceDecisions": [
    {
      "reviewUnitId": "semantic-...",
      "reviewedCatalogIds": ["catalog-entry-..."],
      "applicableGuidance": [
        {
          "canonicalDocumentUrl": "https://...",
          "guidanceSection": "..."
        }
      ],
      "sourceChangeIds": ["source-..."],
      "hunkIds": ["hunk-..."],
      "declarationIds": ["declaration-..."],
      "decision": "applicable-fail",
      "title": "Widget does not use the documented resource template",
      "severity": "medium",
      "expected": "Exact fetched excerpt.",
      "actual": "Changed TypeSpec behavior.",
      "rationale": "..."
    }
  ],
  "overallConfidence": "high",
  "blockers": []
}
```

Coverage must be exact: one concise semantic result per supplied review unit,
one decision per supplied deterministic or inferred REST/downstream candidate,
and one Azure Guidelines decision per Semantic intent. Applicable Azure Guidelines
decisions cite fetched guidance sections and synthesize their expected pattern.
`versioned-api-evolution-guidance` is always governing for its owning intent:
completed decisions cite Evolving APIs, and existing-version evolution without
a changed versioning decorator is `applicable-fail`, even when the REST wire
shape is unchanged.
Added models, interfaces, or operations that directly or transitively use
`Azure.ResourceManager.Legacy` constructs are also deterministic
`applicable-fail` decisions. They cite current standard ARM modeling or
operation guidance; suppressions and valid static routes do not clear the
violation.
Use `no-applicable-guidance` when search completed but no fetched section
governs the intent; use `not-assessed` only for incomplete or blocked
Azure Guidelines assessment.
All IDs and URLs must come from the bounded inputs or validated inference
output. Every `applicable-fail` decision must also provide a concise finding
title and `high`, `medium`, or `low` severity for structured assessment data.

Documentation Completeness is not part of the Agent judgment. The compiler
evidence records documentation presence for changed declarations. Assembly
checks only newly added operation, model, enum, and interface declarations and
creates a finding for every eligible declaration whose effective compiler document is
missing or empty. See the [documentation rules](document-quality.md).

## Final data

Guarded finalization joins Agent-confirmed decisions to complete facts and
changed-source evidence, validates the result, and atomically writes
`assessment.json` and `assessment.html`. The internal decision value `approve`
means “retain this detected candidate as a finding”; it never means API review
approval. Validation must reject duplicate, unknown, missing, unsupported,
incomplete, or success-shaped results.

Every confirmed REST finding must contain actual and expected behavior, rationale, severity, affected operation, deterministic evidence, and exact changed TypeSpec source. Every confirmed downstream finding requires the same fields plus an SDK symbol or cross-language definition ID. User-facing output must say detected or confirmed, never approved. Semantic items require title, summary, affected operations, and changed source.

Downstream SDK method and SDK type cards must not repeat `Changed TypeSpec`
source links. Keep that evidence in `assessment.json`, Semantic intents, and
the appendix; retain only related Semantic intent links in the cards.
Method cards use direct, mixed, or indirect cause labels. Red impact links
are reserved for confirmed REST/downstream impacts and failed documentation
findings; guideline links are separate.
Downstream data and cards must not contain affected REST operations, HTTP
routes, REST-derived counts, or REST/downstream suppression records. Direct
method findings are assembled into `methodGroups`; type findings are assembled
into `typeImpacts` with deterministic TCGC `affectedMethods`.

HTML finding cards must not display `high`, `medium`, or `low` severity labels
or severity-colored borders. Severity remains available in `assessment.json`
for validation and machine consumers.

Semantic items preserve canonical `referenceCategories` and their evidence
without changing group boundaries. HTML displays human-readable category
badges, shared document selections with owning intent links, selection rules,
and original network/session-reuse provenance. `no-applicable-guidance` means
the completed required review/discovery found no governing section, not that
every Azure Guideline has been proved satisfied.

Dimension statuses are derived, not authored:

- semantic: `assessed` or `not-assessed`;
- REST/downstream: `passed`, `failed`, or `not-assessed`;
- Azure Guidelines: `passed`, `failed`, or `not-assessed`, derived from
  Semantic intent coverage and applicable fetched guidance;
- Documentation Completeness (`documentQuality`): `passed`, `failed`,
  `not-assessed`, or `not-applicable`, with `assessmentVersion: 5` and
  declaration/documented/missing coverage;
- safety scope: `rest-and-downstream-only`, never Azure Guidelines or document quality.

A blocked implemented dimension cannot pass. Documentation Completeness is
`failed` when one or more eligible newly added declarations lack a nonempty effective
compiler document, `not-assessed` when compiler evidence is incomplete,
`not-applicable` when no eligible newly added declarations are in scope, and
`passed` otherwise. Historical v1-v3 documentation-quality results remain
valid legacy data.
A completed Azure Guidelines search with no governing guidance is represented by an
intent-level `no-applicable-guidance` decision. It counts as assessed and does
not create a blocker. `not-assessed` is reserved for missing evidence,
retrieval failures, blocked Semantic analysis, or otherwise incomplete
the Azure Guidelines assessment.

## HTML

`assessment.html` must show comparison identity, overall finding count with a
finding-based status icon, REST/downstream code-safety findings, semantic
intents, active Azure Guidelines status
and coverage, fetched guidance and changed TypeSpec, collapsed finding cards,
retrieval blockers, explicit Documentation Completeness status and coverage,
and complete provenance.
Overall code quality is a non-clickable summary card. The five dimension cards
follow in this order: Semantic intents, Azure Guidelines, REST breaking changes,
downstream breaking changes, and Documentation Completeness. Main sections with findings
precede those without findings; within each group, use the dimension-card order.
Semantic intents are information only, always in the no-findings group. Show an
information icon beside its title, with intent, operation, and action counts below;
do not display Pass, Fail, or N/A status tags for Semantic intents. Preserve the
recorded review state in JSON. The appendix remains last.
Each card's heading contains only its icon and title on the same line, not a
number or Pass/Fail/N/A text. Quality cards show the recorded finding count below
the heading. Overall sums REST, downstream, Azure Guidelines, and Documentation Completeness
findings, excluding intents. Preserve status icons, accessible labels, and colors.
Count underlying findings, not grouped operations, SDK methods, or guideline issue
cards. Exclude legacy downstream entries that only repeat approved REST findings.
HTML may present multiple findings in one guideline-issue
card only when their canonical guidance document-section sets and normalized
expected behavior are identical. Grouping is presentation-only: JSON findings
and stable finding anchors remain unchanged, shared expected behavior and
guidance are rendered once, and each affected Semantic intent retains its own
actual behavior, changed-code evidence, and human-readable intent link. The
card's affected-intent detail and JSON retain the underlying intent-level
finding cardinality. Matching titles alone must not cause grouping.
Immediately below the header, render a compact `Preview Notice` details element
that is collapsed by default. Its one-line summary should occupy approximately
46 pixels vertically. The expanded body must preserve the complete approved
two-paragraph disclaimer and use two columns on wide screens and one column on
narrow screens.
Present top-level assessment blockers only in the appendix under
**Potential limits**, not as a standalone main-report section. The appendix
must include a clickable pull request link when a PR number is available,
deriving the URL from `repository.remoteUrl` when no dedicated pull-request URL
is present. Escape all source- and Agent-controlled text.

All five dimensions share a heading, description, and right-aligned metadata.
Finding and intent cards share typography, right-aligned status/cause labels,
and collapsed-by-default summaries.

REST breaking findings are operation-first: operation identity, HTTP method,
path, version, and human-readable affected-intent links in the summary; a styled
`Contract area | Before | After` table; a highlighted
`Why this is breaking` callout. Preserve findings with unavailable operation
mapping in explicit fallback cards. Do not render
severity labels, severity-colored borders, or Changed TypeSpec links in these
cards.
Semantic operation cards use the same `Contract area | Before | After` table
and removal/addition styling. They reuse confirmed REST finding rows associated
with both the operation ID and current Semantic intent. If no fine-grained
confirmed row is available, they structurally compare normalized before/after
operation facts and render the narrowest changed parameter, request schema,
response status/body/header, paging, LRO, method, or path areas. Do not render
identical top-level summaries when a deeper changed path is available. If the
normalized comparison produces no changed contract row, omit the table and
render the unchanged outcome without a redundant duplicate statement.

All REST, Semantic operation, SDK method, and SDK type contract tables use the
same two-line contract-area cell: a human-readable area kind above the concrete
member name or path. Omit rows whose displayed before and after values are
identical; omit the table if no rows remain. Keep underlying findings and
evidence unchanged. SDK rows derive concise before/after values and location
from retained TCGC facts and method-to-type reference paths. Allowed SDK
locations are `(path)`, `(query)`, `(header)`, and `(body input)` beside
numbered caller inputs, with a `Return type (body output)` row. Constant headers
appear in a note, not the numbered caller inputs. Missing facts and locations
must be labeled unavailable, never inferred from a root-wide location union.
Do not render a
`model-property-removed` row when downstream judgment concludes that the member
was compatibly preserved by an explicit response model. Prefer concrete members
and concise recorded contract values; retain expected/actual prose when no
structured value is available.

Downstream cards are method-first, merging direct method changes with indirect
type causes, using target normalized method names. Show representative graph
paths with baseline/target roles only when verified raw evidence is explicitly
supplied. Keep unmapped confirmed types visible. Do not add enum-specific or
shared-cause banners; enum transitions remain in per-method evidence.

Semantic summaries expose static `Impacts (N)` links, counting REST, downstream,
and failed documentation targets. Failed documentation links use the existing
red impact style and retain stable finding destinations. Passing, incomplete,
and appendix navigation links are not failure impacts. Guideline links are
separate. Relationship labels and
backgrounds do not toggle the card; anchors reveal their target's enclosing
details. On expansion, complete Changed TypeSpec source appears first and is
expanded. Affected operations follow in a collapsed group: at most ten operation
cards, followed by compact descriptions retaining every remaining operation ID,
HTTP method, version, and path.

Azure Guidelines summaries retain the gap and affected-intent links. The body
contains two full-width sections: Expected (distinct expected text and official
references/examples) and Actual (each finding's recorded diff once, source
links, and non-duplicate actual explanation). Grouped findings retain per-intent
anchors. Do not duplicate these sections with a comparison table or a second
source-evidence block. Preserve pass/fail/not-assessed and no-applicable-guidance
states without severity labels.

Use **Documentation Completeness** for this dimension's heading,
summary/navigation labels, and failed impact prefix
(`Documentation Completeness: ...`).
The subtitle states that the check covers compiler-resolved documentation
presence only and never compares text with code. Keep the internal
`documentQuality` key and existing section/finding anchors.

Keep the summary card and main-section coverage to the finding count and checked
declaration count, for example **0 findings** and **9 declarations checked**.
Do not include unassessed counts or partial-review wording in the overview.
Display Documentation Completeness as **Pass** when no findings are recorded and **Fail**
otherwise; Overall code quality similarly passes only when no main dimension has
findings. These display statuses do not imply complete coverage or alter recorded
assessment statuses. Label unavailable legacy assessment counts explicitly instead
of inventing zero. Full coverage and documentation blockers remain in
`assessment.json`, not the HTML.

The main documentation section contains only missing-document finding cards and
compact coverage. Do not render Documentation Completeness details in the
appendix. Each finding shows declaration identity, the exact bounded TypeSpec declaration
source, missing-document evidence, the suggested addition, and the compiler
source location.
Escape every string and do not fabricate replacement prose or new judgment
fields. Omit documented declarations, incomplete scopes, and detailed coverage
from HTML; complete presence facts and blockers remain in `assessment.json`.

`renderReportSections` returns main `html` and an empty `appendixHtml` for
compatibility. The general report appendix remains unchanged. Hash navigation opens
all enclosing details for appendix, finding, and intent links. Failed documentation
links contribute to semantic `Impacts (N)` but never to scoped REST/downstream safety.
Recorded documentation findings participate in overall code quality; coverage
limitations remain recorded in the assessment data.
