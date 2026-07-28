<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure Resource Provider Contract (RPC) v1.0 — Asynchronous Operations
       - ARM Wiki: api_contracts/guidelines/rpc.md (RPC005)
     The upstream documents always take precedence if there is a conflict. -->

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
- **TypeSpec:** Set `use-read-only-status-schema: true` in the
  `@azure-tools/typespec-autorest` emitter options (default `false`).
  Without it, the `ProvisioningStateMustBeReadOnly` LintDiff check fails. With it, the emitter stamps `readOnly: true`
  onto the status **schema definition** itself, which is what the check inspects. The emitter auto-recognizes a schema
  as an LRO status schema when its members are **named** `Succeeded`, `Failed`, and `Canceled` (which
  `ResourceProvisioningState` supplies);
  See the "`ProvisioningStateMustBeReadOnly` -- Emitter Workaround" section below.

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

---

## `ProvisioningStateMustBeReadOnly` -- Emitter Workaround (`use-read-only-status-schema`)

Apply this whenever a PR **suppresses** the
`ProvisioningStateMustBeReadOnly` linter rule, or whenever **LintDiff
fails** with `ProvisioningStateMustBeReadOnly`. Recommend the emitter
workaround below instead of (or before) adding or keeping a suppression.

**Root cause.** The rule fires because `azure-openapi-validator` and
`oav` ignore siblings of `$ref`. When the emitter produces
`provisioningState` as
`{ "$ref": "#/definitions/ProvisioningState", "readOnly": true }`, the
`readOnly: true` sibling is dropped per JSON Schema semantics, so the
linter sees a `provisioningState` that is not read-only -- even though
the TypeSpec source correctly marks it `@visibility(Lifecycle.Read)`.
References:

- [Troubleshoot: ProvisioningStateMustBeReadOnly (official) -- azure.github.io/typespec-azure](https://azure.github.io/typespec-azure/docs/troubleshoot/status-read-only-error)
- [[ProvisioningStateMustBeReadOnly] Rule ignores siblings of $ref -- Azure/azure-openapi-validator#637](https://github.com/Azure/azure-openapi-validator/issues/637)
- [Support $ref siblings -- Azure/oav#848](https://github.com/Azure/oav/issues/848)
- [Discussion -- Azure/azure-sdk-tools#6191](https://github.com/Azure/azure-sdk-tools/issues/6191)

**Recommended fix (TypeSpec projects).** Add
`use-read-only-status-schema: true` to the `@azure-tools/typespec-autorest`
emitter options in `tspconfig.yaml`. With this option the emitter
generates a dedicated read-only status schema (without the
`$ref`-sibling `readOnly` pattern) that the linter recognizes, so the
suppression is no longer needed:

```yaml
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
    emitter-output-dir: "{project-root}/.."
    examples-directory: examples
    output-file: "{azure-resource-provider-folder}/{service-name}/{version-status}/{version}/<service>.json"
    omit-unreachable-types: true
    use-read-only-status-schema: true
```

Only the `use-read-only-status-schema: true` line is required; the
surrounding keys are the emitter block the project typically already
has. If the project's `tspconfig.yaml` has no
`@azure-tools/typespec-autorest` options block, add one.

**The ARM scaffolding template enables this option automatically**, so a
failing check usually means an older or hand-configured `tspconfig.yaml`.

**How recognition works (and a silent-failure trap).** With the option on,
the emitter stamps `readOnly: true` onto any `enum`/`union` it recognizes as
an LRO status schema. Recognition is **by member name**: the members must be
named `Succeeded`, `Failed`, and `Canceled` (the emitter matches the
member/variant name, not its value), which `ResourceProvisioningState`
supplies. `@Azure.Core.lroStatus` does **not** participate -- adding it
changes nothing.

**How to apply during review:**

- **Suppression present (new or carried-over):** recommend adding
  `use-read-only-status-schema: true`, then -- once the swagger is
  regenerated -- removing the `ProvisioningStateMustBeReadOnly`
  suppression (subject to the removal-safety rule
  RPC-SUPPRESS-REMOVE-SAFELY). Note it is a **project-wide** option, so
  it clears every `ProvisioningStateMustBeReadOnly` suppression in the
  project, not just the one under review.
- **LintDiff failure with no suppression yet:** recommend the emitter
  option as the fix rather than adding a suppression.
- **Handwritten OpenAPI (no TypeSpec):** the emitter option does not
  apply. Inline the enum (drop the `$ref`) or wrap it in `allOf` so
  `readOnly: true` is honored on the emitted schema.
