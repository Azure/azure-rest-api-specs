<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-29
     Derived from:
       - Patterns observed across multi-year ARM API review history
       - Reviewer Step 3.5 deliverables (resource / operation / sensitive-data-flow / version-delta graphs)
       - Critic graph-diff re-derivation (independent verifier)
     This file is repo-owned. No external dependencies. -->

# Think in Graphs Before Lists

This reference explains **why** the ARM API Reviewer agent's
[Step 3.5 (API Graph & Data-Flow Analysis)](../../../agents/arm-api-reviewer.agent.md#step-35-api-graph--data-flow-analysis-think-in-graphs-before-lists)
requires Mermaid graph artifacts as a deliverable -- not as decoration, but
as a structural reasoning aid that changes what the rule-scan passes
notice next.

## Why graphs, not lists

Linear file-by-file, rule-by-rule scanning is good at catching local
violations (a missing description, a wrong enum, an inconsistent
casing). It is reliably bad at catching **systemic** problems that only
emerge when the API is viewed as a directed graph:

- Orphaned resources (defined but unreachable from any operation).
- Unreachable operations (defined but never linked from a parent's
  routing tree).
- Asymmetric CRUD (PUT without GET, GET without LIST, LIST without
  paging, DELETE-only).
- `$ref` cycles that compile but break SDK generators.
- Secret-bearing properties that flow into LIST responses (a request
  body that accepts a credential but a list endpoint that returns it).
- Identity / trust boundaries that do not line up with auth scopes (an
  operation declared at one ARM scope but referring to resources at a
  different scope).
- Paging-shape inconsistencies across sibling collection operations on
  the same RP.
- Silent breaking changes: a model is still defined but no operation
  references it anymore -- SDK generators emit from references, not
  definitions, so the removal is invisible to "did anything disappear"
  diffs but very visible to customers who already shipped code against
  the prior SDK.

Forcing the model to construct the graph **before** the rule scan
changes the rule scan. The graph nodes and edges expose adjacency that a
linear pass does not see. Mental scaffolding alone is too easy to skip
or to fake; producing the graph as an artifact makes the scaffolding
auditable.

## Why graphs as artifacts (not just internal scratchpads)

Two reasons.

1. **The Critic re-derives the graphs independently.** A graph-diff
   between the Reviewer's Mermaid and the Critic's freshly-derived
   Mermaid is the highest-signal missed-violation detector the
   verification loop has. A node the Reviewer omitted, an edge the
   Reviewer drew incorrectly, or a subgraph that disagrees on cardinality
   between the two passes is almost always a real finding. Internal
   reasoning the Reviewer never wrote down cannot be diffed.

2. **The deliverable forces honesty.** A model that promises "I will
   think structurally" and then writes only a flat finding list has
   skipped the work. A model that must emit a `graph TD` with N labeled
   nodes and M typed edges cannot fake the structural pass.

## The four required views

For every PR that touches `.tsp` or resource-manager `.json`, the
Reviewer constructs four views. The first three are rendered as Mermaid
diagrams; the fourth is rendered only when a previous version exists.

1. **Resource graph** (`graph TD`).
   Nodes = every resource type touched by the PR (tracked, proxy,
   extension, singleton). Edges = parent/child containment, extension
   relationships, and cross-resource `$ref`s. Each node is marked with
   scope (tenant / subscription / resourceGroup / extension), lifecycle
   (tracked / proxy), and the PR's effect on it (added, modified, or
   examples-only).

2. **Operation graph** (`graph LR`).
   For every resource, the operations it exposes: Create / Update / Get
   / List / Delete and POST actions. Asymmetries are flagged: PUT
   without GET, GET without LIST, LIST without paging, DELETE-only, POST
   actions that mutate state but return 200 instead of LRO, child
   operations whose parent has no GET. Operations are nodes; resources
   are subgraphs.

3. **Sensitive-data-flow graph** (`flowchart LR`).
   For every property typed as a secret, credential, key, connection
   string, token, password, certificate, or anything matching
   `SEC-SECRET-DETECT` heuristics: where the property is accepted
   (request bodies), where it is returned (response bodies, including
   LIST), whether it flows into ARG-projected properties, and whether it
   appears in examples. A secret that enters via PUT and leaks via LIST
   is a far worse finding than either property considered in isolation.

4. **Version-delta graph** (`graph TD`, previous-version-exists only).
   Overlay the previous-version resource and operation graph on the new
   one. Edge styles distinguish added / removed / changed. This is what
   feeds the breaking-change findings, but rendered as a graph diff to
   surface removed-via-reference-chain breaks (e.g., a model still
   exists but no operation references it anymore -- a silent breaking
   change for SDK consumers).

## Findings that only emerge from the graph view

These are the structural findings the agent should expect to discover
through Step 3.5 -- they are very difficult to surface otherwise:

- A property defined and serialized but unreachable from any operation
  response (dead schema).
- A resource with PUT but no GET, or LIST but no per-item GET
  (incomplete shape).
- A secret property reachable from a LIST response (anchor:
  `SEC-SECRET-DETECT` + ARM no-secrets-in-list).
- A `$ref` cycle that compiles but breaks SDK generators.
- A child resource whose parent path was removed or renamed in this PR
  (orphan).
- A POST action that returns synchronously but mutates a tracked
  resource's state (should be LRO).
