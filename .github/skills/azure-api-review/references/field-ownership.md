<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: api_contracts/guidelines/openapi.md (OAPI024, OAPI025, OAPI026)
       - ARM Wiki: api_contracts/guidelines/property_design_best_practices.md
     The upstream documents always take precedence if there is a conflict. -->

# Value Preservation Rules (OAPI024, OAPI025, OAPI026)

These rules mandate that services preserve the exact values provided
by clients. Violations cause ARM Template What-If noise, ARM Change
Analysis false positives, Azure Resource Graph stale data, and customer
confusion.

> **See also:** [property-mutability.md](property-mutability.md) for
> OAPI034 (Clear Field Ownership), which is closely related to value
> preservation.

**Authoritative references:**

- [ARM Wiki — OpenAPI Guidelines](https://armwiki.azurewebsites.net/api_contracts/guidelines/openapi.html)
- [ARM Wiki — Property Design Best Practices](https://armwiki.azurewebsites.net/api_contracts/guidelines/property_design_best_practices.html)
- [Azure Resource Provider Contract — PUT Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md)

---

## OAPI024: Preserve Array Ordering

The order of items in array properties from a PUT or PATCH request
**MUST** be preserved in the response and subsequent GET responses.

Do **not** reorder, sort, or normalize array contents. Reordering
breaks tools that diff resource payloads over time (ARM Template
What-If, ARM Change Analysis, Terraform plan).

**Severity:** Required

---

## OAPI025: Preserve Data Types

If a property accepts a value on PUT, the response **MUST** return the
same JSON data type. Do not convert between types (e.g., `42` →
`"42"`, `true` → `"true"`).

**Best:** Reject the incorrect type with `400 Bad Request`.
**Alternative:** Accept and preserve the user-provided type exactly.

**Severity:** Required

---

## OAPI026: Do Not Normalize Property Values

The value of string properties from a PUT or PATCH request **MUST**
match the corresponding value in the response and subsequent GETs. Do
**not** normalize casing, location formats, or representations.

### Common Normalization Violations

| Input          | Incorrect Normalization | Correct Behavior |
| -------------- | ----------------------- | ---------------- |
| `"westus"`     | `"West US"`             | `"westus"`       |
| `"West US"`    | `"westus"`              | `"West US"`      |
| `"::1"` (IPv6) | `"0:0:0:0:0:0:0:1"`     | `"::1"`          |
| `"MyValue"`    | `"myvalue"`             | `"MyValue"`      |

**Why:** Normalization causes the GET response to differ from the PUT
request, which generates noise in What-If, Change Analysis, Terraform
drift detection, and ARG change tracking.

**Severity:** Required
