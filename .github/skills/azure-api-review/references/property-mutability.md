<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure Resource Provider Contract (RPC) v1.0 — PUT Resource
       - Azure REST API Guidelines (vNext) — JSON
       - ARM Wiki: api_contracts/guidelines/openapi.md (OAPI027, OAPI020, OAPI029, OAPI030, OAPI031, OAPI034)
     The upstream documents always take precedence if there is a conflict. -->

# Property Mutability Rules (OAPI027, OAPI020, OAPI029, OAPI030, OAPI031, OAPI034)

These rules govern how property visibility and mutability must be
consistently applied across Azure API specifications. They prevent ARM
Template What-If noise, ARM Change Analysis false positives, and
inconsistent SDK behavior.

**Authoritative references:**

- [Azure Resource Provider Contract -- PUT Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md)
- [Azure REST API Guidelines -- JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json)

---

## OAPI027: Write-Only Properties Are Forbidden

Properties **MUST NOT** be write-only. Every non-secret property that
can be set on a resource **MUST** also be readable via GET.

**Why:** Write-only properties cause:

- ARM Template What-If to show the property as a diff (noise) because
  it cannot compare the desired state with the current state.
- ARM Change Analysis to flag false changes on every deployment.

**Exception:** Secret properties that are accepted on write but
returned as `null` on read are acceptable. These must use the secret
annotation.

### OpenAPI JSON

A property with `x-ms-mutability: ["create", "update"]` (without `"read"`) is write-only and is **not allowed**.

```json
// BAD - write-only non-secret property
"configValue": {
  "type": "string",
  "x-ms-mutability": ["create", "update"]
}

// GOOD - readable property
"configValue": {
  "type": "string",
  "x-ms-mutability": ["create", "update", "read"]
}

// OK - secret write-only property
"adminPassword": {
  "type": "string",
  "x-ms-secret": true,
  "x-ms-mutability": ["create", "update"]
}
```

### TypeSpec

A property with `@visibility(Lifecycle.Create, Lifecycle.Update)`
(without `Lifecycle.Read`) is write-only and is **not allowed**.

```tsp
// BAD - write-only non-secret property
@visibility(Lifecycle.Create, Lifecycle.Update)
configValue?: string;

// GOOD - readable property (no visibility decorator needed for full mutability)
configValue?: string;

// OK - secret write-only property
@secret
@visibility(Lifecycle.Create, Lifecycle.Update)
adminPassword?: string;
```

---

## OAPI020: No Conditional Read-Only Properties

If a property is `readOnly`, it **MUST** always be `readOnly`. Do not
make the same property conditionally read-only in some scenarios and
read/write in others.

**Why:** Conditional read-only behavior creates inconsistent API
behavior. CLI tools, SDKs, and Azure Policy cannot determine when a
property is writable vs. read-only, leading to confusing error messages
and policy evaluation failures.

**Fix:** Use separate properties for each case rather than making a single property conditionally read-only.

### OAPI020 TypeSpec

```tsp
// BAD - conditionally read-only
@visibility(Lifecycle.Read)  // sometimes writable
status?: string;

// GOOD - separate properties
@visibility(Lifecycle.Read)
status?: string;
desiredStatus?: string;
```

---

## OAPI029: No Conditional Immutable Properties

If a property is immutable (`create + read` only), it **MUST** always
be immutable. Do not make the same property conditionally immutable
based on resource state or other conditions.

**Why:** Same as OAPI020 -- conditional behavior on the same property
creates inconsistent API behavior and confusion for CLI tools, SDKs,
and Azure Policy.

**Fix:** Use separate properties for each case.

### OAPI029 OpenAPI JSON

```json
// GOOD - always immutable
"location": {
  "type": "string",
  "x-ms-mutability": ["create", "read"]
}
```

### OAPI029 TypeSpec

```tsp
// GOOD - always immutable
@visibility(Lifecycle.Create, Lifecycle.Read)
location?: string;
```

---

## OAPI030: PUT/PATCH Must Ignore Immutable Properties When Value Is Unchanged

When a PUT or PATCH request includes an immutable property whose value
matches the current value of the resource, the service **MUST** accept
the request without error.

**Why:** Clients commonly round-trip the GET response back into a PUT
(e.g., ARM template re-deployments). If the service rejects a PUT
because it contains an immutable property — even though the value has
not changed — template re-deployments will fail unnecessarily.

### OAPI030 OpenAPI JSON

```json
// Immutable property — service must accept re-PUT with same value
"location": {
  "type": "string",
  "x-ms-mutability": ["create", "read"]
}
```

### OAPI030 TypeSpec

```tsp
// Immutable property — service must accept re-PUT with same value
@visibility(Lifecycle.Create, Lifecycle.Read)
location?: string;
```

**Severity:** Required

---

## OAPI031: PUT/PATCH Must Reject Changes to Immutable Properties

When a PUT or PATCH request attempts to **change** the value of an
immutable property, the service **MUST** reject the request with an
appropriate error (typically `400 Bad Request` or `409 Conflict`).

**Why:** Immutable properties are contractually set-once. Silently
ignoring a change request would cause the GET response to differ from
what the user intended, leading to What-If noise and customer
confusion.

### How OAPI030 and OAPI031 Work Together

| Scenario                          | Expected Behavior    |
| --------------------------------- | -------------------- |
| Immutable prop in PUT, same value | Accept (ignore prop) |
| Immutable prop in PUT, new value  | Reject with error    |
| Immutable prop absent from PUT    | Accept (no change)   |

**Severity:** Required

---

## OAPI034: Clear Field Ownership

Every property **MUST** have clear ownership — either server-owned
(`readOnly`) or client-owned.

- **Server-owned** properties are computed by the service and **MUST**
  be `readOnly`. The service sets the value; the client reads it.
- **Client-owned** properties are set by the user. The service **MUST
  NOT** silently overwrite or modify client-owned field values.

**Anti-pattern:** A property `size` that the user sets to `100` on
PUT, but the service auto-increases to `200` based on usage. This
overwrites the user's intent and causes What-If to report a false
difference on every deployment.

**Fix:** Use separate properties for each concern:

### OAPI034 OpenAPI JSON

```json
// GOOD — separate client-owned and server-owned properties
"maxSize": {
  "type": "integer",
  "description": "Maximum size configured by the user."
},
"currentSize": {
  "type": "integer",
  "readOnly": true,
  "description": "Current size as reported by the service."
}
```

### OAPI034 TypeSpec

```tsp
// GOOD — separate client-owned and server-owned properties
maxSize?: int32;

@visibility(Lifecycle.Read)
currentSize?: int32;
```

**Severity:** Required

---

## General Mutability Guidelines

| Mutability              | OpenAPI JSON                                      | TypeSpec                                          | Meaning                                          |
| ----------------------- | ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------ |
| Read-only               | `"readOnly": true` or `x-ms-mutability: ["read"]` | `@visibility(Lifecycle.Read)`                     | Computed/server-assigned; not settable by client |
| Create-only (immutable) | `x-ms-mutability: ["create", "read"]`             | `@visibility(Lifecycle.Create, Lifecycle.Read)`   | Set once at creation; cannot be updated          |
| Fully mutable           | No annotation needed                              | No annotation needed                              | Create + update + read                           |
| Write-only (forbidden)  | `x-ms-mutability: ["create", "update"]`           | `@visibility(Lifecycle.Create, Lifecycle.Update)` | **Not allowed** except for secrets               |
