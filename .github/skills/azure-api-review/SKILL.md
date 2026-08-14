---
name: azure-api-review
license: MIT
metadata:
  version: "1.0.0"
description: "Shared Azure REST API review rules for OpenAPI (Swagger) and TypeSpec specifications. Contains cross-cutting review guidelines plus plane-specific references used by the ARM and data-plane API reviewers, code review agents, and CI workflows. USE FOR: reviewing API specs for naming, security, property design, resource lifecycle, error design, and versioning compliance. DO NOT USE FOR: authoring TypeSpec files (use azure-typespec-author), SDK generation, or releasing packages."
---

# Azure API Review -- Shared Rules

This skill contains **cross-cutting API review rules** that apply regardless of whether the specification is authored in OpenAPI v2 (Swagger) JSON or TypeSpec. These rules are the single source of truth -- referenced by the format-specific instruction files and review agents.

## When to Use

- Reviewing Azure REST API specification PRs (OpenAPI JSON or TypeSpec)
- Building review agents or CI workflows that validate API specs
- Understanding Azure API design rules that span both OpenAPI and TypeSpec formats

## Reference Files

Each reference file covers one cross-cutting rule area with:

- The canonical rule definition
- Links to authoritative external sources (RPC contract, Azure REST API Guidelines, TypeSpec docs)
- Format-specific guidance for OpenAPI JSON and TypeSpec
- Rule IDs for citation in review findings

References are grouped by the plane they apply to. **A reviewer for one plane
must not load the other plane's files** -- see "Anti-inheritance" below.

### Cross-cutting (both planes)

| Reference                                                         | Rule Area                                                                          | Key Rule IDs                                  |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------- |
| [secret-detection.md](references/secret-detection.md)             | Proactive secret detection in API properties                                       | SEC-SECRET-DETECT                             |
| [pattern-validation.md](references/pattern-validation.md)         | Allowlist vs. denylist `pattern` constraints; Unicode bypass risk; severity matrix | OAPI-PATTERN-ALLOWLIST                        |
| [think-in-graphs.md](references/think-in-graphs.md)               | Whole-graph review method: orphans, asymmetry, cross-model reachability            | --                                            |
| [example-quality.md](references/example-quality.md)               | Example file quality: orphan detection, coverage, descriptive values               | EX-ORPHAN, EX-COVERAGE, EX-DESCRIPTIVE-VALUES |
| [enum-best-practices.md](references/enum-best-practices.md)       | Enum extensibility and boolean alternatives                                        | --                                            |
| [downstream-ci-impact.md](references/downstream-ci-impact.md)     | Do not recommend a fix that trips a required CI check                              | --                                            |
| [reviewer-posted-parity.md](references/reviewer-posted-parity.md) | Presented-vs-posted parity and cross-session reconciliation for ARM reviewers      | --                                            |

### ARM control-plane only

