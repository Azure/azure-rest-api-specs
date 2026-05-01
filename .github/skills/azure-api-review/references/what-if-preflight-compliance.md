<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: WhatIf.md, WhatIfNoise.md, WhatIfNoiseFix.md
       - ARM Wiki: preflight.md, PreflightFAQ.md, PreflightImplementation.md
       - ARM Wiki: api_contracts/guidelines/templatedeployment.md
     The upstream documents always take precedence if there is a conflict. -->

# What-If Noise Prevention & Preflight Compliance

These rules ensure that ARM API specifications produce correct behavior
for ARM Template What-If predictions, ARM Change Analysis, and
preflight validation. Violations cause false diffs in customer
deployments, noisy "what would change" output, and preflight failures.

**Authoritative references:**

- [ARM Wiki — What-If](https://armwiki.azurewebsites.net/api_contracts/WhatIf.html)
- [ARM Wiki — What-If Noise](https://armwiki.azurewebsites.net/api_contracts/WhatIfNoise.html)
- [ARM Wiki — Preflight](https://armwiki.azurewebsites.net/api_contracts/preflight.html)
- [Azure Resource Provider Contract — PUT Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md)

---

## Part A: What-If Noise Prevention

ARM Template What-If compares the **desired state** (PUT request body
derived from the template) with the **current state** (GET response) to
predict changes. Noise occurs when GET and PUT payloads differ for
reasons that do not represent real changes.

### WHATIF-001: Mark All Read-Only Properties

Properties whose values are ignored or rejected on PUT and are
calculated by the service **MUST** be annotated as read-only.

- **OpenAPI:** `"readOnly": true` or `"x-ms-mutability": ["read"]`
- **TypeSpec:** `@visibility(Lifecycle.Read)`

**Why:** If a server-computed property is not marked read-only, What-If
treats it as a user-settable property. When it appears in the GET
response but not in the PUT request, What-If reports a **false delete**.

### WHATIF-002: Declare Default Values on Optional Properties

Properties that, if omitted from a PUT request, will appear in the GET
response with a default value **MUST** have the `default` annotation
in the spec with that exact value.

- **OpenAPI:** `"default": <value>` on the property schema
- **TypeSpec:** `@doc("Defaults to <value>")` plus the property being optional

**Why:** Without the default annotation, What-If sees the property in
the GET response but not in the template, and reports a **false
delete**.

### WHATIF-003: Mark Write-Only / Secret Properties

Properties that are accepted on PUT but returned as `null` or omitted
in GET responses **MUST** be annotated as secrets.

- **OpenAPI:** `"x-ms-secret": true`
- **TypeSpec:** `@secret`

**Why:** Without the secret annotation, What-If sees the property in
the template but not in the GET response, and reports a **false
create**.

### WHATIF-004: PUT Must Not Exhibit PATCH Semantics

Omitting a property from a PUT request body **MUST NOT** preserve the
current value of that property. PUT is a **full replacement** — if a
property is omitted, it should be reset to its default or removed.

**Why:** If PUT silently preserves omitted properties (PATCH-like
behavior), What-If cannot accurately predict what the resource state
will be after deployment. This violates the RP Contract and creates
unpredictable behavior for template deployments.

**Fix:** If existing API versions exhibit PATCH-like PUT behavior,
discontinue it in new API versions.

### WHATIF-005: Service Must Reject Unknown Properties

> This rule is defined as **OAPI018** in
> `armapi-review.instructions.md` §8.18. It is listed here because
> silently discarding unknown properties is a common source of What-If
> noise (the GET response differs from the PUT request).

### Cross-Reference to Existing Rules

The following existing rules also prevent What-If noise:

| Rule    | Reference File         | What-If Impact                          |
| ------- | ---------------------- | --------------------------------------- |
| OAPI026 | armapi-review §8.17    | Value normalization → false differences |
| OAPI024 | armapi-review §8.16    | Array reordering → false differences    |
| OAPI025 | armapi-review §8.14    | Type normalization → false differences  |
| OAPI022 | armapi-review §8.15    | Non-static defaults → false diffs       |
| OAPI027 | property-mutability.md | Write-only properties → false creates   |

---

## Part B: Preflight Validation Contract

Preflight is ARM's mechanism for validating a deployment template
**before** executing it. Resource providers implement a preflight
endpoint that receives the template resources and returns validation
results.

### PREFLIGHT-001: Preflight Must Always Return HTTP 200

The preflight validation endpoint **MUST** always return `200 OK`, even
when reporting validation errors.

- Return `"status": "Succeeded"` with no errors when validation passes.
- Return `"status": "Failed"` with error details when validation fails.
- A non-200 status code (4xx, 5xx) indicates a **service failure**, not
  a user input problem, and is tracked as a service failure metric.

### PREFLIGHT-002: Error Format Requirements

When preflight returns validation errors:

- Each error **MUST** include `code` and `message` properties.
- `code` must be a unique, searchable error code (not a generic code
  like `InvalidTemplate`).
- `message` must be clearly actionable — tell the user exactly what is
  wrong and how to fix it.
- `target` **MUST** be a fully qualified ARM resource ID pointing to
  the specific resource that failed validation.

### PREFLIGHT-003: Handle Template Language Expressions

Preflight **MUST** accept Template Language Expressions (TLEs) —
strings that start with `[` and end with `]` — and skip validation on
those values. TLEs are evaluated at deployment time, not at preflight
time.

### PREFLIGHT-004: No Resource Existence Checks

Preflight **MUST NOT** perform existence checks for resource IDs
referenced in the template. Existence checks during preflight are
inaccurate (the referenced resource may be created later in the same
deployment) and can leak information about resources the caller does
not have access to.

### PREFLIGHT-005: Static Validations Enforced by ARM

ARM performs these static validations automatically. The spec must
support them by using correct property definitions:

- **Resource names:** not empty, ≤260 characters (≤90 for resource
  groups), must not end with `.` or whitespace.
- **Resource group names:** only alphanumerics, `-`, `_`, `.`, `(`,
  `)`.
- **`plan` and `identity`:** if specified on a tracked resource, the
  resource type must support them per the ARM manifest.
- **`location`, `plan`, `identity`:** these are **immutable** — ARM
  rejects update attempts that change them.
- **`zones`:** resource type must support availability zones; no
  duplicate zone values allowed.
