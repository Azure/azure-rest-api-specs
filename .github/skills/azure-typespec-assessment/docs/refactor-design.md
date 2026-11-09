# Assessment Skill Refactor Design

**Status: Baseline refactor, consumer-propagation removal, and two-stage source
association implemented; four fresh PR assessments and measurements completed.**

This document defines the approved simpler implementation and report layout for
`azure-typespec-assessment`.

The [existing design](design.md) describes the current system. This proposal
does not replace that document or change the current skill instructions.

The source-selection sections below retain the original joint-phase proposal
for context. The user subsequently approved implementation and a separate
post-judgment source phase.

The newer [post-judgment source association design](post-judgment-source-association-design.md)
defines the implemented two bounded AI stages: freeze candidate judgment first, then
associate complete TypeSpec source only for confirmed breaking findings. It
supersedes the single-phase source-review timing described below. Current
runtime and skill instructions use the two-stage path for new assessments;
historical single-phase artifacts remain readable.

## 1. Goal

Make the assessment easier to understand, maintain, and read without weakening
its evidence guarantees.

The refactor should reduce:

- responsibilities mixed into the coordinator;
- repeated derivation of contract changes and finding relationships;
- presentation of one model change through many unchanged consuming methods;
- renderer-side evidence analysis;
- historical behavior mixed into the current execution path; and
- overlapping or contradictory design instructions.

Simplicity means fewer owners and transformations, not fewer assessed changes.
Keep complete canonical evidence and findings even when the report presents a
smaller view.

## 2. Scope and non-goals

The proposed scope covers orchestration, bounded-input construction,
materialization, report projection, rendering, and their documentation.
Post-implementation acceptance also includes refreshing the user-selected
published report collection and recording actual performance and limitations.

Preserve all five dimensions:

| Dimension                    | Evidence and responsibility                                        |
| ---------------------------- | ------------------------------------------------------------------ |
| Semantic intents             | Compiler-backed changed TypeSpec source and deterministic grouping |
| REST compatibility           | AutoRest wire-contract comparison                                  |
| Downstream SDK compatibility | Language-neutral TCGC public-contract comparison                   |
| Azure Guidelines             | Fetched official guidance assessed against Semantic intents        |
| Documentation Completeness   | Compiler-resolved effective-document presence                      |

This is not a proposal to:

- change compatibility rules or API-version selection;
- remove blockers, fabricate evidence, or treat missing evidence as a pass;
- generate language SDKs locally or add generated-SDK input support;
- merge REST and SDK compatibility verdicts;
- replace deterministic grouping with Agent judgment;
- introduce a generic workflow engine, plugin system, or graph framework;
- add selectable report layouts; or
- remove historical report support without a separate approved decision.

Overall safety remains scoped to REST and downstream SDK compatibility.
Guidelines and documentation retain independent results.

## 3. Current complexity

The main pipeline already has suitable stages, but their responsibilities are
not consistently separated.

| Area                         | Current concern                                                                                                            | Proposed boundary                                                                                   |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `run-assessment-analysis.ts` | Coordinates execution and also compacts facts, classifies hunk coverage, selects inference, and accounts for input budgets | Coordinator owns stage order; bounded-input construction owns those related calculations            |
| Assembly and rendering       | Both derive presentation-oriented contracts and groups                                                                     | Derive the report projection once, then render it without re-analysis                               |
| Downstream presentation      | Direct method changes and propagated model changes are combined into method-first cards                                    | Present direct method changes and model/type changes separately                                     |
| Runtime compatibility        | Current and historical shapes are handled in multiple places                                                               | Normalize historical report inputs at an explicit boundary                                          |
| `docs/design.md`             | Architecture, schemas, historical rules, examples, and layout instructions overlap                                         | Keep current architecture concise and delegate detailed contracts to their authoritative references |

Existing helpers should be reused where they already own these responsibilities.
Extract code only where it establishes a real boundary; splitting large files
alone is not a design objective.

## 4. Proposed execution pipeline

```text
Selected Git comparison
        |
        v
Prepare canonical evidence
        |
        v
Analyze dimensions deterministically
        |
        v
Build bounded Agent input
        |
        v
One bounded Agent judgment
        |
        v
Materialize decisions against canonical evidence
        |
        v
Finalize validated assessment and report projection
        |
        v
Render and serve report
```

Keep the existing coordinator, materialization, finalization, and serving
entrypoints. Users should not need additional commands or workflow choices.

### Preparation

Own Git comparison, selected scope, sparse worktrees, dependency setup,
compiler source evidence, emitter artifacts, and comparison provenance.

Keep source comparison distinct from artifact comparison. AutoRest and TCGC
must use the same source revision and API version within each artifact role.
Local dirty overlays remain isolated from immutable PR/head assessments.

### Deterministic analysis

Own Semantic groups, affected REST operation mappings, REST candidates,
downstream candidates and reference evidence, and documentation presence.

The source analyzer owns group membership and stable intent IDs. Downstream
reference graphs remain available for compatibility analysis and provenance,
but they do not require a consuming-method card for every changed type.

### Bounded-input construction

Own fact selection and compaction, canonical evidence references, hunk coverage,
unknown-hunk inference requests, query profiles, and budget accounting.

Calculate each once from the same canonical inputs. Preserve required evidence
through explicit references; do not silently omit candidates or decisions to
fit a budget. Documentation presence remains outside Agent judgment.

### Unclassified changes: complete-evidence Agent review

User-directed requirement: when a change cannot be classified, the Agent must
review the complete change and the context needed to judge it. A candidate
synopsis or the report's shortened TypeSpec snippet is not sufficient.

Known candidate rules are classification aids, not an exhaustive whitelist of
possible compatibility changes. An empty candidate list or an unmatched rule
does not establish `no-impact`.

Keep unclassified changes visible with their before/after evidence and
provenance. Distinguish source-hunk coverage, contract-change coverage, and
evidence completeness; exact decision coverage of generated candidates alone
does not prove complete analysis.

For an unclassified change, provide indexed access to:

- the full TypeSpec diff for the selected comparison, including complete hunks
  rather than only card-specific snippets;
- complete baseline and target contracts for the affected entities, including
  members omitted from compact facts;
