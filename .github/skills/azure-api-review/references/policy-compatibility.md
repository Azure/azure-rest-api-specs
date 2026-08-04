<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: api_contracts/guidelines/policy.md
     The upstream documents always take precedence if there is a conflict. -->

# Azure Policy Compatibility Rules (PLCY001–PLCY009)

These rules ensure ARM resource API designs are compatible with
[Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview),
which evaluates resource properties at creation and update time. Poor
API design can make it impossible for customers to write deny, audit,
or modify policies for their resources.

**Authoritative references:**

- [ARM Wiki — Azure Policy Guidelines](https://armwiki.azurewebsites.net/api_contracts/guidelines/policy.html)
- [Azure Policy — How policies evaluate](https://learn.microsoft.com/azure/governance/policy/concepts/effects)

---

## PLCY001: Design Properties for Policy Auditability

Properties **MUST** be designed so that customers can restrict or audit
resource configurations at creation time.

- Break composite values into individual properties so Policy can
  target each field independently.
- **Example — BAD:** A single `streetAddress` string containing street,
  city, state, and ZIP. Policy cannot evaluate the state portion alone.
- **Example — GOOD:** Separate `street`, `city`, `state`, `zipCode`
  properties.

**Severity:** Recommended

---

## PLCY003: Avoid Read-Only Properties That Only Appear After Creation

Properties that are read-only and only populated **after** initial
resource creation **SHOULD** be minimized. Azure Policy deny rules
evaluate the PUT request body — if a property is absent from the
request and only appears in the response, customers cannot write deny
policies against it.

**Fix:** Where feasible, make the property available on the PUT request
(even if the service assigns a default) so that deny policies can
evaluate the desired value at creation time.

**Severity:** Recommended

---

## PLCY004: No CSV-Encoded Strings for Collections

Properties **MUST NOT** use comma-separated value (CSV) strings to
represent collections. Use a JSON array instead.

CSV-encoded strings prevent Azure Policy from evaluating individual
values (Policy cannot split strings). They also complicate ARM Template
and Bicep authoring.

### OpenAPI JSON

```json
// BAD
"regions": {
  "type": "string",
  "description": "Comma-separated list of regions"
}

// GOOD
"regions": {
  "type": "array",
  "items": { "type": "string" }
}
```

### TypeSpec

```tsp
// BAD
regions?: string;  // "eastus,westus"

// GOOD
regions?: string[];
```

**Severity:** Required

---

## PLCY005: Avoid Free-Form Objects

Properties **SHOULD NOT** use `type: object` with no defined schema
(free-form objects or `additionalProperties` with no type). Azure
Policy creates **aliases** based on known property paths — dynamic or
unknown property names cannot be aliased and are therefore invisible
to Policy.

**Fix:** Define explicit named properties for all service-owned fields.
Reserve `additionalProperties` only for user-defined pass-through data
(e.g., tags, custom metadata).

**Severity:** Recommended

---

## PLCY006: Follow Correct PUT and PATCH Semantics

PUT **MUST** accept and replace the entire resource representation
(all compliance-relevant properties). PATCH **MUST** follow JSON Merge
Patch semantics for partial updates.

**Why:** Azure Policy deny rules evaluate the PUT request body. If PUT
is implemented as a partial update (only requiring changed properties),
the request body may lack properties that Policy needs to evaluate,
causing deny rules to fail silently.

**Severity:** Recommended

---

## PLCY007: Collection GET at Subscription and Resource Group Level

All **top-level** tracked resource types **MUST** support:

- Collection GET at **resource group** level
- Collection GET at **subscription** level

Subscription-scoped resources require only the subscription-level
collection GET.

**Why:** Azure Policy compliance data is populated by enumerating
resources via collection GET operations. Without these, the Policy
Compliance UI cannot show compliance state for the resource type.

**Severity:** Required

---

## PLCY008: Collection GET and Point GET for Child Resources

All **child (nested) resource types** — including singletons — **MUST**
support:

- A **collection GET** under the parent (list all children)
- A **point GET** for a single child instance

**Why:** Same as PLCY007 — Policy compliance enumeration requires both
operations. Even singleton children (e.g., `default`) need both the
collection and point GET.

**Severity:** Required

---

## PLCY009: POST Operations Are Not Supported by Azure Policy

Azure Policy **cannot** evaluate POST operations. If a resource
property or configuration requires Policy enforcement (deny, audit,
modify), it **MUST** be modeled in the PUT request body and GET
response — not as a POST action.

**Fix:** If a configuration is currently only settable via a POST
action and customers need Policy enforcement, consider modeling it as a
property on the resource's PUT body or as a nested resource with PUT
support.

**Severity:** Recommended
