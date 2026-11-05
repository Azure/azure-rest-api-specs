# Assessment Skill Refactor Design

**Status: Approved; implementation in progress.**

This document defines the approved simpler implementation and report layout for
`azure-typespec-assessment`.

The [existing design](design.md) describes the current system. This proposal
does not replace that document or change the current skill instructions.

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

| Dimension | Evidence and responsibility |
| --- | --- |
| Semantic intents | Compiler-backed changed TypeSpec source and deterministic grouping |
| REST compatibility | AutoRest wire-contract comparison |
| Downstream SDK compatibility | Language-neutral TCGC public-contract comparison |
| Azure Guidelines | Fetched official guidance assessed against Semantic intents |
| Documentation Completeness | Compiler-resolved effective-document presence |

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

| Area | Current concern | Proposed boundary |
| --- | --- | --- |
| `run-assessment-analysis.ts` | Coordinates execution and also compacts facts, classifies hunk coverage, selects inference, and accounts for input budgets | Coordinator owns stage order; bounded-input construction owns those related calculations |
| Assembly and rendering | Both derive presentation-oriented contracts and groups | Derive the report projection once, then render it without re-analysis |
| Downstream presentation | Direct method changes and propagated model changes are combined into method-first cards | Present direct method changes and model/type changes separately |
| Runtime compatibility | Current and historical shapes are handled in multiple places | Normalize historical report inputs at an explicit boundary |
| `docs/design.md` | Architecture, schemas, historical rules, examples, and layout instructions overlap | Keep current architecture concise and delegate detailed contracts to their authoritative references |

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
Final report cards still show only deterministically associated relevant code;
complete evidence remains available for analysis and audit.

### Agent judgment and materialization

The Agent owns summaries and compatibility/guidance decisions, not identities,
group membership, operation mappings, or evidence relationships. This includes
review of declared unclassified changes using the complete evidence above,
not unrestricted discovery outside the assessment scope.

Keep one compact decision artifact. Materialization validates exact decision
coverage, resolves canonical identities, and writes the existing materialized
artifacts. It does not fetch guidance or make compatibility judgments.

### Finalization

Own final findings, reciprocal relationships, statuses, counts, validation,
and the report projection. Preserve artifact-integrity checks and independent
final-result validation.

The renderer consumes prepared display data. It escapes values and emits HTML;
it does not rediscover changes, infer causality, or reconstruct Semantic groups.

## 5. Data ownership and presentation boundary

Keep the current serialized assessment and evidence contracts unless an
explicit schema change is approved. The simpler report projection is internal;
do not add another persisted artifact or public output format solely for HTML.

| Data | Single owner |
| --- | --- |
| Hunk/declaration ownership and Semantic group boundaries | Semantic analysis |
| Wire and SDK contract facts and candidates | Their respective analyzers |
| Candidate approval and rationale | Agent judgment |
| Canonical finding/evidence joins | Materialization and final assembly |
| Semantic/finding relationships | Deterministic final assembly |
| Changed-only display rows and card grouping | Report projection |
| HTML structure, escaping, and disclosure behavior | Renderer |

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

| Section | Category | Content |
| --- | --- | --- |
| REST | Operation changes | Direct changes to operation identity, method/path, parameters, request contract, responses, paging, or LRO behavior |
| REST | Model/schema changes | Changed named wire types, members, enum values, requiredness, or constraints |
| Downstream SDK | Method changes | Direct public method identity, owner, parameters, response type, kind, access, paging, or LRO changes |
| Downstream SDK | Model/type changes | Public model, enum, union, or other type-contract changes |

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

Select snippets in the deterministic report projection using finding-specific
declaration, member, hunk, and compiler evidence. Project-wide source metadata
or a shared Semantic intent alone does not establish finding-specific relevance.
The Agent and renderer must not invent or choose causal source mappings.

For model/type cards, select the changed members and their relevant declaration
prefixes. For operation/method cards, select the changed operation signature,
decorators, or proven supporting helper change. A card containing multiple
findings uses the union of their supported source ranges, deduplicated without
expanding to unrelated declarations.

Hunk selection is not sufficient when one Git hunk includes several unrelated
declarations. Narrow within the hunk using baseline/current declaration spans
and actual changed lines:

- retain relevant changed code and its attached decorators, including version,
  visibility, constraint, rename, and removal metadata;
- retain one surrounding context line by default, extending only to preserve
  an understandable enclosing declaration or multiline construct;