- referenced types, helpers, and method/type relationships needed to understand
  the change; and
- source revisions, API versions, identities, and available usage/direction
  evidence for both comparison roles.

The Agent must inspect the full unclassified change, not only its summary, and
expand to the complete selected diff or enclosing contract when context is
needed. Do not require every known candidate to trigger a second review of all
evidence, and do not expand outside the user's selected assessment scope.

Use canonical artifact references to keep the initial input bounded without
withholding necessary evidence. Budget limits must result in explicit
incomplete assessment if evidence cannot be reviewed, not silent truncation.
When normalization cannot represent an emitted field or structure, retain
indexed original emitter evidence where feasible and disclose the limitation.
Do not discard it and then treat equal normalized facts as proof of no impact.
Any necessary access to raw emitter evidence is an explicit, provenance-bound
exception for unresolved analysis, not permission for broad artifact scanning.

The Agent may identify a compatibility impact without forcing it into an
inaccurate existing rule. Its result must remain linked to the supplied change
and evidence and pass deterministic materialization validation. It may not
invent identities, operations, sources, or Semantic groups. If the current
inference/decision contracts cannot represent that result, define the required
contract extension explicitly before implementation rather than silently
dropping the change.

If complete evidence establishes compatibility, record a reasoned no-impact
result. If it establishes incompatibility, retain an evidence-backed finding.
If evidence or execution is insufficient, retain a blocker and `not-assessed`;
inability to classify is never automatically a compatibility pass.

This review requirement changes analysis coverage, not HTML verbosity.
Final report cards show only evidence-backed relevant code selected through the
deterministic-first, AI-assisted process in section 6; complete evidence remains
available for analysis and audit.

### Agent judgment and materialization

The Agent owns summaries and compatibility/guidance decisions, not canonical
identities, group membership, operation mappings, or compatibility-evidence
relationships. This includes review of declared unclassified changes using the
complete evidence above, not unrestricted discovery outside the assessment
scope.

The proposed source-selection extension adds a separate presentation duty:
review deterministic snippets for relevance and contextual completeness, and
select supporting source when deterministic association is missing or
insufficient. These are provenance-bound display selections, not new causal
claims or changes to compatibility judgments. They use the existing bounded
Agent phase rather than a second assessment or a per-card Agent workflow.

Keep one compact decision artifact. Before implementing the extension, specify
its source-review decisions and evidence-index additions explicitly; the current
decision schema must not be assumed to support them already. Materialization
validates exact decision coverage, resolves canonical identities, validates
source selections against canonical text and locations, and writes the
materialized artifacts. It does not fetch guidance or make compatibility or
semantic-relevance judgments.

### Finalization

Own final findings, reciprocal relationships, statuses, counts, validation,
and the report projection. Preserve artifact-integrity checks and independent
final-result validation.

The renderer consumes prepared display data. It escapes values and emits HTML;
it does not rediscover changes, infer causality, or reconstruct Semantic groups.

### Consumer-propagation simplification

The assessment does not need to enumerate every REST operation or SDK method
that consumes a changed model/type. Its primary responsibilities are:

- identify direct operation/method contract changes;
- identify model/type contract changes;
- explain why each accepted change is breaking; and
- associate each finding with the most relevant TypeSpec declaration and
  source.

Consumer inventories are a separate concern. A REST model finding currently
collects operation IDs from accepted operation-scoped findings, while an SDK
type impact follows the TCGC reference graph from a changed type through
intermediate types to every reachable public method. These are different
relations with different coverage semantics. Presenting both as "affected"
lists suggests equivalence that the evidence does not establish.

The implemented simplification removes consumer-propagation analysis and display
without weakening direct breaking-change detection:

| Remove or simplify                  | Implemented change                                                                                                                                                                                            |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SDK type-to-method reference graph  | Remove graph construction, reverse traversal, shortest-method paths, reference edges, path locations, and consumer-method facts used only for propagation.                                                    |
| SDK propagation root causes         | Stop creating type-contract/enum-union propagation roots. Group accepted method findings by method identity and accepted type findings by type identity directly.                                             |
| SDK affected-method aggregation     | Remove `affectedMethods`, `affectedMethodCount`, aggregate locations, reference fact IDs, and unresolved consumer-relationship reasons from newly assembled type impacts.                                     |
| SDK report enrichment               | Remove type-to-method path reconstruction, indirect method cards created only from type consumption, affected-method lists, and the historical sidecar path used only to replay these associations.           |
| REST affected-operation aggregation | Stop collecting and rendering operation inventories beneath model/type cards. Keep operation IDs on operation-scoped REST evidence while they are required for compatibility direction and Semantic matching. |
| Agent input                         | Do not retain unchanged public methods, intermediate types, propagation roots, or reference edges solely to explain which consumers expose a changed type.                                                    |
| Validation and schemas              | Remove consumer-count/path consistency checks from the new output contract. Continue accepting historical fields during compatibility migration rather than reinterpreting or rejecting old reports.          |

This simplification deliberately preserves the following analysis:

- `compareMethods` and method-delta analysis for direct SDK method changes;
- model, enum, and union comparison for direct SDK type changes;
- TCGC public reachability and usage needed to determine whether a type belongs
  to the public SDK contract;
- AutoRest request/response direction, visibility, schema traversal, and
  reference resolution needed to judge REST compatibility;
- finding-to-TypeSpec declaration/source association and complete owning-model
  diffs; and
- finding-to-Semantic-intent relationships.

Public reachability and consumer propagation are distinct. The assessment must
still answer whether a changed SDK type is public and compatibility-relevant.
It does not need to answer which public methods expose that type or through
which nested property path.

REST requires a narrower first step than SDK. REST model changes are currently
discovered while comparing baseline and target operation request/response
schemas. Removing the displayed operation inventory does not justify removing
that traversal or its operation IDs: request versus response direction changes
the compatibility judgment, and operation identity currently supports
Semantic-intent matching. A future independent named-model comparison would be
a separate analyzer redesign with explicit identity, visibility, direction,
versioning, and deduplication rules.

The intended report after this simplification is:

- operation cards for direct REST operation changes;
- REST model/type cards for wire model changes, without an affected-operation
  list;
