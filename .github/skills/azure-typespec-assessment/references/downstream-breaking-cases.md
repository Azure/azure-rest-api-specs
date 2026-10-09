# Downstream SDK Breaking Cases

Review candidate evidence first; explain confirmed impacts using the
method-first report layout. A candidate, a finding, a changed type, and an
affected method are different units.

## 1. Read the bounded input

1. Read `context.projects[].artifactComparison` for the baseline/target API
   versions and source revisions. Do not assume array order identifies sides.
2. For each `downstreamCandidates` entry, retain its `id`, `rule`,
   `crossLanguageDefinitionId`, `evidenceFactIds`, and `rootCauseIds`.
   `reviewRequired`, `defaultSeverity`, and generated `actual`/`expected` text
   describe a potential change, not a confirmed incompatibility.
3. Read the referenced `facts` by `comparisonRole` and `factKind`. When compact
   facts omit necessary details, resolve `evidenceSetId` through `evidenceSets`
   and the declared `artifactReferences` to the canonical candidate, facts,
   declarations, and source hunks. Older inputs may embed source evidence.
4. Read linked `downstreamRootCauses` for method/type facts and reference edges.
   Root labels are not verdicts: `method-return-propagation` also groups
   parameter, client, and customization candidates.

Use normalized TCGC evidence and changed customization decorators, independently
of REST compatibility. Never infer SDK behavior from REST findings or prior
reports. Use cross-language IDs, scoped by project, with guarded fallback
identities only when needed.

## 2. Judge each candidate

Apply the [candidate rules](downstream-candidate-rules.md), including
compatibility exceptions. Require an existing public or public-method-reachable
contract and a source-linked cause; project-wide source membership alone does
not establish causality.

Return exactly one `downstreamDecisions` entry per supplied candidate, including
validated inferred candidates when present:

- `approve`: retain the finding; provide severity and rationale.
- `reject`: explain compatibility or insufficient causal evidence; omit severity.

Use only `candidateId`, `decision`, `severity` when approved, and `rationale`.
Do not add UI fields, candidates, or affected-method claims to this schema.
Assembly restores facts and links. Preserve supported blockers; rejection is
not proof of complete coverage.

Write rationale as **concrete before/after change -> existing SDK use affected
-> consequence** in one or two short sentences, normally at most 40 words.
Name the changed method, type, or member so the explanation stands alone.
State what existing callers must change; retain qualifications such as
language-dependent positional arguments. Omit evidence IDs, compiler metadata,
repeated source history, and defenses against unrelated exceptions: those belong
in linked evidence, not the explanation. Do not merely repeat the rule name or
claim every language generates the same signature.

## 3. Trace direct and indirect method impact

- **Direct:** method facts establish a changed method contract.
- **Via SDK type:** follow `referenceEvidence` from a method fact through
  parameter, response, paging-item, or LRO-result and wrapper/type edges.
  Its top-level signature need not change.
- **Mixed:** retain both causes for the same method.

Keep each path's method, project, comparison role, and location together.
Never assign a root's union of locations to every method. Use baseline paths
for removed types when supplied; do not label baseline evidence as target.
Paths are retained evidence, not necessarily an exhaustive graph.

No method path means mapping unavailable, not automatically no breaking
change. Retain independently justified public type/client/customization
findings without inventing methods from names, files, or REST operations.

## 4. Explain results in the method-first layout

Presentation follows judgment; it must not reclassify evidence.

- One card per distinct mapped SDK method, merging direct and indirect causes.
  Show a concise cause and related Semantic intent links while collapsed.
- Keep "Why this is breaking" brief: one self-contained explanation per distinct
  consequence, shown separately when several apply. Do not concatenate long
  judgment paragraphs or truncate away the caller impact.
- Use the target method name when available; preserve baseline names in the
  comparison. Do not strip suffixes heuristically.
- Direct rows compare normalized inputs, return type, invocation kind,
  paging/LRO behavior, or availability. Label path/query/header/body positions
  only from unambiguous evidence. Constant headers are not numbered caller
  inputs; client-owned parameters are not ordinary method arguments.
- Nested type causes show per-method input/output location and member path,
  evidence side, concrete before/after member or shape, and consequence.
  Use a fallback card when mapping is unavailable.
- Keep finding, mapped-method, and changed-type counts distinct. Show no
  affected REST operations or fabricated language-specific signatures.
