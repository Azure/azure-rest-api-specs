# Semantic Equivalency Contract for Swagger Comparison

This document defines the **strict semantic equivalency contract** used to compare Swagger/OpenAPI 2.0 specifications during the Search API TypeSpec migration.

We must determine whether the TypeSpec-compiled Swagger is **semantically identical** to the original hand-authored Swagger files, ignoring only documentation-related noise and ordering differences.

## Inputs

**Input A: Three hand-authored Swagger files**

- searchservice:
  - path: "../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json"
- searchindex:
  - path: "../data-plane/Azure.Search/preview/2025-11-01-preview/searchindex.json"
- knowledgebase:
  - path: "../data-plane/Azure.Search/preview/2025-11-01-preview/knowledgebase.json"
- common_types:
  - path: "../../common-types/data-plane/v1/types.json"
  - description: "external dependencies"


**Input B: TypeSpec-compiled Swagger**

- path: "../data-plane/Search/preview/2025-11-01-preview/search.json"

After merging Input A into a single spec and canonicalizing both A and B, we perform strict semantic comparison as defined below.

---

# 1. Semantic Equivalency Contract

Two Swagger specifications are considered **semantically equivalent** if and only if:

> After canonicalization (removing documentation-only fields and ordering differences), the two Swagger files describe the **exact same API surface** and **the exact same request/response contract**.

Semantic equivalency is evaluated across three dimensions:

1. **Paths + HTTP methods**
2. **Operations** (parameters, request bodies, responses)
3. **Schemas / definitions**

Any mismatch in these dimensions means **not equivalent**.

---

# 2. Allowed Differences (Removed During Canonicalization)

The following elements do **not** affect API runtime behavior and must be removed or normalized before comparison.

**Documentation Fields**

These are ignored everywhere (root, operations, parameters, responses, schemas):

- `description`
- `summary`
- `externalDocs`

**Example Fields**

- `example`
- `examples`
- `x-ms-examples`

**Tags (Non-behavioral)**

- Top-level `tags`
- Per-operation `tags`

**Documentation-only Vendor Extensions**
We maintain a whitelist (expandable as needed):

- `x-ms-summary`
- Other doc-only `x-ms-*` fields

**Ordering Differences**

All orderings are ignored:

- JSON object key order
- Array order for set-like fields:
  - `consumes`
  - `produces`
  - `schemes`
  - `security`
  - Other set-like arrays as designated

These are canonicalized into sorted, deduplicated sets.

---

# 3. Required to Match Exactly

After canonicalization, all remaining fields represent the _true API contract_ and must match **exactly**.

## Paths and Methods

- Path set must be identical.
- For each path, the HTTP method set must be identical (`GET`, `POST`, `PUT`, `DELETE`, etc.).

Any missing or extra path/method → **not equivalent**.

## Operations

### Operation Identification (Dual Strategy)

Operations are matched using a **dual strategy approach** to ensure comprehensive comparison:

**Strategy A: OperationID + Method Matching**
- If two operations have the same `operationId` and HTTP method, they are considered the same operation
- If their paths differ, this is flagged as a **path inconsistency** but comparison continues
- Context: `operationId:xxx METHOD`

**Strategy B: Path + Method Matching**
- If two operations have the same path and HTTP method, they are considered the same operation
- If their `operationId` values differ, this is flagged as an **operationId inconsistency** but comparison continues
- Context: `path METHOD`

**Deduplication**: Operations matched by both strategies are compared only once.

### Cross-reference Validation

For operations matched by either strategy, we validate path vs operationID consistency:

- **Path Inconsistency**: Same operationId but different paths → flagged as difference, comparison continues
- **OperationId Inconsistency**: Same path but different operationIds → flagged as difference, comparison continues

### operationId

- Must match exactly within matched operations, unless explicitly configured otherwise or already flagged by dual strategy logic.

### Parameters

Parameters are keyed by `(in, name)` (e.g., `("query", "api-version")`).

For each parameter:

- `in`
- `name`
- `required`
- Full schema for body parameters
- For non-body parameters:
  - `type`, `format`
  - Constraints:
    - `minimum`, `maximum`
    - `exclusiveMinimum`, `exclusiveMaximum`
    - `pattern`
    - `maxLength`, `minLength`
    - `maxItems`, `minItems`
    - `uniqueItems`
  - `enum` (must be exact match)
  - `default` (must match exactly)

Any mismatch → **not equivalent**.

### Request Body

- Content types (`consumes`) must match.
- Body schema must match exactly.

### Responses

- Status code set must match.
- For each status code:
  - Content types must match.
  - Response schema must match.
  - Response headers must match.

`description` is ignored, but everything else is strict.

---

# 4. Schema / Definition Equivalency

Schemas are compared recursively.
Two schemas are equivalent only when the following all match:

## Core Schema Fields

- `type`
- `format`
  - No coercion: `integer` ≠ `number`, `int32` ≠ `int64`

## Object Schemas

- Property sets must match exactly.
- Each property schema must be equivalent.
- `required` sets must match.
- `additionalProperties`:
  - Bool must match exactly, OR
  - Schema must match if present.

## Array Schemas

- `items` schema must match.
- Array constraints must match:
  - `maxItems`, `minItems`, `uniqueItems`

## Enums

- Enum sets must match exactly (ordering ignored).

## References

- `$ref` values must match exactly.

## Composed Schemas

(`allOf`, `oneOf`, `anyOf`)

- Component counts must match.
- Component schemas must match.
- Component sequences compared as lists or sorted sets (but consistently for both sides).

## Definitions

- Definition name sets must match.
- Each definition’s schema must be equivalent.

---

# 5. Final Equivalency Rule

After canonicalization:

> **Two Swagger specs are semantically equivalent if and only if their canonical forms are deeply equal.**

If any difference is present in:

- paths
- methods
- parameters
- request bodies
- responses
- schemas
- definitions

then the specs are **not semantically equivalent**.

---

# Appendix: Why `openapi-diff` Cannot Be Used

`openapi-diff` is unsuitable for our equivalency checking due to three fundamental limitations:

**1. Structural vs Semantic Analysis**
- Reports all differences, not just behavioral ones
- Cannot ignore documentation fields while enforcing strict behavioral equality
- No support for custom canonicalization rules

**2. N-to-1 Comparison Mismatch**
- Cannot compare 3 legacy files (`searchservice.json`, `searchindex.json`, `knowledgebases.json`) against 1 TypeSpec-generated file
- Requires complex pre-processing that defeats the purpose

**3. Noisy Output vs Clean Gate**
- Produces verbose structural diffs unsuitable as a migration gate
- We need: clear pass/fail + concise meaningful differences
- `openapi-diff` provides: exhaustive analysis of all changes

Our custom semantic equivalency checker addresses these gaps with canonicalization, behavioral-only comparison, and clean diff reporting.