- method cards for direct SDK method changes; and
- SDK model/type cards for public type changes, without affected-method lists
  or duplicate indirect method cards.

Performance improvement is expected primarily from reducing bounded Agent
input, not from HTML changes or deterministic execution. In the isolated PR
46679 measurement, downstream deterministic analysis took about 1.163 seconds,
so removing graph traversal alone cannot materially reduce the 117-second
preparation phase. However, the existing consumer graph contributed 32
graph-only facts, 96 reference edges, approximately 48 KB of compact facts,
and approximately 19 KB of root-cause data to the bounded input: roughly 16%
of that compact model input. This is potential removable payload, not a
guaranteed 16% reasoning-time reduction. Some evidence may remain necessary
for direct candidates or inference, and model latency is not linear in input
bytes.

Post-implementation validation records a same-PR before/after comparison that measures:

1. preparation and downstream-analysis duration;
2. physical and compact bounded-input size;
3. retained fact, root, and reference-edge counts;
4. Agent reasoning duration across repeated runs;
5. findings, severity, coverage, and source-association equivalence; and
6. removal of consumer-only cards and lists without loss of direct
   operation/method or model/type findings.

Do not claim a performance improvement unless repeated equivalent assessments
show it. Agent nondeterminism must be reported separately from deterministic
payload and execution changes.

## 5. Data ownership and presentation boundary

Keep the current serialized assessment and evidence contracts unless an
explicit schema change is approved. The simpler report projection is internal;
do not add another persisted artifact or public output format solely for HTML.

| Data                                                                  | Single owner                       |
| --------------------------------------------------------------------- | ---------------------------------- |
| Hunk/declaration ownership and Semantic group boundaries              | Semantic analysis                  |
| Wire and SDK contract facts and candidates                            | Their respective analyzers         |
| Candidate approval and rationale                                      | Agent judgment                     |
| Canonical finding/evidence joins                                      | Materialization and final assembly |
| Initial relevant-source mapping and contextual snippets               | Deterministic source projection    |
| Source relevance/completeness review and missing display associations | Bounded Agent source review        |
| Source-span validation and extraction of original text                | Materialization                    |
| Semantic/finding relationships                                        | Deterministic final assembly       |
| Changed-only display rows and card grouping                           | Report projection                  |
| HTML structure, escaping, and disclosure behavior                     | Renderer                           |

A report card needs only:

- stable identity, dimension, and category;
- human-readable contract name;
- canonical finding IDs;
- changed-only contract rows;
- finding rationale or distinct row rationales;
- proven Semantic intent links; and
- bounded source evidence with original path and line provenance.

Rows contain a contract area, member/path, and structured Before/After values.
They are derived from canonical normalized evidence, not parsed from
Agent-authored prose. One shared row renderer handles REST and SDK cards.

Historical inputs should be adapted once before current report projection.
Historical fields must not acquire evidence guarantees they never had. Missing
information remains explicit; unsupported historical data is not discarded.

## 6. Report layout

### Reference

Use layout 1 from the **Assessment UI mockup** session:

- Session ID: `64ccaf7c-6319-4b27-8e66-909d919c1e8d`.
- Preview: <http://127.0.0.1:4876/?pr=46679&layout=1&t=702#sdk-type-CloudAccountUpdate>.
- Card order: contract table, breaking rationale, then collapsible TypeSpec
  source.

The local URL is a design reference, not a durable runtime dependency. Do not
copy its findings, asserted replacements, or causal claims into production
logic. The mockup is authoritative only for the proposed visual direction.

### Sections

Retain the five dimensions and their existing navigation destinations.
REST and downstream remain separate sections, each with two categories:

| Section        | Category             | Content                                                                                                             |
| -------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------- |
| REST           | Operation changes    | Direct changes to operation identity, method/path, parameters, request contract, responses, paging, or LRO behavior |
| REST           | Model/schema changes | Changed named wire types, members, enum values, requiredness, or constraints                                        |
| Downstream SDK | Method changes       | Direct public method identity, owner, parameters, response type, kind, access, paging, or LRO changes               |
| Downstream SDK | Model/type changes   | Public model, enum, union, or other type-contract changes                                                           |

An operation using a changed model does not automatically belong in the
operation-change category. Property-only changes stay on the model card.
A direct request-model identity or schema-composition change may produce an
operation row when canonical evidence proves that change. If independent
operation and model findings both exist, preserve both without duplicating
their rows.

Client/customization findings must remain visible even when they do not fit a
model card. Use a clearly labeled method/client card when supported; otherwise
retain an explicit unmapped-contract card. Never force a finding into a guessed
identity to fit the layout.

### Card structure

Every breaking-change card follows the same structure:

1. Contract name and concise change summary.
2. `Contract area | Before | After` table containing only changed values.
3. `Why this is breaking` rationale.
4. Collapsed `Changed TypeSpec source` disclosure.
5. Proven links to related Semantic intents.

Cards are collapsed by default. Fragment navigation reveals the enclosing
card. Preserve existing finding anchors even when several findings share one
card.

Before/After must show the concrete changed field or structure. Equal display
names are not an adequate explanation of a changed contract. Show the relevant
member or schema composition instead. Use explicit missing-side values for
additions/removals, not an invented replacement.

Do not show full unchanged contracts, affected-operation inventories, method
reference chains, or a separate card for every unchanged consumer of a type.
Complete inventories and paths remain in JSON. Short links to directly changed
cards may be shown only when supported by canonical evidence.

Use `Related change`, not `Caused by`, unless the evidence establishes causality.
Shared names, routes, source files, or coincident additions/removals are not
sufficient relationship or replacement evidence.

### Relevant TypeSpec source only

User-directed requirement: match the mockup's focused source presentation.
Each change card shows only the TypeSpec changes relevant to that card, not
all source hunks owned by its enclosing Semantic intent.

The governing principle is **deterministic association first, AI association
when rules cannot establish it, and an AI quality check of the selected code**.
The result must be a **minimal complete relevant code set**: enough original
TypeSpec to explain the breaking change coherently, not isolated one- or
two-line fragments, and not a long unrelated declaration or intent-wide diff.
Minimality is semantic, not a smallest-line-count contest.

#### Deterministic association and context

