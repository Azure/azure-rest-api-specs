---
name: azure-api-review
license: MIT
metadata:
  version: "1.0.0"
description: "Shared Azure REST API review rules for OpenAPI (Swagger) and TypeSpec specifications. Contains cross-cutting review guidelines used by ARM API reviewers, code review agents, and CI workflows. USE FOR: reviewing API specs for naming, security, property design, resource lifecycle, and versioning compliance. DO NOT USE FOR: authoring TypeSpec files (use azure-typespec-author), SDK generation, or releasing packages."
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

| Reference                                                                     | Rule Area                                                                                    | Key Rule IDs                                         |
| ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [secret-detection.md](references/secret-detection.md)                         | Proactive secret detection in API properties                                                 | SEC-SECRET-DETECT                                    |
| [property-mutability.md](references/property-mutability.md)                   | Write-only, conditional read-only, immutability, update tolerance, and field ownership rules | OAPI027, OAPI020, OAPI029, OAPI030, OAPI031, OAPI034 |
| [provisioning-state.md](references/provisioning-state.md)                     | `provisioningState` requirements for ARM resources                                           | RPC-Async-V1-02, RPC-Async-V1-03                     |
| [naming-conventions.md](references/naming-conventions.md)                     | Naming, casing, and Azure terminology                                                        | --                                                   |
| [enum-best-practices.md](references/enum-best-practices.md)                   | Enum extensibility and boolean alternatives                                                  | --                                                   |
| [tracked-resource-lifecycle.md](references/tracked-resource-lifecycle.md)     | Required CRUD operations and resource move for tracked ARM resources                         | RPC-Put-V1-22, RPC-Get-V1-05, RPC003                 |
| [policy-compatibility.md](references/policy-compatibility.md)                 | Azure Policy compatibility rules for API design                                              | PLCY001–PLCY009                                      |
| [template-deployment.md](references/template-deployment.md)                   | ARM Template Deployment engine compatibility                                                 | TD001–TD003                                          |
| [availability-zones.md](references/availability-zones.md)                     | Availability zone property contract and zone immutability                                    | --                                                   |
| [field-ownership.md](references/field-ownership.md)                           | Value preservation (array ordering, data types, casing)                                      | OAPI024, OAPI025, OAPI026                            |
| [what-if-preflight-compliance.md](references/what-if-preflight-compliance.md) | What-If noise prevention and preflight validation contract                                   | WHATIF-001–005, PREFLIGHT-001–005                    |
| [lro-final-state-via.md](references/lro-final-state-via.md)                   | LRO polling and `final-state-via` decision table                                             | --                                                   |
| [suppression-review-criteria.md](references/suppression-review-criteria.md)   | Suppression approval/rejection decision framework                                            | RPC-SUPPRESS-GA, RPC-SUPPRESS-SCOPE                  |

## Authoritative External Sources

These external documents are the upstream authorities. When they conflict with each other, the precedence order is:

1. **[Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0)** -- ARM control-plane contract (highest precedence for ARM resources)
2. **[Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)** -- general Azure API design (highest precedence for data-plane)
3. **[TypeSpec Azure library docs](https://azure.github.io/typespec-azure/docs/intro/)** -- TypeSpec-specific patterns for Azure
4. **[ARM wiki / RP guidelines](https://armwiki.azurewebsites.net/api_contracts/guidelines/rpguidelines.html)** -- supplementary ARM guidance

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
  before flagging these to avoid duplicating linter findings.
- To avoid conflicts with the
  [azure-typespec-author](../../skills/azure-typespec-author/SKILL.md)
  skill (used for TypeSpec code generation), coordinate rule changes
  with that skill's maintainers. A rule flagged by the reviewer agent
  should not contradict guidance given by the authoring agent.

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
| `armapi-review.instructions.md`   | `specification/**/resource-manager/**/*.json` | References shared rules + adds ARM-specific rules (path structure, PUT/PATCH/DELETE contracts, LRO, ARG compatibility) |
| `openapi-review.instructions.md`  | `specification/**/*.json`                     | References shared rules + adds generic OpenAPI rules (file structure, x-ms extensions, examples, security definitions) |
| `typespec-review.instructions.md` | `specification/**/*.tsp`                      | References shared rules + adds TypeSpec-specific rules (decorators, project structure, anti-patterns)                  |
