# Property Mutability Rules (OAPI027, OAPI020, OAPI029)

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

### OAPI020 OpenAPI JSON

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

## General Mutability Guidelines

| Mutability              | OpenAPI JSON                                      | TypeSpec                                          | Meaning                                          |
| ----------------------- | ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------ |
| Read-only               | `"readOnly": true` or `x-ms-mutability: ["read"]` | `@visibility(Lifecycle.Read)`                     | Computed/server-assigned; not settable by client |
| Create-only (immutable) | `x-ms-mutability: ["create", "read"]`             | `@visibility(Lifecycle.Create, Lifecycle.Read)`   | Set once at creation; cannot be updated          |
| Fully mutable           | No annotation needed                              | No annotation needed                              | Create + update + read                           |
| Write-only (forbidden)  | `x-ms-mutability: ["create", "update"]`           | `@visibility(Lifecycle.Create, Lifecycle.Update)` | **Not allowed** except for secrets               |
