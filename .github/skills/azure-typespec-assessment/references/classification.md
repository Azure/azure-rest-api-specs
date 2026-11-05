# Bounded Judgment Classification

The deterministic scripts identify review units, facts, and candidates. The Agent interprets them; it does not discover additional changes.

## Evidence boundaries

| Dimension  | Allowed evidence                                                                                                         | Judgment                                                                                                                 |
| ---------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| Semantic   | Compact changed-construct profile, representative source excerpts, and aggregate operation signals in `model-input.json` | Produce one concise intent-level title and summary. Do not analyze every operation.                                      |
| REST       | AutoRest wire-contract candidate facts                                                                                   | Approve only when the current wire contract can invalidate an existing caller or response consumer; otherwise reject.    |
| Downstream | TCGC SDK-surface candidate facts and changed customization decorators                                                    | Approve only when language-neutral generated public/runtime SDK behavior can break existing SDK users; otherwise reject. |

REST and downstream decisions are independent. A REST-compatible change can still break generated SDK users. Never use TCGC to classify REST compatibility or AutoRest to infer SDK surface.

## Decision rules

For every candidate, compare its `actual` current behavior with its `expected` compatibility behavior and explain the caller-visible consequence.

For REST candidates, removing any previously accepted or documented serialized
value from an existing query parameter, request header, or response header is a
breaking narrowing and must be approved. Compare the exact before/after wire
value sets. Do not reject the candidate merely because the outer schema remains
an optional string, string enum, array, or CSV collection, or because its
location, requiredness, and collection format are unchanged.

- `approve`: supplied facts establish the incompatibility. Include severity.
- `reject`: facts show additive/compatible behavior, no public/runtime impact, or insufficient causal evidence. Do not include a severity.
- Preserve exact candidate IDs. Never add a finding, source, operation, SDK symbol, or fact.

Use the candidate's default severity as a starting point, then apply:

| Severity | Meaning                                                                                                     |
| -------- | ----------------------------------------------------------------------------------------------------------- |
| `high`   | Existing requests, responses, or common generated-code use can fail or become invalid without migration.    |
| `medium` | A public behavior or SDK shape requires a meaningful consumer change but impact is narrower or conditional. |
| `low`    | Compatibility impact is real but constrained to uncommon paths, metadata, or specialized consumers.         |

## Semantic and confidence rules

Produce exactly one title and summary per semantic review unit. Do not return
operation or source IDs; deterministic assembly restores the complete
inventory. Describe version propagation explicitly when that is the unit's
change kind.

For resource-oriented REST APIs, identify the affected resource and lifecycle
role, not just the HTTP verb and route. Use supplied TypeSpec declarations,
template applications, and decorator evidence: `TypeSpec.Rest` associates
resources with create, read, update, delete, list, and action operations; ARM
templates and `@armResource*` decorators identify ARM lifecycle roles.
Consult the [resource semantics references](reference-document-links.md#resource-semantics)
for Azure Guidelines requirements, including resource-kind-specific ARM
requirements. Do not infer a lifecycle role solely from an operation name or
HTTP verb, or invent required operations absent from the bounded evidence.
For non-resource HTTP APIs, the low-level HTTP representation is sufficient.
When a resource association cannot be established, state the limitation.
Keep this within the single intent summary; do not add per-operation judgments.

Set `overallConfidence` to the lowest confidence warranted by ready dimensions and evidence quality:

- `high`: complete, direct before/after evidence;
- `medium`: interpretation is required but evidence is sufficient;
- `low`: material ambiguity remains.

List concrete blockers already supported by the input. Blocked dimensions
remain `not-assessed`; do not turn missing evidence into a pass. Azure
Guidelines follows the fetched-document evidence contract. A completed search
with no governing document is assessed as `no-applicable-guidance`, not blocked
or `not-assessed`. Documentation Completeness follows the separate
[compiler-resolved presence criterion](document-quality.md) for newly added
operations, models, enums, and interfaces. It is deterministic and outside
Agent judgment: never compare documentation text with code or assign severity.