- Paging shape (`x-ms-pageable.nextLinkName`) inconsistent across
  sibling collection operations on the same RP (SDK confusion).
- Identity / scope mismatch: an operation typed against `subscriptionId`
  scope that references a resourceGroup-scoped resource, or vice versa.

Each of these is filed as a normal finding in the Reviewer's Step 6
report, tagging the rule ID from the relevant instruction file (or the
section name when no explicit ID exists). The graphs are **both** the
means (to discover the structural problem) and the deliverable (so the
Critic can independently diff them).

## Rendering rules

- Render each graph inside a collapsible `<details>` block in the
  Step 6 chat report so the diagrams do not dominate the chat surface.
- Keep diagrams small. If the resource graph exceeds ~25 nodes,
  partition by `Microsoft.{Namespace}` into multiple diagrams. If the
  operation graph exceeds ~40 operations, partition by resource
  subgraph. The graphs are read by humans and re-parsed by the Critic;
  bloat defeats both purposes.
- Mermaid renders correctly in chat surfaces (VS Code, github.com PR
  description) but **not inside `<details>` blocks on github.com PR
  comments** -- the diagram code shows as raw text. Graphs are
  therefore chat-only deliverables. When summarizing a graph-derived
  finding in a posted PR comment, include only the node/edge counts and
  the specific structural conclusion (e.g., "`accessKey` reachable via
  LIST response of `Foo_List`"), not the full Mermaid block.

## Size guardrail: when to downgrade rendering

Partitioning keeps each diagram readable, but on extreme-scale RPs
(SQL-scale, ~146 resources) even the post-partition totals overwhelm
the chat surface and dominate the Critic's re-derivation budget. When
**any** of the following thresholds is exceeded after applying the
partition rules above, the Reviewer **MUST** downgrade rendering for
the affected view to summary-text mode:

| View                | Downgrade threshold (post-partition)                                        |
| ------------------- | --------------------------------------------------------------------------- |
| Resource graph      | > 75 nodes total across all partitions                                      |
| Operation graph     | > 200 operations total across all partitions                                |
| Sensitive-data-flow | > 50 secret-bearing nodes                                                   |
| Version-delta       | Downgrade independently when either side trips the resource-graph threshold |

Why these numbers: the partition thresholds (25 / 40) keep one diagram
readable; the downgrade thresholds (~3× and ~5× the partition limits)
are the point at which the **collection** of partitions stops being
useful. Sampling 10 representative RPs in mid-2026, only **SQL** trips
the resource-graph threshold; **Network** sits at the edge; all others
are comfortably clear. The guardrail is designed to fire on ~1-2 RPs
repo-wide.

In summary-text mode the Reviewer:

- Omits the Mermaid block for the downgraded view(s).
- Renders a one-line node / edge inventory in its place (e.g.,
  `Resource graph: 146 nodes, 198 edges across 4 namespace partitions`).
- Still produces every structural finding derived from the in-memory
  graph; each finding body carries
  `Source: structural-analysis (graph downgraded)` so the human sees
  that the analysis was performed.
- Sets `graphs-produced: downgraded` in Critic Input #9.

Under `downgraded`, the Critic still independently re-derives the
sensitive-data-flow view in summary form (rendering cost is irrelevant
to secret-leak analysis) but skips the resource and operation views.
The Critic records `Graph integrity = N/A` for rendered-diff purposes
and surfaces any new secret-bearing LIST-response findings as advisory
`Likely missed violations`.

Downgrading is a rendering decision, not an analysis skip.

## When graph derivation fails on a full-review PR

Full-review PRs are required to produce graphs; graph-derived findings
are findings nothing else catches. When derivation fails -- usually a
context-budget overrun on a very large spec, occasionally a `$ref`
resolver failure -- the Reviewer follows a three-step fallback ladder
defined in [`arm-api-reviewer.agent.md` → Step 3.5 "Failure
recovery"](../../../agents/arm-api-reviewer.agent.md#step-35-api-graph--data-flow-analysis-think-in-graphs-before-lists):

1. **Retry with smaller scope** (per-namespace partitioning, then
   merge). Default; most failures resolve here.
2. **Continue with `graphs-produced: degraded`**, render the required
   `[!CAUTION]` failure banner at the top of the Step 6 report, and
   proceed. The Critic records `Graph integrity = N/A` but is required
   to flag the missing banner as `missing-step35-banner` if the
   Reviewer suppresses it.
3. **Abort** only on explicit human direction (e.g., the PR touches
   secret-bearing properties where Step 3.5 is the primary detection
   mechanism).

`graphs-produced: degraded` is **distinct** from `false` (which is
reserved for fast-path-by-design and is silent). `degraded` is never
silent: the banner makes the missing analysis visible to every human
reading the report.

## When this step is skipped

Step 3.5 is **skipped on the fast-path track** (examples-only PRs,
description-only edits, non-AutoRest readme edits). In that case the
Reviewer MUST tell the Critic via Input #9 (`graphs-produced: false`),
and the Critic records `Graph integrity = N/A` instead of attempting to
diff against absent graphs. Step 3.5 is **never** skipped on the
full-review track; on extreme-scale full-review PRs use the
`downgraded` mode above, and on derivation failure use the `degraded`
mode (see "When graph derivation fails on a full-review PR" above)
rather than skipping silently.