| Reference                                                                     | Rule Area                                                                                    | Key Rule IDs                                         |
| ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [property-mutability.md](references/property-mutability.md)                   | Write-only, conditional read-only, immutability, update tolerance, and field ownership rules | OAPI027, OAPI020, OAPI029, OAPI030, OAPI031, OAPI034 |
| [provisioning-state.md](references/provisioning-state.md)                     | `provisioningState` requirements for ARM resources                                           | RPC-Async-V1-02, RPC-Async-V1-03                     |
| [naming-conventions.md](references/naming-conventions.md)                     | Naming, casing, and Azure terminology (URL grammar is ARM-specific)                          | --                                                   |
| [tracked-resource-lifecycle.md](references/tracked-resource-lifecycle.md)     | Required CRUD operations and resource move for tracked ARM resources                         | RPC-Put-V1-22, RPC-Get-V1-05, RPC003                 |
| [policy-compatibility.md](references/policy-compatibility.md)                 | Azure Policy compatibility rules for API design                                              | PLCY001–PLCY009                                      |
| [template-deployment.md](references/template-deployment.md)                   | ARM Template Deployment engine compatibility                                                 | TD001–TD003                                          |
| [availability-zones.md](references/availability-zones.md)                     | Availability zone property contract and zone immutability                                    | --                                                   |
| [field-ownership.md](references/field-ownership.md)                           | Value preservation (array ordering, data types, casing)                                      | OAPI024, OAPI025, OAPI026                            |
| [what-if-preflight-compliance.md](references/what-if-preflight-compliance.md) | What-If noise prevention and preflight validation contract                                   | WHATIF-001–005, PREFLIGHT-001–005                    |
| [lro-final-state-via.md](references/lro-final-state-via.md)                   | LRO polling and `final-state-via` decision table                                             | --                                                   |
| [suppression-review-criteria.md](references/suppression-review-criteria.md)   | Suppression approval/rejection decision framework (readme.md directives)                     | RPC-SUPPRESS-GA, RPC-SUPPRESS-SCOPE                  |
| [linter-rule-coverage.md](references/linter-rule-coverage.md)                 | LintDiff rule ID → instruction file mapping (130+ rules)                                     | --                                                   |
| [design-decisions.md](references/design-decisions.md)                         | Grey-area design trade-off frameworks (10 decision matrices)                                 | DD-001–DD-010                                        |
| [guid-and-uuid-on-arm.md](references/guid-and-uuid-on-arm.md)                 | Why ARM specs must not use `format: uuid` (**reversed** on the data plane)                   | --                                                   |

### Data-plane only

| Reference                                                                               | Rule Area                                                                        | Key Rule IDs             |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------ |
| [data-plane-linter-rule-coverage.md](references/data-plane-linter-rule-coverage.md)     | `typespec-azure-core` rule → agent-behavior interlock (**read this first**)      | --                       |
| [data-plane-report-format.md](references/data-plane-report-format.md)                   | Finding syntax, severity glyphs, document shape (**authoritative**)              | --                       |
| [data-plane-resource-modeling.md](references/data-plane-resource-modeling.md)           | Addressability, actions-vs-CRUD, operation symmetry, versioning/breaking changes | DP-MODEL-_, DP-VERSION-_ |
| [data-plane-lro-and-paging.md](references/data-plane-lro-and-paging.md)                 | Status-monitor contract, polling linkage, paging shape and consistency           | DP-LRO-_, DP-PAGE-_      |
| [data-plane-error-design.md](references/data-plane-error-design.md)                     | Stable `code` values, `target`, actionable messages, `innererror`                | DP-ERR-\*                |
| [data-plane-naming-and-docs.md](references/data-plane-naming-and-docs.md)               | Naming **clarity** (not casing) and documentation quality beyond presence        | DP-NAME-_, DP-DOC-_      |
| [data-plane-visibility-and-secrets.md](references/data-plane-visibility-and-secrets.md) | `@visibility(Lifecycle.*)` consistency, write-only properties, secret exposure   | DP-VIS-\*                |
| [data-plane-design-decisions.md](references/data-plane-design-decisions.md)             | Grey-area data-plane trade-off frameworks (6 decision matrices)                  | DDP-001–DDP-006          |

### Anti-inheritance

Two ARM references give **actively wrong** advice if applied to the data plane:

- [`guid-and-uuid-on-arm.md`](references/guid-and-uuid-on-arm.md) forbids
  `format: uuid`. That is an ARM-only reversal;
  `openapi-review.instructions.md` §"Data types" requires data-plane specs to
  **use** `format: uuid`. A data-plane reviewer must not load this file.
- [`field-ownership.md`](references/field-ownership.md) (OAPI024/025/026)
  describes runtime service behavior (array-order, type, and casing
  preservation). It is unobservable in a spec and is explicitly out of scope for
  the data-plane reviewer.

One cross-cutting reference is scoped by consumer rather than by plane:

- [`reviewer-posted-parity.md`](references/reviewer-posted-parity.md) applies
  to ARM reviewers in both interactive and autonomous modes. Direct interactive
  posting and deferred gh-aw `safe-outputs` have different post-post
  verification mechanics, but they share the same canonical finding,
  cross-session deduplication, and contradiction-clarification contract. The
  data-plane reviewer uses its own report and reconciliation contracts.

