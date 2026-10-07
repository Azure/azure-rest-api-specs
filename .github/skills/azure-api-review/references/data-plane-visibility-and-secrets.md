<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-13
     Derived from the Azure REST API Guidelines (vNext) and TypeSpec lifecycle
     visibility guidance. Upstream documents take precedence. -->

# Data-Plane Visibility and Secrets

Data-plane TypeSpec expresses request/response visibility through
`Lifecycle.Read`, `Lifecycle.Create`, and `Lifecycle.Update`. Review semantic
exposure and model reachability, not local decorator syntax.

> **Authoritative upstream:** [field mutability](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-field-mutability),
> [round-trippable schemas](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-response-body-is-resource-schema),
> [no secrets in GET responses](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-no-secrets-in-get-response),
> and
> [retrieving secrets through POST](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-secrets-allowed-in-post-response).

## TypeSpec mapping

- `@visibility(Lifecycle.Read)` is response-only; `Lifecycle.Create` and
  `Lifecycle.Update` permit request use. Excluding `Lifecycle.Read` makes a
  property write-only.
- Mark credential-bearing properties with `@secret` and write-only visibility:
  `@visibility(Lifecycle.Create, Lifecycle.Update)`.
- Evaluate effective visibility through every request, GET, and LIST model that
  can reach the property.

Use [`secret-detection.md`](secret-detection.md) to decide whether a property is
credential-bearing.

## DP-VIS-01: Stored non-secret properties should round-trip

- **Severity:** Warning.

Flag a durable non-secret property accepted on create/update but never returned
on read when no documented semantic reason explains the write-only behavior.

Do not flag secrets, one-shot tokens, idempotency inputs, or consumed values
whose effect is fully represented by a different readable property.

## DP-VIS-02: Credentials must not be readable

- **Severity:** Blocking.
- **Strength:** `DO NOT` return secrets from GET responses.

Flag a credential-bearing property that is reachable from GET or ordinary
resource responses. The fix should mark the value as secret, remove read
visibility, and expose intentional retrieval only through a separately
authorized operation. In TypeSpec, use `@secret` and write-only lifecycle
visibility for the credential-bearing property.

Property names such as `password`, `token`, `credential`, `connectionString`,
`sasUri`, `clientSecret`, and `accountKey` are signals, not proof. Confirm the
documented semantics before reporting.

## DP-VIS-03: LIST responses must not expose secrets

- **Severity:** Blocking.

Follow model reachability. A shared model may carry a secret into a LIST response
even when the changed property is declared far from the list operation.

## DP-VIS-04: Visibility must remain coherent across a model graph

- **Severity:** Warning.

Flag the same semantic property being writable through one reachable model and
read-only through another, or a required request property that callers cannot
supply because its effective visibility is read-only.

Do not report basic key-visibility or decorator-usage diagnostics already
produced mechanically.

## Out of scope

- Server-assigned-property suggestions and optional-vs-nullable questions.
- Whether the running service rejects writes to read-only properties.
- Authentication declaration presence and authorization enforcement.
- ARM `x-ms-mutability`, What-If, and Change Analysis behavior.
