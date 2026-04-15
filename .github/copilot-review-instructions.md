# Copilot Code Review Instructions

You are reviewing pull requests in the `azure-rest-api-specs` repository, which
hosts Azure REST API specifications in OpenAPI v2 (Swagger) JSON and TypeSpec
formats.

## Scope

Focus your review on files matching these patterns:

- `specification/**/*.json` — OpenAPI v2 (Swagger) specification files
- `specification/**/*.tsp` — TypeSpec specification files
- `specification/**/tspconfig.yaml` — TypeSpec project configuration
- `specification/**/examples/**/*.json` — API example files

Ignore generated files under `stable/` and `preview/` directories that are
produced by `tsp compile .` — these should not be hand-edited.

## Review Guidelines by File Type

### OpenAPI v2 (Swagger) JSON files (`specification/**/*.json`)

Apply the rules in these instruction files (in precedence order):

1. **ARM control-plane specs** (`specification/**/resource-manager/**/*.json`):
   Follow the ARM-specific rules in `.github/instructions/armapi-review.instructions.md`.
   These take precedence when they conflict with the generic OpenAPI rules.
2. **All OpenAPI specs** (`specification/**/*.json`):
   Follow the generic OpenAPI rules in `.github/instructions/openapi-review.instructions.md`.

### TypeSpec files (`specification/**/*.tsp`)

Apply the rules in `.github/instructions/typespec-review.instructions.md`, which
supplements `.github/instructions/typespec-project.instructions.md`.

### Cross-cutting rules (all spec formats)

The shared review rules in `.github/skills/azure-api-review/SKILL.md` and its
reference files apply to all specification formats:

- **Secret detection** (`references/secret-detection.md`): Flag string properties
  whose name, doc comment, or example values suggest a secret but lack `@secret`
  (TypeSpec) or `"x-ms-secret": true` (Swagger).
- **Property mutability** (`references/property-mutability.md`): Enforce
  consistent read-only, write-only, and immutable semantics.
- **Provisioning state** (`references/provisioning-state.md`): ARM resources must
  include `provisioningState` with correct terminal states.
- **Naming conventions** (`references/naming-conventions.md`): camelCase
  properties, PascalCase models, no internal terminology ("ARM", "AAD").
- **Enum best practices** (`references/enum-best-practices.md`): Prefer
  extensible enums; avoid boolean properties when an enum would be clearer.
- **Tracked resource lifecycle** (`references/tracked-resource-lifecycle.md`):
  ARM tracked resources must have full CRUD + list operations.

## Key Rules to Prioritize

### Always flag these issues

- **Breaking changes**: Removed properties, changed types, new required fields
  on existing models, removed enum values within the same or across API versions.
- **Missing security definitions**: Every spec must have `@useAuth` (TypeSpec) or
  `securityDefinitions` (Swagger) with Azure AD OAuth2.
- **Secret exposure**: Properties containing passwords, keys, tokens, or
  connection strings must be annotated as secrets and must not appear in GET/PUT
  responses.
- **Missing documentation**: Every model, property, operation, and enum member
  must have a meaningful doc comment — not just a restatement of the name.
- **Incorrect API version format**: Must be `YYYY-MM-DD` or
  `YYYY-MM-DD-preview`. The version in `info.version` must match the directory
  path.
- **ARM resources missing required operations**: Tracked resources need GET, PUT,
  PATCH, DELETE, list-by-resource-group, and list-by-subscription.
- **Suppression abuse**: Suppressions without clear technical justification,
  placeholder reasons (`TODO`, `FIXME`), or justification-by-reference to other
  resources.

### Common anti-patterns to catch

- `enum` instead of `union` in TypeSpec (extensible enums are required).
- Manual swagger files added alongside a TypeSpec project.
- Custom definitions for common types (`ErrorResponse`, `Operation`,
  `OperationListResult`) instead of referencing ARM common-types.
- `Record<unknown>` or `additionalProperties` when a typed model is appropriate.
- Default values on PATCH body properties (violates JSON Merge Patch semantics).
- Proxy resources extending `Resource` instead of `ProxyResource`.
- Properties like `id`, `name`, `type` redeclared inside the `properties` bag.

## Response Format

- Flag every violation with: file path, line number or JSON path, rule reference,
  and a concrete fix suggestion.
- Use markdown formatting for clarity.
- Prioritize blocking issues (security, breaking changes, missing operations)
  over style nits.
- When unsure whether something is a violation, note it as a suggestion rather
  than a required change.