Start from finding-specific declaration, member, hunk, compiler, and normalized
contract evidence. Follow the actual changed contract path to its owning source
declaration, including request/response models and supporting helpers where
proven. A REST operation ID is not a TypeSpec declaration name; display-name
equality, a shared file, or a shared Semantic intent alone does not prove a
source association.

For model/type cards, show one unified diff of the complete owning model
declaration whenever canonical baseline and target declaration snippets are
available. Include model-level decorators, all members, and member decorators,
not only the changed property. Unchanged lines provide coherent model context;
removed and added lines identify the exact contract delta. Do not render
separate baseline and target blocks or a secondary changed-line diff, and do
not expand to other models merely because they share the same Git hunk or
source file.

For operation/method cards, select the complete affected operation signature,
relevant decorators, and supporting model/helper declarations needed to
understand the delta. A card containing multiple findings uses the union of
their supported ranges, deduplicated without expanding to unrelated
declarations.

Hunk selection is not sufficient when one Git hunk includes several unrelated
declarations. Use baseline/current declaration and member spans, not just
changed-line windows:

- retain relevant changed code and its attached decorators, including version,
  visibility, constraint, rename, and removal metadata;
- retain a complete affected member or operation construct, its enclosing
  declaration identity, and enough unchanged context to explain the change;
  unchanged supporting code is allowed when necessary for comprehension;
- keep multiline decorators, generic arguments, spreads, and signatures
  intact; an isolated decorator without its member is not a complete snippet;
- omit unrelated documentation and comments from the display, but preserve
  them when their changes are relevant evidence; do not blindly delete all
  `@doc` or comment lines;
- preserve original file, revision, and line provenance; and
- show explicit omission markers or separate snippets for discontinuous ranges
  rather than presenting them as one continuous original diff.

#### AI source review and fallback association

Within the existing bounded Agent phase, review the deterministic source
selection for every breaking finding, including inferred findings once they
have evidence-backed identities. Provide the finding's concrete contract delta,
baseline/target roles and versions, deterministic snippets and association
reasons, and indexed access to original TypeSpec declarations and context in the
selected assessment evidence. The report's shortened snippet must not be the
Agent's only source of context.

For each finding, the Agent records one source-review outcome:

| Outcome    | Meaning                                                                                                                                                           |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Keep       | Existing selection is relevant, coherent, and the minimal complete set                                                                                            |
| Refine     | Association exists, but context must be expanded, unrelated code removed, or excerpts separated to explain the change clearly                                     |
| Associate  | Deterministic rules could not associate sufficient code; the Agent selects evidence-backed declarations/ranges and explains their relevance to the specific delta |
| Unresolved | Available evidence does not establish a reliable source selection; retain the reason explicitly                                                                   |

This checks both absence and quality: code already being present is not
sufficient if it is misplaced, incomplete, confusing, or unrelated to the
breaking change. Keep correctly mapped relevant code covered; refine the
display selection without discarding evidence required to explain any finding.
Do not treat AI review as permission to replace a deterministic association
with a contradictory mapping.

When association is missing, let the Agent follow indexed source/contract
relationships and read bounded enclosing declarations or supporting helpers
from the assessed baseline and target. Do not guess from a symbol name alone,
scan unrelated projects, read the current checkout as a substitute for the
assessed revision, or generate plausible replacement TypeSpec.

The decision records finding ID, selected evidence/declaration IDs, revision,
original line ranges, outcome, and a concise relevance/context rationale.
Preserve the deterministic proposal and distinguish deterministic versus
AI-assisted selection provenance in structured results. AI association is a
display-evidence relationship, not a deterministic causal guarantee.

Materialization must check that every selected range exists in the indexed
canonical source, belongs to the correct project/revision and comparison role,
and references the intended finding and supplied evidence. Extract snippet text
from that source; never render Agent-authored code as original evidence.
Validate decision coverage and preserve required constructs and omission
boundaries. Mechanical validation proves provenance and range integrity, not
the Agent's semantic relevance judgment; retain that distinction for audit.
Invalid or contradictory selections remain explicit unresolved source evidence
rather than silently falling back to unrelated code.

The renderer only displays the validated selection. It performs no AI calls,
fresh source discovery, compatibility judgment, or causal inference.

#### Minimal complete set and unresolved cases

The set is complete when a reader can identify the owning declaration, see the
affected member/signature and relevant metadata, and understand the breaking
delta without reconstructing missing surrounding syntax. Include a small
supporting declaration when the primary excerpt alone cannot explain a helper,
spread, or type transition. Exclude consumers and neighboring additions that do
not explain the finding.

Do not impose a fixed line cap that silently hides relevant changes. Prefer a
few cohesive snippets over either isolated diff lines or a large source dump.
Use collapsible supporting context for legitimately longer dependencies; keep
the principal code focused and preserve explicit omissions. Full declarations
are appropriate only when their full content is needed.

After deterministic selection and AI fallback, if source relevance still cannot
be established, keep the finding and state
`Relevant TypeSpec source could not be established` with the unresolved reason
in structured evidence. A display-source limitation does not erase the finding,
change its compatibility verdict, or establish that no TypeSpec code exists.
Do not substitute all project changes or an unrelated representative example.

Examples for PR 46679:

- The RoleAssignment card shows the model identity and complete affected
  `roleName` and `entities` members with relevant versioning/constraint
  decorators, not the enclosing intent's 11 hunks and 239 diff lines.
- The `saaSGuid` to `saasGuid` delta follows the request schema to
  `ActivateSaaSParameterRequest`. Show its declaration identity and complete
  old/new member context with `@removed`/`@added`; do not filter by
  `SaaSOperationGroup_ActivateResource` as if it were the owning declaration.
- Nearby `CompanyProfile` additions are excluded unless specific evidence
  explains why they are necessary to understand the particular finding.

Production selection derives relevance from evidence, not hard-coded example
data. Neither AI nor deterministic projection may fabricate code, locations,
causality, or replacement claims.

Keep complete canonical source evidence in JSON. The focused HTML is a
presentation projection and must not narrow analysis scope or hunk coverage.
Label snippet counts as snippets, not source-file or total-hunk counts.

### Grouping and counts

