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
| [reviewer-posted-parity.md](references/reviewer-posted-parity.md) | Presented-vs-posted parity (interactive chat reviewers only)                       | --                                            |

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
  only to reviewers that post their own comments from an interactive session.
  Agents whose only write channel is gh-aw `safe-outputs` never own the post and
  must not implement its parity machinery.

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

### A documented rationale is not a deviation

Several Guideline statements carry an explicit exception clause. The clearest
example, quoted verbatim:

> :ballot_box_with_check: **YOU SHOULD** use extensible enumerations **unless
> you are positive that the symbol set will NEVER change over time.**

The `unless` is part of the rule, not a loophole around it. When a
specification states a rationale for a `SHOULD`-level choice — in a `@doc`, a
comment, or the PR description — the reviewer's job is to **assess whether that
rationale is plausible**, not to override it because the default differs.

- Rationale plausible → **no finding.** The spec is exercising the exception
  the Guideline grants.
- Rationale doubtful → at most a **Suggestion**, usually better as a
  **Question**: "the doc says the value set is fixed by the wire protocol — is
  that contractual, or could a third mode appear?"
- Rationale absent → normal severity for the rule applies.

**Never write that the Guidelines forbid something they express as a
`SHOULD`.** Asserting "the Guidelines do not permit this" about a
`YOU SHOULD` statement is factually wrong about the source text, and it is
worse than silence: it is confidently wrong, in writing, on a service team's
pull request.

### Reference files must preserve the exception

When a reference file restates a Guideline, it carries the exception with it.
A reference that flattens `YOU SHOULD ... unless X` into `MUST` manufactures a
requirement that does not exist upstream, and every agent reading that file
inherits the error. If a reference and the Guidelines disagree, **the
Guidelines win** — see "Authoritative External Sources" above.

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