- omit unrelated documentation and comments from the display, but preserve
  them when their changes are relevant evidence; do not blindly delete all
  `@doc` or comment lines;
- preserve original file, revision, and line provenance; and
- show explicit omission markers or separate snippets for discontinuous ranges
  rather than presenting them as one continuous original diff.

Do not impose a fixed line cap that silently hides relevant changes. If exact
source association is unavailable or ambiguous, keep the finding and state
`Relevant TypeSpec source could not be established`; do not substitute all
project changes or an unrelated representative example.

For PR 46679, the RoleAssignment card should show the changes to `roleName`
and `entities`, including relevant versioning decorators, rather than the
enclosing intent's 11 hunks and 239 diff lines. The inspected mockup already
selects a single 23-line source hunk and trims unrelated context; production
selection must derive relevance from evidence, not hard-coded example data.

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

| Question | Proposed treatment |
| --- | --- |
| New-version REST rules retain substantive differences, but the Network example demands no REST findings for the transition | Establish the authoritative policy and expected examples before changing either |
| Documentation v5 checks compiler presence, while later examples describe legacy prose decisions | Distinguish current presence checks from historical replay contracts |
| Some report sections count grouped cards and others count underlying findings | Use finding counts for summaries and separately labeled card counts |
| Historical rendering branches contribute substantial complexity | Preserve support through boundary adaptation; assess supported shapes before extraction |
| The mockup includes coverage badges and asserted REST/SDK causal links | Do not adopt them as required card behavior or evidence rules |
| Existing unknown-hunk inference may not represent every unclassified contract change | Specify evidence access, accounting, and any required inference/decision contract extension before implementing complete-evidence review |

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
7. Validate PRs 46679 and 44988 against the user-defined performance limits,
   show their reports, and refresh the remaining report collection only after
   both pass the validation gate below.

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

### Validation after implementation approval

Use existing focused tests and type checks for the changed modules. Replay
retained current and historical assessment artifacts. Inspect the rendered cards
for property-only, direct method, removal, empty, and blocked cases.

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

For PR 46679, inspect the RoleAssignment model/type card: show only its relevant
property changes and decorators, not all hunks from the enclosing intent.
For PR 44988, inspect the Service Gateway direct method-change cards and their
relevant TypeSpec source. Check changed-only Before/After values, source
disclosures, and preserved finding/intent links against the approved design.
Do not force findings or compatibility verdicts to match the mockup; judgment
must follow the run's evidence and the approved compatibility policy.

### Historical performance baselines and reference-PR gate

Retain the following user-selected historical measurements as reference
baselines, with their methodology limitations intact:

| PR | Historical baseline | Methodology and limitation |
| --- | --- | --- |
| 46679 | 222,525 ms (222.53 seconds, approximately 3 minutes 43 seconds); coordinator 99,402 ms (99.40 seconds) | Fresh preparation and compilation, but compact Agent decisions were reused after canonical model-input hash verification; not a fully fresh Agent-judgment baseline |
| 44988 | Replay wall time 738,260 ms (738.26 seconds, approximately 12 minutes 18 seconds) | Frozen-preparation replay without fresh preparation or compilation; not a fresh end-to-end assessment baseline |

