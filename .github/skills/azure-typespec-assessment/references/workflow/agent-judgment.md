# Bounded Agent Judgment

When preparation prints `awaiting-agent-judgment`, continue immediately without
a progress stop or another user turn.

Read `<work-directory>\agent-workspace\agent-index.json` once. It identifies
the single bounded model input, required outputs, drafts, exact coverage IDs,
and completion checklist. Read `model-input.json` exactly once unless guarded
finalization requests the one permitted correction turn.

If the host transports the result through a saved output buffer, continue
reading that exact tool-reported buffer in ranges. It is the same bounded input
read, even when the buffer is outside the repository. Do not list temporary
directories, read unrelated buffers, or reread the canonical input.

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
- the [official document catalog](../reference-document-links.md);
- the [documentation checks](../document-quality.md).

Do not recursively list the work directory, broadly search report artifacts,
inspect raw compiler output, or repeatedly read schemas and canonical inputs.
Use `agent-workspace\agent-decisions.draft.json` only as the structural
template. Its compliance judgments prefill eligible intent-scoped qualified
`declarationNames`; retain only names supporting each judgment. Never copy its
intentionally invalid unresolved placeholders into the completed file.

Never reinterpret separate downstream additions and removals as a rename or
replacement. Use only the candidate's supplied identity evidence; unresolved
or ambiguous identity remains blocked.

If `inferenceRequests` is empty, omit `inferenceResults`. Otherwise, analyze
only supplied unknown hunks and write one exact compact result per request to
`agent-workspace\agent-decisions.json`. Each is `candidates`, `no-impact`, or
`blocked`. Inferred candidates may use only the request's source, hunk,
operations, facts, and allowed dimensions. Never modify `model-input.json`.
A new API version does not exempt supplied REST candidates from judgment.
Describe confirmed impacts as cross-version migration incompatibilities, not
as regressions to an unchanged version selector. Preserve blockers for missing,
unresolved, or ambiguous contract evidence.

The compact decision file must contain one concise result per supplied Semantic
review unit and exact deterministic and inferred REST/downstream candidate
coverage. Write one Azure Guidelines decision per supplied compliance search
request. When there are no compliance search requests, leave catalog scores,
retrieval results, search blockers, and compliance judgments empty. Do not read
raw AutoRest/TCGC output, compiler logs, unrelated unchanged source, prior
answers, or use catalog descriptions as guidance. Candidate and review-unit
evidence omitted from the bounded input is available only through declared
canonical artifact references; do not scan unrelated artifact entries.

For `pipelineVersion: 2`, use schema-version-2 Agent decisions without
`sourceReviews`. This phase judges compatibility, not display-source completion.
After materialization, follow [source association](source-association.md) in a
separate AI context, covering accepted findings only.

The following source-review instructions apply only to historical single-phase
inputs. Write exactly one `sourceReviews` entry for every deterministic or inferred
REST/downstream candidate decision. The goal is the complete minimal relevant
TypeSpec code set: enough canonical declarations to understand the breaking
change, without isolated contextless lines or unrelated surrounding changes.

- `keep`: preserve the supplied deterministic declaration set exactly;
- `refine`: replace an existing deterministic set with a clearer bounded set;
- `associate`: select bounded canonical declarations when deterministic
  association is missing;
- `unresolved`: approve the finding but explicitly record that relevant source
  could not be established;
- `not-applicable`: required for every rejected candidate.

Select declaration IDs only from the candidate's supplied
`availableDeclarations`. For inferred candidates, use only declarations owned
by the inference request's source and hunk. Never copy, rewrite, or fabricate
TypeSpec text. The deterministic materializer resolves selected IDs back to
canonical source locations and rejects incomplete, duplicate, or out-of-bound
coverage.

Treat every supplied Semantic review-unit ID and boundary as authoritative.
Never merge, split, reorder ownership, or move source hunks, declarations,
change facts, or operations between units. Mixed version-publication and
feature evidence has already been separated by the coordinator; ambiguous
facts remain explicit rather than being assigned by similarity. Coarse normal
groups may retain mixed-source notices; do not regroup them in either AI phase.

Documentation Completeness is assembled deterministically from
`dimensions/document-quality-input.json`. The Agent neither reads that artifact
nor authors documentation decisions.

Continue with the
[Azure Guidelines search and materialization](compliance-and-materialization.md).