Group confirmed rows within a dimension by proven contract identity, scoped
to project and API-version comparison. Do not group by display name or finding
title alone. REST and SDK cards are never deduplicated across dimensions.

Each finding has one primary card within its dimension. A grouped card retains
all finding IDs and distinct deltas. Findings without proven grouping evidence
remain explicit standalone cards.

Summary finding counts use canonical finding cardinality. Category headings
may show operation/model card counts, labeled as such. Grouping cannot change
the number of findings or the compatibility verdict.

Keep coverage details and limitations out of individual change cards. Retain
them in structured results and the appropriate evidence/limits area. A missing
assessment must not become an apparent compatibility pass.

### Other dimensions

Semantic intents remain concise source-first explanations, with proven impact
links and a bounded, clearly labeled representative source example rather than
every intent-owned hunk. This example describes the intent; it is not a
substitute for finding-specific source on breaking cards. Do not repeat the
full breaking tables inside each representative operation.

Azure Guidelines keeps intent-level decisions and fetched-guidance provenance.
Documentation Completeness keeps missing-document findings and compact checked
declaration counts. Neither dimension gains operation-by-operation judgments.

## 7. Required invariants

The refactor must preserve:

- exactly-once meaningful hunk ownership and candidate decision coverage;
- deterministic IDs, ordering, grouping, and operation mappings;
- independent REST and SDK evidence and compatibility decisions;
- provenance for source revisions, API versions, declarations, and facts;
- bounded inference only for declared unknown-hunk requests;
- bounded AI source review only for finding-linked presentation evidence,
  separate from compatibility inference and canonical source ownership;
- complete canonical findings even when display evidence is bounded;
- explicit unavailable, ambiguous, or blocked evidence;
- compiler-derived documentation presence for eligible new declarations;
- fetched official guidance as the source of Guidelines expectations;
- safe escaping and stable report navigation; and
- read-only assessment of the user's source, index, and branch.

Repeated finalization with the same inputs must preserve finding, card, row,
and relationship identities and ordering; volatile telemetry is not semantic
output.

## 8. Policy and documentation questions

These are unresolved policy/documentation inconsistencies, not permission to
change analyzer behavior:

| Question                                                                                                                   | Proposed treatment                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| New-version REST rules retain substantive differences, but the Network example demands no REST findings for the transition | Establish the authoritative policy and expected examples before changing either                                                          |
| Documentation v5 checks compiler presence, while later examples describe legacy prose decisions                            | Distinguish current presence checks from historical replay contracts                                                                     |
| Some report sections count grouped cards and others count underlying findings                                              | Use finding counts for summaries and separately labeled card counts                                                                      |
| Historical rendering branches contribute substantial complexity                                                            | Preserve support through boundary adaptation; assess supported shapes before extraction                                                  |
| The mockup includes coverage badges and asserted REST/SDK causal links                                                     | Do not adopt them as required card behavior or evidence rules                                                                            |
| Existing unknown-hunk inference may not represent every unclassified contract change                                       | Specify evidence access, accounting, and any required inference/decision contract extension before implementing complete-evidence review |

Where an approved presentation change differs from the existing output/layout
instructions, update those instructions in the same implementation phase.
Until then, current instructions remain in force.

## 9. Proposed implementation sequence after approval

1. Establish characterization coverage for canonical findings, provenance,
   relationships, and existing replay inputs.
2. Separate bounded-input construction from coordinator orchestration without
   changing emitted artifacts.
3. Establish one report projection for contract grouping and changed-only rows.
4. Render the approved two-category layout using shared card/table primitives.
5. Consolidate historical input adaptation while preserving replay behavior.
6. Update the current design and report references to describe the resulting
   implementation, removing obsolete duplication.
7. Complete the four named end-to-end validations, show their reports, and
   record actual performance without a timing threshold. Any later refresh of
   the remaining report collection requires the content/completeness checks
   below, not a performance pass.

For the newly proposed AI-assisted source-selection extension, first approve
the design, then specify its decision-schema/evidence-index changes, implement
deterministic contextual selection and bounded Agent review, and validate
materialization and report behavior together. This is a follow-up to the
implemented baseline, not authorization to execute those steps now.

Keep changes bounded and reviewable. Do not rewrite analyzers or introduce new
schema versions merely to reorganize orchestration and presentation.

## 10. Acceptance criteria

### Logic

Pure orchestration and presentation changes preserve candidates, decisions,
findings, Semantic ownership, compatibility verdicts, and evidence relationships
for unchanged canonical inputs. Presentation changes must not alter analysis.
Review of previously unclassified evidence is a deliberate coverage expansion;
evaluate newly supported findings separately from behavior-preserving changes.

The coordinator expresses stage order rather than domain classification.
Required evidence is selected once for bounded input. The renderer does not
perform fresh compatibility analysis or infer relationships.

- A change unmatched by known rules remains available for Agent review.
- The Agent can read complete unclassified changes and necessary baseline/target
  context; report-snippet trimming never limits judgment evidence.
- Unknown emitted fields or unsupported structures are retained as evidence or
  explicitly blocked, not silently omitted and reported as unchanged.
- Missing evidence, unread evidence due to budget limits, and unresolved
  classification never imply compatibility.

### Report

- A property-only change produces a model/type card, not cards for unchanged
  consuming methods.
- Direct path, parameter, return-type, and basic/LRO/paging changes produce
  operation/method cards with concrete changed rows.
- A changed schema with an unchanged display name still shows its actual
  structural difference.
- Type removal without proven replacement remains a removal.
- REST-only and SDK-only findings remain independently visible.
- Unmapped, ambiguous, and unavailable evidence remains explicit.
- Counts and anchors survive card grouping.
- Tables, rationales, source disclosures, and navigation use the same behavior
  across REST and SDK sections.
- Source snippets contain only the card's relevant changed declarations or
  members and necessary context, even when their Git hunk contains other changes.
- The RoleAssignment example excludes unrelated intent hunks while retaining
  relevant versioning and constraint decorators.
- Unrelated documentation is omitted from snippets, but relevant documentation
  changes and multiline decorators remain intact.
- Discontinuous snippets preserve original locations and visibly mark omissions.
- Missing precise source mappings remain explicit without displaying unrelated
  source; complete evidence and coverage remain unchanged in JSON.
