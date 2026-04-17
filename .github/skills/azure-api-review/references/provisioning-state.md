<!-- Upstream alignment: 2026-04-15
     This date is for maintainers of this file only -- it records when
     rules were last verified against upstream docs. No action is needed
     by spec authors or PR reviewers. -->

# Provisioning State Requirements

The `provisioningState` property is a critical ARM contract element
that represents the status of the latest long-running PUT, PATCH, or
DELETE operation on a resource.

**Authoritative references:**

- [Azure Resource Provider Contract -- Asynchronous Operations][rpc-async]
  (RPC-Async-V1-02, RPC-Async-V1-03, RPC-Async-V1-16)
- [Azure REST API Guidelines -- Long-Running Operations](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#long-running-operations--jobs)

[rpc-async]: https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/async-api-reference.md

---

## When Required

A resource that supports at least one asynchronous verb (PUT or PATCH)
**MUST** contain a `provisioningState` property in its model
(RPC-Async-V1-02).

## Terminal States (Required)

`provisioningState` **MUST** include the terminal states:

- `Succeeded`
- `Failed`
- `Canceled` (with a single 'l' -- **NOT** "Cancelled")

If no `provisioningState` is returned in a response, ARM assumes `Succeeded`.

## Must Be Read-Only

`provisioningState` **MUST** be marked as read-only:

- **OpenAPI JSON:** `"readOnly": true`
- **TypeSpec:** `@visibility(Lifecycle.Read)`

If a user includes `provisioningState` in a PUT request body (e.g.,
after a GET round-trip), the RP **MUST** treat it as read-only. If the
provided value matches the current value, ignore it. If it does not
match, reject with `400 Bad Request`.

## What It Represents

`provisioningState` represents the status of the
**latest long-running PUT, PATCH, or DELETE** operation only.
It does **NOT** represent:

- The overall health of the resource
- The functional/runtime state (use a separate property like `status` or `powerState`)
- The result of POST actions (POST actions do **not** affect `provisioningState`)

## Non-Terminal States

RP-defined non-terminal states are allowed (e.g., `"Creating"`,
`"Updating"`, `"Deleting"`, `"Accepted"`). Any state other than
`Succeeded`, `Failed`, and `Canceled` is considered non-terminal.

## Transition Rules (RPC-Async-V1-16)

- `provisioningState` can move from **non-terminal to non-terminal** or **non-terminal to terminal**.
- It **MUST NOT** transition directly from one terminal state to
  another without an intervening non-terminal state (which would be
  set by a new operation).

## Invalid Values

`provisioningState` **MUST NOT** include:

- `Deleted` -- a deleted resource returns 404, not a provisioningState
- `NotSpecified` -- internal sentinel with no customer-facing purpose
- Operational states like `Stopped`, `Running`, `Paused` -- these
  represent runtime state, not provisioning state. Use a separate
  property.

---

## Format-Specific Guidance

### OpenAPI JSON

```json
"provisioningState": {
  "type": "string",
  "readOnly": true,
  "description": "The provisioning state of the resource.",
  "enum": ["Succeeded", "Failed", "Canceled", "Creating", "Updating", "Deleting"],
  "x-ms-enum": {
    "name": "ProvisioningState",
    "modelAsString": true
  }
}
```

### TypeSpec

Use a union that extends
`Azure.ResourceManager.ResourceProvisioningState` for the terminal
states, then add custom non-terminal states:

```tsp
/** The provisioning state of the resource. */
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}
```

The `string` base type is included via `ResourceProvisioningState` to keep the enum extensible.

**Reference:** [TypeSpec Azure -- Resource Provisioning State](https://azure.github.io/typespec-azure/docs/howtos/arm/resource-operations)
