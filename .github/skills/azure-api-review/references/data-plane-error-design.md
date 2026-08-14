<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-13
     Derived from the Azure REST API Guidelines (vNext), Processing a request /
     errors. Upstream documents take precedence. -->

# Data-Plane Error Design

Review whether callers can branch on errors and diagnose them. Do not report
the standard error-envelope shape when deterministic tooling already does.

> **Authoritative upstream:** [error response structure](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-response-body-structure),
> [documented error codes](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-document-error-code-values),
> [diagnostic fields](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-non-api-contract-fields),
> and
> [default error responses](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-use-default-response).

## TypeSpec mapping

- Use `Azure.Core.Foundations.ErrorResponse` or
  `ErrorResponseBase<TError>` as the service error envelope.
- The standard `Error` contract provides `code`, `message`, `target`, `details`,
  and `innererror`. A plain `code: string` is intentionally extensible.
- Use one compatible error envelope across the service; specialize its error
  type rather than inventing unrelated response shapes per operation.

## DP-ERR-01: Error codes must be stable and distinguishable

- **Severity:** Warning.

Flag declared code values that are free-form prose, numeric HTTP statuses,
locale-dependent text, or otherwise unusable as stable programmatic
discriminators. Also flag one generic code used for several explicitly distinct
failures that require different caller remediation.

Do not flag `Azure.Core.Foundations.Error.code: string`, a bare `code: string`,
or the absence of a typed error-code union. The standard Azure envelope is
intentionally open, and specific values are often documented outside TypeSpec.

Changing or removing a published code in a stable version is also
`DP-VERSION-01`.

## DP-ERR-02: Target should identify the failing input

- **Severity:** Suggestion.

When a declared error concerns one request property or parameter, its `target`
should identify that input. Raise a finding only when the specification defines
the error condition and omits the target; do not infer runtime error behavior.

## DP-ERR-03: Declared messages must be actionable and safe

- **Severity:** Suggestion; secret disclosure is Blocking.

Where examples or declared values expose message text, flag messages that only
repeat the code, leak implementation details, contain credentials, or give no
caller action. Do not speculate about message text absent from the spec.

## DP-ERR-04: Related error codes should have useful hierarchy

- **Severity:** Suggestion.

Use `innererror` when a large flat code set clearly contains stable
subclassification. Raise this only when the declared codes expose the hierarchy;
do not ask authors to invent one from undocumented runtime conditions.

## DP-ERR-05: A service needs one error contract

- **Severity:** Warning.

Flag operations in the same service that return incompatible error envelopes.
Name the standard error model in the fix. This requires a service-wide
comparison, not a local shape complaint.

## Out of scope

- Whether the service returns the documented code at runtime.
- Conditional 403/404 behavior, throttling, `Retry-After`, and retry semantics.
- The mechanically validated standard envelope shape.
- Questions about failure conditions not represented in the specification.