- Deterministically covered findings receive a source-quality review; coherent,
  minimal complete selections are kept without unnecessary expansion.
- Missing deterministic associations trigger bounded AI association against
  original assessed source, not an immediate unavailable placeholder.
- AI can add necessary context or supporting code and remove irrelevant display
  context without changing canonical source ownership or compatibility results.
- Shared-hunk, request-model, multiline-signature/decorator, helper/spread,
  unchanged-supporting-context, and ambiguous-source cases have explicit
  coverage in source-selection validation.
- Invalid spans, wrong revisions, invented text, contradictory associations,
  and unresolved relevance remain explicit; no fabricated snippet is rendered.
- Code excerpts preserve complete affected constructs and an identifiable
  enclosing declaration rather than lonely decorator/member lines.
- Structured evidence distinguishes deterministic selection from AI refinement
  or association and retains the review rationale.

### Validation after implementation approval

Use existing focused tests and type checks for the changed modules. Replay
retained current and historical assessment artifacts. Inspect the rendered cards
for property-only, direct method, removal, empty, and blocked cases.

After implementing the consumer-propagation simplification, rerun all four
named validation PRs from fresh output directories:

- [PR 46679](https://github.com/Azure/azure-rest-api-specs/pull/46679);
- [PR 44988](https://github.com/Azure/azure-rest-api-specs/pull/44988);
- [PR 44288](https://github.com/Azure/azure-rest-api-specs/pull/44288); and
- [PR 43918](https://github.com/Azure/azure-rest-api-specs/pull/43918).

Complete preparation, deterministic analysis, fresh Agent judgment,
materialization, guarded finalization, report serving, and browser inspection
for every PR. Generate and retain a new `assessment.json` and
`assessment.html` for each run. Previous source-layer reports, HTML-only
rerenders, reused decisions, and frozen compiler evidence do not satisfy this
post-simplification validation.

Record performance for every PR with the same timing boundaries and include:

- preparation, deterministic REST analysis, and deterministic downstream
  analysis;
- bounded-input physical bytes, compact bytes, retained fact count,
  propagation-root count, and reference-edge count;
- dispatch-to-first-action and fresh Agent reasoning/decision time where
  measurable;
- materialization, correction, and finalization attempts and durations;
- successful-attempt and cumulative end-to-end wall time, including failed
  attempts and retries; and
- report-serving/readiness time separately from assessment completion.

Compare these results descriptively with the most methodologically compatible
pre-simplification measurements. Report payload reduction and runtime changes
separately. Do not attribute Agent timing differences solely to the graph
removal when findings, decisions, retries, or model behavior differ. There is
no performance threshold for any of the four PRs.

For content validation, confirm that direct REST operation changes, direct SDK
method changes, REST model/type changes, SDK model/type changes, compatibility
coverage, blockers, and complete TypeSpec model diffs remain correct. Confirm
that consumer-only affected-operation/method lists, indirect SDK method cards,
propagation roots, and reference-path evidence are absent from newly generated
output. Any finding-count or verdict difference must be explained from
evidence or Agent judgment rather than accepted as an assumed consequence of
the simplification.

User-directed required validation: after design approval and implementation,
run fresh, complete assessments of both
[PR 46679](https://github.com/Azure/azure-rest-api-specs/pull/46679) and
[PR 44988](https://github.com/Azure/azure-rest-api-specs/pull/44988) using the
implemented skill, then show both newly generated reports to the user.
Open the two reports as separate browser panels in the app's right-hand panel,
clearly titled `PR 46679 Assessment` and `PR 44988 Assessment`. Chat links alone
do not satisfy the requested presentation. Keep both panels available for
comparison and verify that each displays its newly generated report, not the
mockup or a stale published page.

This requirement applies even if the implementation changes presentation only.
Replaying published assessment JSON, reopening existing reports, or showing
mockups does not satisfy it.

User-directed follow-up acceptance: after the AI-assisted source-selection
extension is approved and implemented, generate fresh reports for both PR 46679
and PR 44988 using that implementation, show both in the right-hand panel, and
tell the user the measured time for each. Existing baseline-refactor reports do
not satisfy this follow-up. Report end-to-end wall time, source-review time
where measurable, retry/cumulative time, and each execution/content-check outcome
separately. Do not start these runs during design-only work.

For each of the two reference PRs:

1. Use the PR assessment coordinator and record the resolved PR head, actual
   target baseline, and selected artifact-comparison versions.
2. Complete deterministic analysis, bounded Agent judgment, materialization,
   and guarded finalization in a separate fresh output directory.
3. Require validated `assessment.json` and `assessment.html`. Preserve and
   disclose blockers rather than presenting an incomplete run as successful
   validation.
4. Serve the new report, confirm that its server is running and responding,
   open it in the browser, and inspect the relevant cards.
5. Give the user a separately labeled clickable report URL and absolute
   `assessment.json` path for each PR, together with the validation outcome.

For PR 46679, inspect the RoleAssignment model/type card: show one complete
owning-model diff with unchanged context plus the relevant property and
decorator changes, not all hunks from the enclosing intent.
For PR 44988, inspect the Service Gateway direct method-change cards and their
relevant TypeSpec source. Check changed-only Before/After values, source
disclosures, and preserved finding/intent links against the approved design.
Do not force findings or compatibility verdicts to match the mockup; judgment
must follow the run's evidence and the approved compatibility policy.

### Two additional end-to-end cases after the source-layer implementation

User-confirmed scope: add two PRs from the published report collection to the
design, then run them after the AI-assisted source layer is implemented; do not
run the current implementation now. Together with PRs 46679 and 44988, this
defines four named end-to-end validation cases.

The additional cases were selected from the site's
[report index](https://haolingdong-msft.github.io/typespec-assessment-reports/reports.json)
and inspected published reports on 2026-11-06:

| Additional PR                                                                                                                                                                                    | Observed published case and selection rationale                                                                                                                                                             | Source-layer checks                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [44288: HorizonDb](https://github.com/Azure/azure-rest-api-specs/pull/44288) ([published report](https://haolingdong-msft.github.io/typespec-assessment-reports/reports/pr-44288/))              | Private endpoint update/delete templates gain a `HorizonDbCluster` generic argument; the published report records changed routes, SDK input order, and return type, with partial evidence coverage          | Follow operation/template relationships rather than operation-ID string equality. Include the owning interface, complete multiline operation/template arguments, and necessary supporting context without unrelated operations. Check each finding's relevance separately; retain existing unresolved-contract limitations rather than treating successful source association as complete compatibility coverage. |
| [43918: ContainerService Fleet](https://github.com/Azure/azure-rest-api-specs/pull/43918) ([published report](https://haolingdong-msft.github.io/typespec-assessment-reports/reports/pr-43918/)) | The index records no REST or downstream findings and complete compatibility coverage; the report includes API-version publication, optional additions, and version-scoped `meshProperties` removal metadata | Negative/control case: do not infer a breaking change from an isolated `@removed` decorator or invent breaking cards/source associations when the fresh evidence supports none. Preserve full analysis and independent Guidelines/documentation behavior; with no breaking findings, source-review coverage is not applicable and no per-finding source-review work is fabricated.                                |

These observations explain case selection, not expected verdicts or golden
finding counts. Fresh assessed revisions, versions, and complete evidence
determine the new results. Do not copy published findings or decisions.

Run each through fresh preparation/compilation, deterministic analysis, bounded
Agent judgment including applicable source review, materialization, guarded
finalization, and served-report browser inspection. Old JSON replay or HTML-only
regeneration is not end-to-end validation. Keep separate output directories and
record resolved PR head/target baseline and the implementation revision.

Run all four named validation cases without a performance threshold. A slow
46679/44988 run does not disqualify or cancel either additional case. These
validation runs do not authorize the bulk refresh/publication.
For each completed additional case, show its newly generated report in a
separately titled right-hand browser panel and provide its report URL,
structured-result path, actual end-to-end time, source-review time where
measurable, and retry/cumulative time. Record failures, stalls, unavailable
timings, and blockers in the same validation document under `C:\documents`.
Do not impose a time limit on any of the four PRs.

Validate the source-review paths actually exercised, including Keep, Refine,
Associate, or Unresolved where the fresh evidence requires them; do not weaken
deterministic association or force a finding to manufacture an AI fallback
case. Use focused fixtures for branches not naturally reached by these PRs.

These two named runs are validation cases, not an instruction to refresh or
publish the rest of the site. If a later approved bulk cohort includes either
PR, reuse its validated fresh output only when implementation revision and
comparison provenance still match; do not double-run merely to meet a count.

### Historical performance references and measurement-only policy

Retain the following user-selected historical measurements as reference
baselines, with their methodology limitations intact:

| PR    | Historical baseline                                                                                    | Methodology and limitation                                                                                                                                          |
| ----- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 46679 | 222,525 ms (222.53 seconds, approximately 3 minutes 43 seconds); coordinator 99,402 ms (99.40 seconds) | Fresh preparation and compilation, but compact Agent decisions were reused after canonical model-input hash verification; not a fully fresh Agent-judgment baseline |
| 44988 | Replay wall time 738,260 ms (738.26 seconds, approximately 12 minutes 18 seconds)                      | Frozen-preparation replay without fresh preparation or compilation; not a fresh end-to-end assessment baseline                                                      |
| 44288 | Replay wall time 247,799 ms (247.80 seconds, approximately 4 minutes 8 seconds)                        | Frozen-preparation replay without fresh preparation or compilation; fresh end-to-end execution time is not recorded                                                 |
| 43918 | Replay wall time 160,762 ms (160.76 seconds, approximately 2 minutes 41 seconds)                       | Frozen-preparation replay without fresh preparation or compilation; fresh end-to-end execution time is not recorded                                                 |

Sources: the PR 46679 performance entry in
[reports.json](https://haolingdong-msft.github.io/typespec-assessment-reports/reports.json)
and replay records in
[core-performance.json](https://haolingdong-msft.github.io/typespec-assessment-reports/core-performance.json).
The published `reports.json` also records the replay times and absent fresh
end-to-end measurements for PRs 44288 and 43918.
Preserve the distinction between fresh execution, reused decisions, and replay.
Do not treat these records as methodologically identical or claim speedup
from a direct fresh-versus-replay comparison.

**Current user-directed policy: no performance threshold for any of the four
PRs (46679, 44988, 44288, and 43918).** Record and disclose actual time; do not
grade these runs as performance passes/failures or stop them merely for elapsed
time. This supersedes the earlier 300-second/900-second acceptance limits for
46679/44988. Earlier observed timings and stopped attempts remain historical
records, not active gates for the new implementation.

No relative "no obvious downgrade" threshold is implied either. Compare
methodologically compatible measurements descriptively, not as an undeclared
acceptance condition.

Measure from the assessment coordinator's invocation to successful guarded
finalization producing validated JSON and HTML. Include dependency bootstrap,
fetch/preparation, fresh compilation, deterministic analysis, fresh Agent
judgment and tool waits, guidance retrieval, and materialization. Do not use
only `preparation-manifest.timings.totalMs`, exclude waits, reuse previous
decisions, or replay old compiler evidence to make the timing appear faster. Report
serving/readiness and publication time separately.

Record all failed attempts and retries. If validation requires retries, disclose
both successful-attempt time and cumulative wall time for that PR's validation;
do not silently reset the clock or hide retry gaps.

Complete all four named validations and their report/content checks before any
later bulk refresh, using the implementation revision intended for the batch.
Confirmed breaking findings are not execution failures, but unresolved blockers
preventing complete validation cannot qualify as a content/completeness pass.
Report each PR's outcome independently; one slow or blocked run must not be
silently treated as evidence about the other three.

A long-running stage alone is not a failure. Record stalls, progress, and
available process state; investigate concrete errors or lack of progress rather
than imposing an elapsed-time cutoff. If evidence or execution prevents a
complete report, record the actual outcome and blocker. Stop before bulk refresh
for unresolved content/completeness failures, not timing alone. Do not suppress
evidence or reduce assessment coverage to improve timings.

### Content-gated refresh of the remaining reports

User-directed sequence, updated to include the two additional cases: first
validate PRs 46679, 44988, 44288, and 43918; only after their content/completeness
checks pass, refresh the remaining reports in
[TypeSpec Assessment Reports](https://haolingdong-msft.github.io/typespec-assessment-reports/)
using fresh assessments from the same implemented skill revision. The user
describes this follow-up cohort as "the other 34 PRs."

Before starting the batch, identify and record the site's actual report/PR
inventory and freeze the selected remaining set, excluding the four named
PRs already validated. The requested count of 34 remaining PRs is not a verified
current site inventory. If the site instead has 34 reports in total including
the validation cases, or discovery otherwise yields a different count, report
the discrepancy and confirm the intended collection rather than silently
omitting, adding, or double-running PRs.

Use the same complete workflow as the four named assessments: deterministic
preparation and analysis, bounded Agent judgment with full evidence for
unclassified changes, materialization, and guarded finalization. Use separate
fresh output directories and retain comparison provenance for every PR.
Reuse the newly validated report outputs for their site refresh when
applicable; do not run those PRs again merely to fill the remaining-cohort count.

Refreshing means publishing the newly generated validated JSON and HTML through
the reports repository's existing publication workflow and updating the site's
report index as needed. Merely re-rendering old JSON, changing timestamps,
linking local files, or updating the mockup does not qualify.

Verify the deployed index and each refreshed report URL against the new run's
PR identity and provenance. An assessment with confirmed breaking findings can
still be a successfully completed run; do not equate a compatibility failure
with an execution failure.

Never publish a partial run as a successful refresh. If a PR cannot complete,
record its outcome and remaining blockers, keep any previous report clearly
identified as stale/not refreshed, and report the batch as incomplete. Do not
delete older valid reports or fabricate replacement assessments to reach 34.
If publishing or deployment is blocked, distinguish validated local reports
from reports actually refreshed on the public site.

### Per-PR actual performance and execution record

Measure every selected PR's real execution, including failures, unknowns, and
retries. Do not substitute historical report timings or estimated durations.
Record:

| Area                   | Required actual record                                                                                                                                                                  |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Identity               | PR URL, skill implementation revision, resolved head/base commits, selected API versions, and toolchain versions                                                                        |
| Invocation             | Attempt number, exact command, output directory, start/end timestamps with timezone, and execution outcome                                                                              |
| End-to-end performance | Actual elapsed wall time from invocation through finalization, report-readiness time, and publication/deployment time separately                                                        |
| Phase performance      | Dependency setup/cache reuse, fetch/preparation, compilation, deterministic analysis, Agent judgment/tool waits, guidance retrieval, materialization, and finalization where measurable |
| Agent workload         | Available input/output sizes, token/usage measurements, and evidence reads; unavailable metrics are explicitly `not recorded`, not zero                                                 |
| Result                 | Compatibility verdicts separately from execution status, report/JSON locations, deployment status, and blocker/unknown counts                                                           |
| Attempts               | Failed, interrupted, retried, or stalled attempts and cumulative elapsed time as well as the successful attempt's time                                                                  |

Use process observations and run telemetry to separate active work from waits
where possible. Do not attribute unexplained wall time to compiler or AI work.
Phase intervals may overlap; do not add overlapping intervals as if they were
exclusive durations.

For the proposed source-selection extension, record source-review time,
additional evidence reads, decision counts by outcome, and incremental
input/output usage where measurable. Its Agent/tool time remains inside the
measured end-to-end time; do not hide the added cost in report rendering or
exclude it from the measurement. No performance threshold applies to any of
the four named PRs.

Summarize completion counts, failures, unresolved unknowns, total batch wall
time, and per-PR elapsed-time distribution (mean, median, p95, and range) for
completed runs. State the population and cache/concurrency conditions. List
incomplete attempts separately so fast failures do not make successful-run
performance appear better. Sum of per-PR times is not batch wall time when
runs overlap. Do not invent timing thresholds or claim a speedup without a
comparable measured baseline.

### New validation document under C:\documents

During post-implementation validation, create a new consolidated Markdown
document under `C:\documents`, for example
`C:\documents\typespec-assessment-validation-<run-timestamp>.md`.
Use a new file rather than overwriting an unrelated existing document. Create
it when the four-case validation begins, before any bulk refresh,
and update it as results arrive so interrupted or stopped work still leaves a
persistent record. This design edit does not create that file.

The document contains historical baselines and their limitations, measured
times and execution/content-check outcomes for all four named PRs, the explicit
no-performance-threshold policy, the frozen remaining-report inventory,
per-PR actual execution and performance table, aggregate statistics, publication
results, and the locations of the four reports shown in the right-hand panel.
If content/completeness validation blocks the batch, explicitly record that the
bulk refresh was not started. Timing alone does not block it.

Record every encountered stall, blocker, or unknown/unclassified case, even if
resolved later. Each entry includes:

- PR and attempt, stage, timestamp, and elapsed time at observation;
- affected declaration, contract, candidate, or hunk IDs when available;
- exact error or unknown reason and supporting log/artifact location;
- last observed progress and available process state, distinguishing a
  long-running stage from a confirmed failure or observed lack of progress;
- investigation/retry actions, evidence inspected, resolution, and final status;
  and
- whether the case prevents assessment completion or publication.

Do not turn unknown evidence into a pass or conceal failed attempts behind a
later successful run. Keep secrets and account data out of the document.
Return the absolute document path with the batch outcome and updated public
site link. If the requested directory is inaccessible, report that blocker
rather than silently saving the final document somewhere else.

Do not run these assessments solely to create or revise the design document.
The user explicitly selected execution after approval and implementation.
That approval gate also applies to reference validation, the subsequent
content-gated report refresh, publishing, and creation of the validation
document under `C:\documents`.

## 11. Approval gate

The user explicitly approved the baseline refactor implementation. The
implementation must preserve the evidence and validation requirements above,
distinguish policy changes from behavior-preserving refactoring, and complete
the four named content/completeness validations before any bulk report refresh.
No performance threshold applies to those four PRs.

The AI-assisted source-selection extension is recorded at the user's request
for design review only. Its implementation, schema/instruction updates,
assessment runs, report regeneration, performance validation, and publication
are not authorized by this design update. Current execution instructions remain
unchanged until implementation is separately approved.