## ARM cross-session reconciliation

Every ARM review entry point uses the same reconciliation actions: a human-run
Copilot Chat review, the ready-for-ARM GitHub Actions workflow, and an authorized
`/arm-review` request. Before an ARM reviewer posts, it inventories all
paginated inline review threads, top-level PR conversation comments, and pull
request review bodies. Human-authored and agent-authored feedback both count,
including resolved, outdated, and marker-free items. The agent marker controls
thread ownership and resolution only; it never controls whether prior feedback
counts as coverage.

Match by semantic finding identity: the same rule or review topic, affected API
element, and corrective outcome. Exact wording, author, entry point, comment
surface, line movement, severity wording, and marker presence do not make a
finding new. In every structured reconciliation plan, the action cell MUST use
one of the literal uppercase tokens below. Do not substitute synonyms such as
"suppress duplicate", "defer to existing comment", or "add a clarification
reply"; downstream Critic and execution steps parse these exact tokens. The
rationale records material non-identity differences (for example, shifted line
number, top-level versus inline surface, human origin, or missing marker) and
states why they do not make the finding new. Use these canonical actions:

- `SKIP-COVERED`: actionable prior feedback already covers the same finding.
  Do not post another standalone finding. Use the literal `SKIP-COVERED` token
  even for human-authored top-level comments, review bodies, resolved threads,
  shifted lines, or marker-free feedback.
- `REPLY-LINE-SHIFT`: a human-origin inline finding still applies at a moved
  line. Reply in that thread and leave it unresolved.
- `RESOLVE-AND-REPOST`: an agent-origin inline finding still applies at a moved
  line. Resolve the stale thread and post one replacement at the current line.
- `CLARIFY-CONFLICT`: prior feedback for the same semantic finding gives
  materially incompatible guidance. Do not post a competing finding. Reply in
  the existing inline thread, or post one consolidated top-level clarification
  for conflicts in top-level comments/review bodies. State the prior position,
  current evidence, current guidance, and why it changed. Never auto-resolve a
  human-origin thread. The plan action remains the literal
  `CLARIFY-CONFLICT`, not a prose synonym.
- `POST-NEW`: no actionable prior coverage or contradiction exists on any
  discussion surface.

If any discussion surface cannot be fetched completely, reconciliation is
incomplete. Follow the Reviewer's explicit failure path; do not silently treat
all candidates as `POST-NEW`.

## Authoritative External Sources

These external documents are the upstream authorities. When they conflict with each other, the precedence order is:

1. **[Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0)** -- ARM control-plane contract (highest precedence for ARM resources)
2. **[Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)** -- general Azure API design (highest precedence for data-plane)
3. **[TypeSpec Azure library docs](https://azure.github.io/typespec-azure/docs/intro/)** -- TypeSpec-specific patterns for Azure
4. **[ARM wiki / RP guidelines](https://armwiki.azurewebsites.net/api_contracts/guidelines/rpguidelines.html)** -- supplementary ARM guidance

## Design Principles

These principles guide how the API Reviewer agents, their instruction
files, and reference files are designed and maintained:

1. **Expert persona.** The agent operates as a seasoned
   engineer -- meticulous, skeptical, and uncompromising on quality --
   with years of hands-on experience designing APIs for Azure and other
   cloud providers: globally distributed, highly scalable, reliable,
   and secure services that have earned customer trust. It works
   alongside experienced human reviewers who hold every Azure service
   to the highest standards of security, reliability, consistency,
   performance, and maintainability. Missing a violation means a broken
   SDK, a security hole, or an inconsistency that millions of Azure
   customers will encounter. Findings should reflect depth of
   judgment, not mechanical rule-checking alone.

   **Calibration differs by consumer.** For an interactive, human-driven
   reviewer, a missed violation is the dominant cost. For an unattended
   CI bot posting to a service team's PR, a false positive is: a bot that
   is wrong gets muted, after which it catches nothing. The data-plane
   reviewer therefore reports only what it can anchor to a specific line
   and a specific guideline section, and treats silence as a valid
   output.

1. **Normative strength is part of the rule.** Azure REST API Guidelines
   statements carry an explicit strength -- `DO` / `DO NOT`,
   `YOU SHOULD` / `YOU SHOULD NOT`, `YOU MAY` -- and that strength
   governs how a finding may be raised. See "Normative strength and
   documented rationale" below. Flattening a `YOU SHOULD ... unless X`
   into a bare `MUST` in a reference file is a defect: it discards the
   exception the Guideline itself grants, and produces confident,
   wrong findings.

1. **Consistency and reusability.** Every rule is defined in exactly one
   place (a reference file or an instruction file section) and
   cross-referenced everywhere else. No duplication. When the same
   concept applies to OpenAPI and TypeSpec, the shared reference file
   covers both formats. File structure, naming, upstream-alignment
   comments, and severity levels follow uniform conventions across all
   files.
1. **Low maintenance overhead.** The files are designed so that
   maintainers spend minimal effort. Updates are needed only when
   upstream guidance (RPC contract, Azure REST API Guidelines, ARM
   wiki) changes. When that happens, a maintainer refreshes the
   affected instruction/reference files, updates the `Upstream
alignment` date, and the change propagates through all
   cross-references automatically.

## Normative strength and documented rationale

Azure REST API Guidelines statements are tagged with an explicit strength.
That tag is part of the rule, and it constrains both **whether** a finding may
be raised and **at what severity**.

| Guideline tag                   | Meaning               | Maximum finding severity                        |
| ------------------------------- | --------------------- | ----------------------------------------------- |
| `DO` / `DO NOT`                 | Requirement           | **Blocking** (when the consequence warrants it) |
| `YOU SHOULD` / `YOU SHOULD NOT` | Strong recommendation | **Warning** — never Blocking                    |
| `YOU MAY`                       | Permission            | Suggestion or Question only                     |

Blocking is additionally reserved for genuine correctness or security defects
— secret exposure, a breaking change in a stable version — regardless of tag.

### A documented rationale is not automatically a deviation — but it is not automatically an exception either

Several Guideline statements carry an explicit exception clause. Two, quoted
verbatim:

> :ballot_box_with_check: **YOU SHOULD** use extensible enumerations **unless
> you are positive that the symbol set will NEVER change over time.**

> :ballot_box_with_check: **YOU SHOULD** support paging today **if there is ever
> a chance in the future that the number of items can grow to be very large.**

The `unless` and the `if` are part of the rule, not loopholes around it. Note
what they have in common: each names a **specific condition**. Neither says
"unless the author explains themselves".

**Apply a two-step test, in order. Both steps must pass before a rationale
silences a finding.**

**Step 1 — Does the Guideline actually grant an exception here?**

Read the statement you are citing. If it has no exception clause, **a rationale
cannot waive it at all.** At most it affects severity, phrasing, or whether you
raise a question instead of an assertion. Do not generalize the extensible-enum
`unless` into a universal escape hatch: it is an exception to _that_ rule, not a
precedent that every rule bends to a well-written paragraph.

**Step 2 — Does the rationale satisfy that specific condition?**

Not "is it plausible". Not "is it well-argued". Not "did the author clearly
think about this". **Does it address, and meet, the condition the Guideline
actually states?**

A fluent argument for a _different_ proposition does not earn the exception. A
rationale can be entirely true, professionally written, and still fail to say
anything about the thing the exception turns on.

#### Worked example — an argument that fails Step 2

A search operation returns an unpaged array. Its `@doc` argues, at length, that
a snapshot is atomic and a cursor would let ranks shift between calls; that more
than 99.9% of production searches return fewer than 250 hits; and that avoiding
cursor state keeps the common path simple.

Every one of those claims may be true. **None of them addresses whether the
result set can ever grow very large**, which is the condition `DP-PAGE-01`
states. Typical size is not maximum size, and consistency is a different subject
altogether. The exception is not earned, and the finding stands.

Worse, the same spec defines a `QueryResultTooLarge` error for results that
exceed a size limit. That is the service's own evidence that the collection
**can** grow large — the spec answers the real question, in the author's favor
against their own argument. Look for that kind of contradiction: a rationale is
weakened most by the rest of the spec, not by your intuition.

#### Worked example — an argument that passes Step 2

A closed literal union is suppressed with: _"the wire protocol frames a request
as either single-sentence or whole-document; a third depth would need a
different request shape, not a third member, so the set cannot grow."_

That is on-condition. The extensible-enum exception turns on whether the symbol
set will never change, and the rationale argues exactly that, with a structural
reason rather than an assurance. **Silent. No finding, at any severity.**

#### Outcomes

- **Exception exists and the rationale meets it** → **no finding.** The spec is
  exercising the exception the Guideline grants.
- **Exception exists and the rationale does not meet it** → **normal finding.**
  Say which condition it fails to address (see below).
- **No exception clause in the Guideline** → the rationale does not waive
  anything. Normal severity for the rule.
- **Rationale absent** → normal severity for the rule.

#### Always address a stated rationale explicitly in the finding

When the spec argues for its choice and you raise the finding anyway, **name the
argument and say why it does not hold.** One or two sentences:

> The `@doc` argues that 99.9% of searches return fewer than 250 hits. That is
> about typical size; `DP-PAGE-01`'s exception turns on whether the collection
> can _ever_ grow very large, and `QueryResultTooLarge` indicates it can.

A reviewer that silently overrules a documented rationale reads as not having
read it, and gets dismissed on exactly that basis. This applies equally when the
rationale is irrelevant rather than wrong — say that it addresses a different
question.

**Never write that the Guidelines forbid something they express as a
`SHOULD`.** Asserting "the Guidelines do not permit this" about a
`YOU SHOULD` statement is factually wrong about the source text, and it is
worse than silence: it is confidently wrong, in writing, on a service team's
pull request. Rejecting a rationale is not the same as upgrading the rule.

### Reference files must preserve the exception

When a reference file restates a Guideline, it carries the exception with it.
A reference that flattens `YOU SHOULD ... unless X` into `MUST` manufactures a
requirement that does not exist upstream, and every agent reading that file
inherits the error. If a reference and the Guidelines disagree, **the
Guidelines win** — see "Authoritative External Sources" above.

### The `Severity` field is the single source of severity truth

A reference file's own prose is **this skill's synthesis**, not a quotation of
the Guidelines, unless it explicitly says otherwise. So:

- **The `Severity:` field decides how loud a finding may be.** A rule body
  saying `**MUST**` does not make the rule `DO`-level, and does not license
  Blocking. Read the field.
- **Quote the upstream verb rather than inventing one.** Where a reference
  restates a Guideline, it should cite the anchor and quote the tag, as
  `DP-PAGE-01` and the extensible-enum guidance now do. Where a rule is our own
  synthesis of vague upstream direction — `DO focus heavily on clear &
consistent naming` cannot tell you whether `cfg` is too opaque — the rule
  should say so, so its `**MUST**` is not mistaken for a sourced requirement.
- **Never escalate on the strength of a reference-body verb.** If the field says
  Warning and the body says `MUST`, the answer is Warning.

Rules currently wording themselves `MUST` at Warning severity without citing an
upstream anchor: `DP-ERR-05`, `DP-LRO-01`, `DP-PAGE-02`, `DP-NAME-02`,
`DP-NAME-04`, `DP-DOC-02`, `DP-MODEL-01`, `DP-VERSION-03`. Most do have a
genuine upstream `DO` behind them — `DP-MODEL-01` restates
`DO NOT use an action operation when the operation behavior could reasonably be
defined as one of the standard REST … operations`, and `DP-NAME-02` restates
`DO … include the time unit` — but until each carries its citation, treat the
field as authoritative and the verb as emphasis.

`DP-ERR-01` was on that list and has been rewritten: its enumeration trigger is
now narrow and capped at Question, and it carries the
`rest-error-use-default-response` citation that pushes **against** the stronger
reading. It is the worked example of why the list matters — an uncited `MUST`
turned out to fire on `Azure.Core.Foundations.Error` itself.

## Maintenance & Upstream Alignment

The instruction files and reference files in this skill are **derived
from** the authoritative external sources listed above. They are not
replacements for those documents — they distill the most commonly
violated rules into a structured format optimized for LLM-based review
agents.

**Why inline rules instead of raw document references:** LLM review
agents produce more consistent, actionable findings when rules are
codified with explicit rule IDs, severity levels, and fix suggestions.
Raw upstream documents are prose-heavy and not structured for automated
consumption.

**Keeping rules current:**

- Each instruction file includes an `Upstream alignment` date in an
  HTML comment at the top. This date indicates when the rules were last
  verified against the upstream documents.
- When an upstream document changes a rule, the corresponding
  instruction file **MUST** be updated to match. The upstream document
  always takes precedence.
- Rules that overlap with existing linter checks are annotated with
  `(Also enforced by: ...)`. The review agent should check CI results
  before flagging these to avoid duplicating linter findings. For the
  data plane this soft convention is replaced by a hard interlock --
  [`data-plane-linter-rule-coverage.md`](references/data-plane-linter-rule-coverage.md),
  whose header pin is enforced by the `data-plane-review-alignment` CI check.
- To avoid conflicts with the
  [azure-typespec-author](../../skills/azure-typespec-author/SKILL.md)
  skill (used for TypeSpec code generation), coordinate rule changes
  with that skill's maintainers. A rule flagged by the reviewer agent
  should not contradict guidance given by the authoring agent.
- **Formatting:** After editing any `.md` file under `skills/` or
  `agents/`, run `npm run format` from the `.github/` directory
  (Prettier). Note: instruction files (`*instructions.md`) are excluded
  from Prettier via `.prettierignore` and do not need formatting.

## Repository Documentation

These documents in this repo provide additional context:

- [Breaking changes guidelines](../../../documentation/Breaking%20changes%20guidelines.md)
- [Uniform versioning](../../../documentation/uniform-versioning.md)
- [Directory structure](../../../documentation/directory-structure.md)
- [OpenAPI authoring automated guidelines](../../../documentation/openapi-authoring-automated-guidelines.md)
- [Swagger extensions](../../../documentation/swagger-extensions.md)
- [CI fix guide](../../../documentation/ci-fix.md)
- [TypeSpec dev process](../../../documentation/typespec-rest-api-dev-process.md)

## Relationship to Instruction Files

The format-specific instruction files reference these shared rules:

| Instruction File                  | Applies To                                    | Relationship                                                                                                           |
| --------------------------------- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `arm-api-review.instructions.md`  | `specification/**/resource-manager/**/*.json` | References shared rules + adds ARM-specific rules (path structure, PUT/PATCH/DELETE contracts, LRO, ARG compatibility) |
| `openapi-review.instructions.md`  | `specification/**/*.json`                     | References shared rules + adds generic OpenAPI rules (file structure, x-ms extensions, examples, security definitions) |
| `typespec-review.instructions.md` | `specification/**/*.tsp`                      | References shared rules + adds TypeSpec-specific rules (decorators, project structure, anti-patterns)                  |

## Consumers

| Consumer                                                                            | Loads                                        |
| ----------------------------------------------------------------------------------- | -------------------------------------------- |
| [`arm-api-reviewer.agent.md`](../../agents/arm-api-reviewer.agent.md)               | Cross-cutting + ARM control-plane references |
| [`data-plane-api-reviewer.agent.md`](../../agents/data-plane-api-reviewer.agent.md) | Cross-cutting + data-plane references        |
| [`copilot-review-instructions.md`](../../copilot-review-instructions.md)            | Cross-cutting references                     |
| CI workflows                                                                        | Individual references as needed              |