Sources: the PR 46679 performance entry in
[reports.json](https://haolingdong-msft.github.io/typespec-assessment-reports/reports.json)
and the PR 44988 replay record in
[core-performance.json](https://haolingdong-msft.github.io/typespec-assessment-reports/core-performance.json).
Preserve the distinction between fresh execution, reused decisions, and replay.
Do not treat these two records as methodologically identical or claim speedup
from a direct fresh-versus-replay comparison.

The user defined explicit acceptance limits instead of an unspecified
"no obvious downgrade" criterion:

| Reference PR | Maximum actual end-to-end assessment wall time |
| --- | --- |
| 46679 | 300,000 ms (5 minutes), inclusive |
| 44988 | 900,000 ms (15 minutes), inclusive |

Measure from the assessment coordinator's invocation to successful guarded
finalization producing validated JSON and HTML. Include dependency bootstrap,
fetch/preparation, fresh compilation, deterministic analysis, fresh Agent
judgment and tool waits, guidance retrieval, and materialization. Do not use
only `preparation-manifest.timings.totalMs`, exclude waits, reuse previous
decisions, or replay old compiler evidence to satisfy these limits. Report
serving/readiness and publication time separately.

Record all failed attempts and retries. If validation requires retries, disclose
both successful-attempt time and cumulative wall time for that PR's validation;
do not silently reset the clock and claim the overall validation met its limit.
Use cumulative elapsed time for the gate when retries are part of the run.

Run these two reference validations before starting assessments or publication
for the remaining cohort. Both must complete, pass the report/content checks,
and meet their respective time limits on the implementation revision used for
the batch. Confirmed breaking findings are not execution failures, but unresolved
blockers preventing complete validation cannot qualify as a pass.

If either PR exceeds its limit or cannot be validated, stop before the bulk
refresh, document the observed bottleneck/blocker, and investigate within the
approved scope. Revalidate the two reference PRs after performance-relevant
implementation changes; do not bypass the gate by suppressing evidence or
reducing assessment coverage.

### Performance-gated refresh of the remaining reports

User-directed sequence: first validate PRs 46679 and 44988; only after both pass
the gate, refresh the remaining reports in
[TypeSpec Assessment Reports](https://haolingdong-msft.github.io/typespec-assessment-reports/)
using fresh assessments from the same implemented skill revision. The user
describes this follow-up cohort as "the other 34 PRs."

Before starting the batch, identify and record the site's actual report/PR
inventory and freeze the selected remaining set, excluding the two reference
PRs already validated. The requested count of 34 remaining PRs is not a verified
current site inventory. If the site instead has 34 reports in total including
the two references, or discovery otherwise yields a different count, report
the discrepancy and confirm the intended collection rather than silently
omitting, adding, or double-running PRs.

Use the same complete workflow as the two reference assessments: deterministic
preparation and analysis, bounded Agent judgment with full evidence for
unclassified changes, materialization, and guarded finalization. Use separate
fresh output directories and retain comparison provenance for every PR.
Reuse the newly validated reference report outputs for their site refresh when
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

| Area | Required actual record |
| --- | --- |
| Identity | PR URL, skill implementation revision, resolved head/base commits, selected API versions, and toolchain versions |
| Invocation | Attempt number, exact command, output directory, start/end timestamps with timezone, and execution outcome |
| End-to-end performance | Actual elapsed wall time from invocation through finalization, report-readiness time, and publication/deployment time separately |
| Phase performance | Dependency setup/cache reuse, fetch/preparation, compilation, deterministic analysis, Agent judgment/tool waits, guidance retrieval, materialization, and finalization where measurable |
| Agent workload | Available input/output sizes, token/usage measurements, and evidence reads; unavailable metrics are explicitly `not recorded`, not zero |
| Result | Compatibility verdicts separately from execution status, report/JSON locations, deployment status, and blocker/unknown counts |
| Attempts | Failed, interrupted, retried, or stalled attempts and cumulative elapsed time as well as the successful attempt's time |

Use process observations and run telemetry to separate active work from waits
where possible. Do not attribute unexplained wall time to compiler or AI work.
Phase intervals may overlap; do not add overlapping intervals as if they were
exclusive durations.

Summarize completion counts, failures, unresolved unknowns, total batch wall
time, and per-PR elapsed-time distribution (mean, median, p95, and range) for
completed runs. State the population and cache/concurrency conditions. List
incomplete attempts separately so fast failures do not make successful-run
performance appear better. Sum of per-PR times is not batch wall time when
runs overlap. Apply the explicit 5-minute/15-minute gate to the reference PRs;
do not invent thresholds for other PRs or claim a speedup without a comparable
measured baseline.

### New validation document under C:\documents

During post-implementation validation, create a new consolidated Markdown
document under `C:\documents`, for example
`C:\documents\typespec-assessment-validation-<run-timestamp>.md`.
Use a new file rather than overwriting an unrelated existing document. Create
it when the two reference validations begin, before the bulk-refresh gate,
and update it as results arrive so interrupted or stopped work still leaves a
persistent record. This design edit does not create that file.

The document contains both historical baselines and their limitations, measured
reference-run times and gate results, the frozen remaining-report inventory,
per-PR actual execution and performance table, aggregate statistics, publication
results, and the locations of the two reference reports shown in the right-hand
panel. If the gate fails, explicitly record that the bulk refresh was not started.

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
performance-gated report refresh, publishing, and creation of the validation
document under `C:\documents`.

## 11. Approval gate

The user explicitly approved implementation. The implementation must preserve
the evidence and validation requirements above, distinguish policy changes
from behavior-preserving refactoring, and complete the staged reference-PR
performance gate before any bulk report refresh.
