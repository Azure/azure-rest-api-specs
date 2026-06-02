<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: api_contracts/guidelines/api_best_practices_and_design_choices.md
       - ARM Wiki: api_contracts/guidelines/openapi.md
       - Azure REST API Guidelines (vNext)
       - Patterns observed across ~40,000 ARM API review comments (2021-2026)
     The upstream documents always take precedence if there is a conflict. -->

# API Design Decision Frameworks

This reference provides structured decision frameworks for common API
design trade-offs that do **not** have a single correct answer. These
are the "grey areas" where the ARM API reviewer must weigh context,
service requirements, and platform compatibility.

**How the agent should use this file:**

- When a design pattern triggers one of these trade-offs, produce a
  `💡 Suggestion` finding (never `🔴 Blocking`).
- Present the relevant factors and trade-off table to the reviewer.
- Ask clarifying questions rather than making definitive calls.
- The human reviewer makes the final decision.

---

## DD-001: Inline Array vs. Nested Resource

When a resource has a collection of sub-items (e.g., IP rules, access
policies, endpoints), the collection can be modeled as an inline array
property or as a nested (child) resource type.

### Factors to Evaluate

| Factor                 | Favors Inline                 | Favors Nested Resource           |
| ---------------------- | ----------------------------- | -------------------------------- |
| Collection size        | ≤20 items, bounded            | Unbounded or >50 items           |
| Growth trajectory      | Stable, known maximum         | Expected to grow over time       |
| Independent lifecycle  | Items always updated together | Items managed individually       |
| RBAC separation        | Same permissions as parent    | Different permissions needed     |
| ARM resource ID needed | No                            | Yes (each item needs its own ID) |
| Ordering semantics     | Order matters, atomic updates | Order does not matter            |
| Payload size impact    | <10 KB total                  | >100 KB possible                 |
| Azure Resource Graph   | Not queried independently     | Need ARG queries per item        |

### Recommendation

- **Inline** if: bounded (≤20), stable, no RBAC separation, <10 KB
- **Nested resource** if: unbounded, needs RBAC, needs ARM resource IDs,
  or could exceed 100 KB payload
- **Discuss** if: 20-50 items or moderate growth expected

### Questions to Ask

1. What is the maximum number of items this collection can have?
2. Will individual items ever need separate RBAC permissions?
3. Do external systems need to reference individual items by ARM resource ID?
4. Is the collection expected to grow significantly over time?

### Anti-Pattern

Modeling the same collection as **both** an inline array and a nested
resource type. This causes data inconsistency, customer confusion, and
ARG integration issues.

---

## DD-002: Boolean vs. Extensible Enum

When a property represents a binary state (on/off, enabled/disabled),
should it be modeled as a `boolean` or an extensible `string` enum?

### Factors to Evaluate

| Factor          | Favors Boolean            | Favors Enum                       |
| --------------- | ------------------------- | --------------------------------- |
| Future states   | Truly binary forever      | May need 3rd+ state               |
| Feature toggle  | No                        | Yes (feature toggles often grow)  |
| Versioning risk | None                      | Boolean-to-enum is breaking       |
| SDK usability   | Slightly simpler          | Named values are self-documenting |
| Property name   | Is-prefixed (`isDeleted`) | State name (`encryptionStatus`)   |

### Recommendation

- **Enum** if: any possibility of future states, feature toggle,
  or state name is descriptive (e.g., `networkAccess: Enabled|Disabled`)
- **Boolean acceptable** if: truly binary and permanent (e.g.,
  `isDeleted`, `isDefault`) AND property name uses `is-` prefix
- **Default guidance**: prefer enum — booleans do not version well

### Common Evolution Patterns

| Started As                  | Evolved To                 | Breaking?                |
| --------------------------- | -------------------------- | ------------------------ |
| `enabled: true/false`       | Need `Suspended` state     | Yes — boolean to 3-value |
| `backupEnabled: true/false` | Need `Paused`, `Scheduled` | Yes                      |
| `isDefault: true/false`     | Still binary after 5 years | No — good boolean use    |

---

## DD-003: Synchronous vs. Asynchronous PATCH

When a PATCH operation takes variable time, should it be synchronous
(return 200 immediately) or asynchronous (return 202 + poll)?

### Factors to Evaluate

