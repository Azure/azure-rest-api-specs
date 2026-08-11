<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - TypeSpec visibility docs (Lifecycle visibility modifiers)
     Data-plane counterpart to property-mutability.md, which is ARM-specific
     (x-ms-mutability, What-If, Change Analysis). Do not apply that file here. -->

# Data-Plane Visibility and Secrets

Applies to data-plane TypeSpec. Data-plane expresses mutability through
`@visibility(Lifecycle.Read | Lifecycle.Create | Lifecycle.Update)`, not through
`x-ms-mutability`. The ARM reasoning in
[`property-mutability.md`](property-mutability.md) -- What-If noise, ARM Change
Analysis -- does not apply; the underlying principle does.

> **Authoritative upstream:** [field mutability](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-field-mutability),
> [round-trippable resource schemas](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-response-body-is-resource-schema),
> [no secrets in GET responses](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-no-secrets-in-get-response),
> [retrieving secrets through POST](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-secrets-allowed-in-post-response),
> and
> [null response values](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json-null-response-values)
> in the Azure REST API Guidelines. This file maps that wire contract to
> TypeSpec visibility; the upstream Guidelines take precedence.

Secret **detection** signals live in [`secret-detection.md`](secret-detection.md)
and are not restated here. This file covers how visibility and secrecy interact.

---

## DP-VIS-01: No write-only non-secret property

- **Rule ID:** `DP-VIS-01`
- **Severity:** Warning

Upstream anchor: the Azure REST API Guidelines say
:white\*check_mark: **DO** \_use the same JSON schema for PUT request/response,
PATCH response, GET response, and POST request/response on a given URL path …
this allows one SDK type for input/output operations and **enables the response
to be passed back in a request\***
([`rest-response-body-is-resource-schema`](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)).
The round-trip argument below is that clause applied to a single property.
**The rule is this skill's synthesis, so its strength is the `Severity` field
above, not the upstream verb** — a write-only property degrades round-tripping
without breaking the shared schema, so it does not warrant Blocking.

A property accepted on write but never returned on read should be either a
secret or explicitly justified. Otherwise the caller cannot read back what they
configured, cannot diff desired against actual state, and cannot round-trip a
GET into a PUT.

Flag any property with `Lifecycle.Create`/`Lifecycle.Update` but not
`Lifecycle.Read` that is not credential-shaped.

**Legitimate exceptions -- do not flag:**

- Genuine secrets (see `DP-VIS-02`).
- One-shot inputs that are consumed rather than stored -- a
  `confirmationToken`, an idempotency key.
- Inputs whose effect is fully observable through a different, readable property.

## DP-VIS-02: Secrets accepted on write, never returned on read

- **Rule ID:** `DP-VIS-02`
- **Severity:** Blocking

A credential-bearing property **MUST NOT** be readable. Concretely:

- Mark it `@secret`.
- Give it write-only visibility -- `@visibility(Lifecycle.Create, Lifecycle.Update)`
  with no `Lifecycle.Read`.
- Never include a real-looking value in an example.

Flag as Blocking any property whose name matches the credential signals in
[`secret-detection.md`](secret-detection.md) (`key`, `secret`, `password`,
`token`, `credential`, `connectionString`, `sasUri`, `clientSecret`,
`accountKey`) that is readable.

The correct pattern for exposing a credential is a **separate, explicitly
authorized operation** (`:listKeys`, `:getConnectionString`) rather than
inclusion in the resource body -- which also keeps it out of LIST responses,
where secrets leak in bulk.

## DP-VIS-03: Secrets in list responses

- **Rule ID:** `DP-VIS-03`
- **Severity:** Blocking

Even where a single-resource read of a credential is intentional, a **list**
must not return it. Follow the graph: a model used by both `get` and `list`
carries its secret into the list response by default. This is exactly the check
[`think-in-graphs.md`](think-in-graphs.md) is for, and it is invisible when
reading the model definition alone.

## DP-VIS-04: Visibility consistency across a model graph

- **Rule ID:** `DP-VIS-04`
- **Severity:** Warning

Flag:

- A property marked read-only on a parent model but writable on a nested model
  reachable from the same request.
- A required property with `Lifecycle.Read`-only visibility -- required on
  create, but the caller cannot supply it.
- A property that is read-only in one API version and writable in the next with
  no `@added`/`@renamedFrom` explanation (see `DP-VERSION-03`).

## DP-VIS-05: Server-assigned properties

- **Rule ID:** `DP-VIS-05`
- **Severity:** Suggestion

Properties the service assigns -- `id`, `createdAt`, `updatedAt`, `etag`,
`status`, computed counts -- **SHOULD** be `@visibility(Lifecycle.Read)`. If
they are writable, callers will attempt to set them and the service will either
silently ignore the value (confusing) or reject the request (a round-trip
failure from GET to PUT).

## DP-VIS-06: Nullability vs. optionality

- **Rule ID:** `DP-VIS-06`
- **Severity:** Suggestion

`prop?: string` (may be absent) and `prop: string | null` (present, explicitly
no value) mean different things and generate different SDK surfaces. A property
declared as both optional **and** nullable usually indicates the author did not
decide which they meant. Raise it as a question, with the distinction stated.

---

## What this file does not cover

- Whether the service actually rejects writes to read-only properties -- runtime,
  out of scope.
- ARM `x-ms-mutability` and What-If behavior -- see
  [`property-mutability.md`](property-mutability.md), wrong plane.
- `secret-prop` where the linter enforces it (🔒 -- see
  [`data-plane-linter-rule-coverage.md`](data-plane-linter-rule-coverage.md));
  the agent still owns _whether a property is a secret in the first place_,
  which is a naming/semantics judgment no rule makes.
