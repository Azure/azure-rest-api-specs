---
name: foundry-route-doc-check
license: MIT
metadata:
  version: "1.6.0"
description: "Validates that all TypeSpec route operations in the AI Foundry data-plane (Foundry) domain have documentation comments and @summary decorators with correct voice, replaces documentation-required suppressions with generated documentation, and uses description override extensions when TypeSpec would concatenate noisy descriptions. USE FOR: reviewing or authoring routes.tsp and routes.generated.tsp files under specification/ai-foundry/data-plane/Foundry/src/. DO NOT USE FOR: files outside the Foundry data-plane area, model-only .tsp files, or SDK client customization files (client.tsp)."
---

# Foundry Route Documentation Check

Ensures every TypeSpec route operation in the **AI Foundry data-plane (Foundry)** area has
proper documentation comments and `@summary` decorator tags, using the correct grammatical
voice for each.

## Scope

This skill applies **only** to files matching:

```
specification/ai-foundry/data-plane/Foundry/src/**/routes.tsp
specification/ai-foundry/data-plane/Foundry/src/**/routes.generated.tsp
```

It does **not** apply to:

- `models.tsp`, `client.tsp`, `client.*.tsp`, or `main.tsp` files
- Any `.tsp` files outside `specification/ai-foundry/data-plane/Foundry/`
- Generated OpenAPI JSON under `openapi3/`

## When to Use

- Reviewing or authoring route definitions in the Foundry data-plane area
- Pre-PR checks for missing API documentation
- Auditing existing routes for documentation completeness

## Conservative Change Policy

**Do not modify documentation that is already substantially correct.** Only flag and fix
operations that have an explicit, significant rule violation:

- Missing `@summary()` or doc comment entirely → fix
- Wrong grammatical voice (`@summary` using third-person, or doc comment using imperative) → fix
- Empty or placeholder documentation → fix
- Summary contains unnecessary filler ("all", "by id") that can be removed → fix
- Summary uses a multiline triple-quoted string, full sentence, or paragraph instead of a concise single-line phrase → fix
- Description is near-identical to the summary with no added detail → fix
- Description uses `@doc()` instead of a TSDoc `/** ... */` comment → fix
- `#suppress "@azure-tools/typespec-azure-core/documentation-required" ...` hides missing route or parameter documentation → remove the suppression and add documentation
- Multiple adjacent TSDoc comment blocks apply to the same operation or parameter → merge or remove the redundant block
- Multiple route variants or content types would cause TypeSpec to concatenate request body or parameter descriptions into noisy OpenAPI text → add the appropriate override extension with the intended final description instead of stacking TSDoc comments
- Minor wording preferences or stylistic differences that do not violate a rule → **leave unchanged**

When in doubt, leave the existing text alone.

For `routes.generated.tsp` files, it is acceptable to apply this skill's automated
rewrite directly to the generated file. The intended workflow is to run route
generation first and then run this rewrite immediately afterward, so the generated
route documentation changes are consistently reapplied and not lost overall.

## Rules

Every operation defined inside an `interface` block in a `routes.tsp` or `routes.generated.tsp` file must satisfy
**all** of the following requirements. See [route-documentation-rules.md](references/route-documentation-rules.md)
for the full rule definitions, examples, and remediation guidance.

| Rule ID          | Requirement                                                                                    |
| ---------------- | ---------------------------------------------------------------------------------------------- |
| `FDOC-001`       | **Every** operation must have a TSDoc `/** ... */` comment. Prefer TSDoc over `@doc()`. |
| `FDOC-002`       | **Every** operation must have a `@summary()` decorator — no exceptions                         |
| `FDOC-003`       | The TSDoc description must use **third-person indicative** voice ("Creates an agent"), must add meaningful detail beyond the summary, and must not be near-identical to the summary. |
| `FDOC-004`       | `@summary()` must be a maximally concise, single-line **imperative** phrase ("Create an agent"). No multiline strings. No trailing period. No filler ("all", "by ID", "info about"). Must not be truncated. Always include articles. |
| `FDOC-005`       | Each `@path`, `@query`, `@header`, and `@body` parameter must have a doc comment or `@doc()`   |
| `FDOC-006`       | Do not leave multiple adjacent TSDoc comment blocks on the same operation or parameter. TypeSpec concatenates adjacent docs into one OpenAPI `description`, which can produce malformed text. |
| `FDOC-007`       | Remove `documentation-required` suppressions on routes and parameters, including auto-generated import suppressions, and replace them with generated TSDoc documentation. |
| `FDOC-008`       | When TypeSpec would concatenate operation summaries/descriptions, request body descriptions, or parameter descriptions for shared routes, multiple content types, or adjacent imported docs, add the appropriate override extension with the desired final text. |