| Factor               | Favors Sync            | Favors Async                    |
| -------------------- | ---------------------- | ------------------------------- |
| P99 latency          | <1 second              | >1 second                       |
| Operation complexity | Simple property update | Backend orchestration           |
| Client experience    | Immediate result       | Must poll for completion        |
| SDK complexity       | Simple                 | Requires LRO support            |
| Template deployment  | Simpler                | More complex but well-supported |

### Recommendation

- **Synchronous** if: P99 latency ≤1 second for all property updates
- **Asynchronous** if: P99 latency >1 second for any update scenario
- **Note**: PATCH is NOT required to be async. Do not flag synchronous
  PATCH as a violation (armapi-review §4.6)

### Questions to Ask

1. What is the P99 latency for PATCH operations in production?
2. Does the update trigger backend orchestration (VMs, networking)?
3. Can the operation time out under load?

---

## DD-004: POST vs. GET for Data Retrieval

When retrieving complex or computed data, should it be a GET with
query parameters or a POST with a request body?

### Factors to Evaluate

| Factor             | Favors GET               | Favors POST                 |
| ------------------ | ------------------------ | --------------------------- |
| Retrieving secrets | No (secrets in URL logs) | Yes (`list*` POST for RBAC) |
| Query complexity   | Simple filters           | Complex filter body         |
| P99 latency        | <2 seconds               | >2 seconds (async POST)     |
| Cacheability       | Cacheable by default     | Not cacheable               |
| SDK pagination     | Native support           | Manual re-POST per page     |
| Azure Policy       | Can evaluate             | Cannot evaluate             |

### Recommendation

- **GET with OData filters** for most data retrieval
- **POST** only when:
  - Retrieving secret values (use `list*` prefix for template compat)
  - P99 latency >2 seconds (model as async POST)
  - Query body cannot fit in URL (>2 KB of filter parameters)
- **Prefer GET** in all other cases

### Anti-Pattern

Using POST for data retrieval simply because the query has multiple
parameters. OData `$filter` on GET handles most query scenarios and
integrates with SDKs, Policy, and caching.

---

## DD-005: Property Granularity — Composite vs. Separate Fields

When a concept has multiple components (e.g., an address, a connection
string), should it be a single composite property or separate fields?

### Factors to Evaluate

| Factor                  | Favors Composite       | Favors Separate Fields |
| ----------------------- | ---------------------- | ---------------------- |
| Azure Policy evaluation | Cannot evaluate parts  | Can target each field  |
| ARM Template authoring  | Single expression      | Individual references  |
| SDK usability           | One property           | Clear per-field types  |
| Validation              | Must parse to validate | Per-field validation   |
| Future extensibility    | Must change format     | Add new fields         |

### Recommendation

- **Separate fields** if: Azure Policy needs to evaluate individual
  components, or components have different types/validation rules
- **Composite** if: the value is opaque to the platform and only
  meaningful as a whole (e.g., a certificate thumbprint)

### Example

```
BAD:  "address": "123 Main St, Redmond, WA, 98052"
GOOD: "street": "123 Main St", "city": "Redmond",
      "state": "WA", "zipCode": "98052"
```

---

## DD-006: Suppression Justification — When Is It Strong Enough?

When a linter rule fires and the author requests suppression, how
should the reviewer evaluate the justification?

### Decision Matrix

| Scenario                                                             | Recommendation                                    |
| -------------------------------------------------------------------- | ------------------------------------------------- |
| False alarm — linter is wrong for this code                          | ✅ Approve; document for linter fix               |
| Pre-existing violation from prior API version                        | ✅ Approve; document as technical debt            |
| New resource type, author cannot explain why rule doesn't apply      | ❌ Push to fix                                    |
| Same anti-pattern in preview, not yet in stable                      | ❌ Push to fix now (before GA)                    |
| Anti-pattern replicated from shipped stable version                  | ⚠️ Peer review — weigh consistency vs correctness |
| "No time to fix" / deadline pressure                                 | ❌ Remove suppression, file work item instead     |
| "Back-compat with preview" for GA version                            | ❌ Not sufficient — GA is the deadline            |
| Security-related rule (`secret-prop`, `security-definition-missing`) | ❌ Almost never suppress                          |

### Questions to Ask

1. Is this a new resource type or an existing one?
2. Did this anti-pattern exist in the previous API version?
3. Has this pattern already shipped in a stable (GA) version?
4. What is the specific technical reason the rule doesn't apply here?

---

## DD-007: Resource Move — When to Block

When should a tracked resource type block resource move?

### Valid Justifications for Blocking Move

