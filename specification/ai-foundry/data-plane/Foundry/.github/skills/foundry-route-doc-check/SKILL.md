---
name: foundry-route-doc-check
license: MIT
metadata:
  version: "1.2.0"
description: "Validates that all TypeSpec route operations in the AI Foundry data-plane (Foundry) domain have documentation comments and @summary decorators with correct voice. USE FOR: reviewing or authoring routes.tsp files under specification/ai-foundry/data-plane/Foundry/src/. DO NOT USE FOR: files outside the Foundry data-plane area, model-only .tsp files, or SDK client customization files (client.tsp)."
---

# Foundry Route Documentation Check

Ensures every TypeSpec route operation in the **AI Foundry data-plane (Foundry)** area has
proper documentation comments and `@summary` decorator tags, using the correct grammatical
voice for each.

## Scope

This skill applies **only** to files matching:

```
specification/ai-foundry/data-plane/Foundry/src/**/routes.tsp
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
- Minor wording preferences or stylistic differences that do not violate a rule → **leave unchanged**

When in doubt, leave the existing text alone.

## Rules

Every operation defined inside an `interface` block in a `routes.tsp` file must satisfy
**all** of the following requirements. See [route-documentation-rules.md](references/route-documentation-rules.md)
for the full rule definitions, examples, and remediation guidance.

| Rule ID          | Requirement                                                                                    |
| ---------------- | ---------------------------------------------------------------------------------------------- |
| `FDOC-001`       | **Every** operation must have a TSDoc comment (`/** ... */`) or `@doc()` — note `/* */` is NOT valid TSDoc |
| `FDOC-002`       | **Every** operation must have a `@summary()` decorator — no exceptions                         |
| `FDOC-003`       | Doc comment / `@doc()` must be non-empty and use **third-person indicative** voice ("Creates an agent") |
| `FDOC-004`       | `@summary()` must be concise, single-line, and use **imperative** voice ("Create an agent"). Must not be truncated (ending mid-word or mid-sentence). |
| `FDOC-005`       | Each `@path`, `@query`, `@header`, and `@body` parameter must have a doc comment or `@doc()`   |

## Post-Edit Steps

After applying fixes to any `routes.tsp` file, **always** run the following steps in order:

### 1. Format

Run `tsp format` on the changed files to ensure consistent formatting:

```shell
npx tsp format specification/ai-foundry/data-plane/Foundry/src/**/routes.tsp
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

1. **Identify** all `routes.tsp` files under `specification/ai-foundry/data-plane/Foundry/src/`
2. **Parse** each `interface` block and enumerate its operations
3. **Check** each operation against rules `FDOC-001` through `FDOC-005`
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
```

If all operations pass, report: ✅ All Foundry route operations are fully documented.
