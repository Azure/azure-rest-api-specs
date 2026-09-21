# Bounded Agent Judgment

When preparation prints `awaiting-agent-judgment`, continue immediately without
a progress stop or another user turn.

Read `<work-directory>\agent-workspace\agent-index.json` once. It identifies
the single bounded model input, required outputs, drafts, exact coverage IDs,
and completion checklist. Read `model-input.json` exactly once unless guarded
finalization requests the one permitted correction turn.

`api-version-publication` and `api-version-wide-change` are excluded from Agent
coverage. Guarded finalization restores them as deterministic informational
Semantic intents with canonical affected operations and no finding
relationships. Version-wide classification uses `Versions` declaration and
version-transition/governance evidence, never an operation-count threshold.

Also read only:

- [classification guidance](../classification.md), including
  [downstream cases](../downstream-breaking-cases.md) and
  [candidate rules](../downstream-candidate-rules.md);
- the [agentic search procedure](../agentic-search.md);
- the [official document catalog](../reference-document-links.md) when targeted
  discovery or missing canonical metadata requires it;
- the [documentation checks](../document-quality.md).

Do not recursively list the work directory, broadly search report artifacts,
inspect raw compiler output, or repeatedly read schemas and canonical inputs.
Use `agent-workspace\agent-decisions.draft.json` only as the structural
template. Its compliance judgments prefill eligible intent-scoped qualified
`declarationNames`; retain only names supporting each judgment. Never copy its
intentionally invalid unresolved placeholders into the completed file.

If `inferenceRequests` is empty, omit `inferenceResults`. Otherwise, analyze
only supplied unknown hunks and write one exact compact result per request to
`agent-workspace\agent-decisions.json`. Each is `candidates`, `no-impact`, or
`blocked`. Inferred candidates may use only the request's source, hunk,
operations, facts, and allowed dimensions. Never modify `model-input.json`.

The compact decision file must contain one concise result per supplied Semantic
review unit and exact deterministic and inferred REST/downstream candidate
coverage. Write one Azure Guidelines decision per supplied compliance search
request. Treat category tags and required routing as immutable. Complete
discovery gaps, retrieve or reuse required documents, and record the documents
actually reviewed for each intent. Batch independent scoped evidence reads and
When there are no compliance search
requests, leave discovery results, retrieval results, search blockers, and
compliance judgments empty. Do not read
raw AutoRest/TCGC output, compiler logs, unrelated unchanged source, prior
answers, or use catalog descriptions as guidance. Candidate and review-unit
evidence omitted from the bounded input is available only through declared
canonical artifact references; do not scan unrelated artifact entries.

Documentation Completeness is assembled deterministically from
`dimensions/document-quality-input.json`. The Agent neither reads that artifact
nor authors documentation decisions.

Continue with the
[Azure Guidelines search and materialization](compliance-and-materialization.md).