- Resource has physical infrastructure tied to a specific resource
  group or subscription (e.g., networking peering, cross-RG dependencies)
- Data sovereignty or compliance requirements prevent cross-subscription
  movement
- Resource references other resources by resource group name (not by
  full resource ID) in stored state

### Invalid Justifications

- "We haven't implemented move yet" — implement it
- "Move is complex" — most moves only require updating internal
  resource group references
- "Our customers haven't asked for it" — customers expect all
  tracked resources to be movable

### Questions to Ask

1. Does the resource have physical infrastructure tied to the current scope?
2. Are there cross-resource-group dependencies that cannot be moved atomically?
3. Is move blocked by a compliance requirement (document which one)?

---

## DD-008: Tenant-Level vs. Subscription-Scoped API

When should an API be at tenant level vs. subscription/resource-group scope?

### Factors to Evaluate

| Factor                 | Favors Subscription Scope            | Favors Tenant Level        |
| ---------------------- | ------------------------------------ | -------------------------- |
| RBAC granularity       | Better (per-sub permissions)         | Weaker (broad permissions) |
| Feature flags (AFEC)   | Supported                            | Not supported              |
| Regional compliance    | Supported (resources have locations) | Difficult                  |
| Performance/monitoring | Standard ARM tooling                 | Limited tooling            |
| Resource type          | Tracked (has tags, billing)          | Must be proxy              |

### Recommendation

- **Subscription/RG scope** is strongly preferred — use it unless
  there is a genuine architectural requirement for tenant-level access
- **Tenant level** only when the concept genuinely spans all
  subscriptions (e.g., billing enrollment, org-wide policy)

### Requirements if Tenant Level

- Must be proxy resource (cannot be tracked)
- If using `allowUnauthorizedActions`, requires PAS team security approval
- Must get ARM API review office hours sign-off
- Linter rule `TenantLevelAPIsNotAllowed` will fire — suppression
  requires both (A) ARM sign-off AND (B) PAS approval for unauthorized actions

---

## DD-009: Schema Breaking Changes — Fix Now vs. Deprecate-and-Add

When an existing property has the wrong type, name, or structure,
should it be fixed in place or should a new property be added?

### Decision Matrix

| Scenario                                               | Recommendation                          |
| ------------------------------------------------------ | --------------------------------------- |
| Property only exists in preview, no stable version yet | ✅ Fix in place                         |
| Property exists in GA but has zero customer usage      | ⚠️ Fix in place with deprecation notice |
| Property exists in GA with customer usage              | ❌ Add new property, deprecate old      |
| Type change needed (e.g., string → object)             | ❌ Always add new property name         |
| Name change needed (e.g., `createTime` → `createdAt`)  | Keep both during transition             |

### Breaking Change Rules

- Adding a required property to an existing model → **always breaking**
- Removing a required property → **always breaking**
- Changing property type → **always breaking**
- Changing optional to required → **always breaking**
- Adding an optional property → **not breaking**
- Removing an optional property → **soft breaking** (may break ARG
  queries and Policy aliases; carry forward until deprecated)

### Questions to Ask

1. Has this property shipped in a stable (GA) API version?
2. Do customers reference this property in Policy aliases or ARG queries?
3. Can the migration path be documented in the changelog?

---

## DD-010: Implicit Child Resource Creation

When a parent resource is created via PUT, should the service
automatically create associated child resources (e.g., default
subnets, default configurations)?

### Factors to Evaluate

| Factor                 | Favors Implicit Creation                  | Favors Explicit Creation        |
| ---------------------- | ----------------------------------------- | ------------------------------- |
| User experience        | Simpler for common case                   | User controls everything        |
| ARM hydration          | ❌ Implicit tracked children not hydrated | ✅ All resources visible to ARM |
| Template deployability | Harder to predict state                   | Full control in template        |
| Azure Policy           | Cannot deny implicit children             | Can deny explicit PUT           |
| ARM resource graph     | Implicit children may not appear          | All resources visible           |

### Recommendation

- **MUST NOT** implicitly create **tracked** child resources (hard rule)
- **SHOULD NOT** implicitly create **proxy** child resources
- If implicit creation is needed for UX: expose the child as a
  PUT-able resource with default values, and document the defaults

### Questions to Ask

1. Is the child resource tracked (has `location`)? If yes, cannot be implicit.
2. Can the user accomplish the same thing by explicitly creating the child?
3. Will the implicitly created child be visible in ARM/ARG?