### `documentation-required` suppressions

When a route file contains a suppression for missing documentation, treat it as a fixable
documentation violation, not as an accepted exception. This includes suppressions such as:

```typespec
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
```

For each matching suppression in a scoped `routes.tsp` or `routes.generated.tsp` file:

1. Remove the `#suppress` directive.
2. Identify the operation, operation parameter, request body, query/header/path parameter, or
   route-related declaration the suppression was shielding.
3. Add or repair the appropriate TSDoc documentation using rules `FDOC-001` through `FDOC-005`.
4. If the target already has a TSDoc comment or participates in a shared route / multiple-content-type request body where TypeSpec would concatenate descriptions, keep a single TSDoc comment for linter compliance and add the correct override extension.

   For `@path`, `@query`, and real `@header` parameters, apply the parameter-level extension:

   ```typespec
   @extension("x-ms-description-override", "The intended final OpenAPI description.")
   ```

   For `@body` and `@multipartBody`, apply an operation-level request-body override because
   TypeSpec does not emit parameter-level extensions onto the OpenAPI `requestBody` object:

   ```typespec
   @extension("x-ms-request-body-description-override", "The intended final request body description.")
   ```

   Put this operation-level extension with the operation decorators (near `@summary`, `@route`,
   and `@post`). Import and use `TypeSpec.OpenAPI` if the file does not already do so.
5. Preserve unrelated suppressions and any non-documentation suppressions.
6. Do not leave the file in a state where `documentation-required` still needs to be suppressed.

### Description override extensions

Use description override extensions when the source must retain documentation for TypeSpec
linting but the emitted OpenAPI description would otherwise be noisy because TypeSpec
concatenates multiple source descriptions.

Use:

- `x-ms-summary-override` and `x-ms-description-override` on each shared-route
  operation variant when TypeSpec would merge multiple operations into one OpenAPI
  operation and concatenate their summaries/descriptions
- `x-ms-description-override` on `@path`, `@query`, and real `@header` parameters
- `x-ms-request-body-description-override` on the operation for `@body` and
  `@multipartBody` request bodies

Common examples:

- Shared-route operation variants that combine multipart and JSON request bodies into
  one OpenAPI operation, causing summaries such as
  `"Create a video edit multipart Create a video edit json"`
- Shared-route request bodies that combine JSON and multipart content types into one OpenAPI `requestBody`
- Imported generated parameters where the import already contributed a generic description
- Any route parameter or request body that would emit repeated text such as `"The request body.The request body."` or `"The file id path parameter.The ID of the file."`

Prefer one concise TSDoc comment for the source declaration and one override extension with
the exact final OpenAPI text. Do not add adjacent TSDoc comments as a workaround. Do not add
`x-ms-description-override` directly to `@body` or `@multipartBody` declarations because the
OpenAPI emitter does not preserve those extensions on `requestBody`.

## Post-Edit Steps

After applying fixes to any `routes.tsp` or `routes.generated.tsp` file, **always** run the following steps in order:

### 1. Format

Run `tsp format` on the changed files to ensure consistent formatting:

```shell
npx tsp format specification/ai-foundry/data-plane/Foundry/src/**/routes.tsp specification/ai-foundry/data-plane/Foundry/src/**/routes.generated.tsp
```

### 2. Regenerate OpenAPI artifacts

Recompile the project to regenerate both JSON **and** YAML OpenAPI outputs under `openapi3/`.
Do **not** modify `tspconfig.yaml` — it already emits both file types via `file-type: [yaml, json]`.

```shell
cd specification/ai-foundry/data-plane/Foundry
npx tsp compile .
```

Verify that the files under `openapi3/{version}/` are updated for every versioned output.

## Workflow

1. **Identify** all `routes.tsp` and `routes.generated.tsp` files under `specification/ai-foundry/data-plane/Foundry/src/`
2. **Parse** each `interface` block and enumerate its operations
3. **Check** each operation against rules `FDOC-001` through `FDOC-008`
4. **Report** findings grouped by file, with rule ID, operation name, and line number
5. **Fix** only operations with explicit, significant rule violations (see Conservative Change Policy)
6. **Run `tsp format`** on all modified files
7. **Run `tsp compile .`** to regenerate JSON and YAML OpenAPI artifacts

## Output Format

Report results as a markdown table:

```markdown
| File | Operation | Rule | Finding |
| ---- | --------- | ---- | ------- |
| src/connections/routes.tsp | get | FDOC-002 | Missing `@summary()` decorator |
| src/openai-chat/routes.generated.tsp | createChatCompletion | FDOC-004 | `@summary()` uses third-person voice |
```

If all operations pass, report: ✅ All Foundry route operations are fully documented.
