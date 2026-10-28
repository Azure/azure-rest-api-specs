<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext) -- Processing a request / errors
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - Azure.Core.Foundations.Error / ErrorResponse (typespec-azure-core)
     The upstream documents always take precedence if there is a conflict.
     This is the lowest-lint-coverage area in the Guidelines and therefore the
     highest-value agent-owned area. -->

# Data-Plane Error Design

Applies to data-plane TypeSpec. This is the area with the **least** mechanical
coverage: the azure-core linter checks that responses use the standard error
envelope (`Azure.Core.Foundations.ErrorResponse`), and nothing checks whether
the errors inside it are actually useful. Error quality is almost entirely
agent-owned.

> **Authoritative upstream:** [error response structure](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-response-body-structure),
> [documented error codes](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-document-error-code-values),
> [diagnostic fields](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-non-api-contract-fields),
> and
> [default error responses](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-error-use-default-response)
> in the Azure REST API Guidelines. This file adds reviewer-oriented tests for
> error quality; the upstream Guidelines take precedence.

The test to apply throughout: **can a caller write code against this error, and
can an on-call engineer diagnose from it?** If the only way to distinguish two
failures is to string-match `message`, the error design has failed.

---

## DP-ERR-01: Stable, distinguishable `code` values

- **Rule ID:** `DP-ERR-01`
- **Severity:** Warning — **except trigger 3 (enumeration), which is capped at
  Question.** The field is the maximum for the rule; an individual trigger may
  be capped lower, never higher.

The `code` field is the machine-readable contract. Three triggers, with
different strengths, because they are not equally reliable to judge from a spec.

| #   | Trigger                                                                                                         | Severity     | Judge from the spec?                  |
| --- | --------------------------------------------------------------------------------------------------------------- | ------------ | ------------------------------------- |
| 1   | `code` values are unusable as discriminators -- free-form prose, numeric, locale-dependent, or not `PascalCase` | Warning      | Yes -- visible in the declared values |
| 2   | One code covers many distinct failures (`InvalidRequest` for eleven validation errors)                          | Warning      | Yes, where the codes are declared     |
| 3   | Distinct failure conditions are named, but no codes distinguish them                                            | **Question** | Only partly -- see below              |

**Trigger 1 -- unusable values.** `PascalCase`, no spaces, no punctuation, not a
sentence, not an HTTP status number. `InvalidWidgetName` is a code;
`Invalid widget name.` is a message and `400` is a status. Codes are also
**stable**: changing or removing one in a stable version is a breaking change
(see `DP-VERSION-01` in
[`data-plane-resource-modeling.md`](data-plane-resource-modeling.md)).

**Trigger 2 -- one code, many conditions.** Not actionable; the caller cannot
tell what to do differently.

**Trigger 3 -- enumeration. Narrow, and a Question.** Flag only when the spec
**names distinct failure conditions requiring different caller remediation** and
enumerates no codes that would let a caller tell them apart. The defect is the
gap between "this operation fails in these several distinguishable ways" and
"here is nothing to branch on" -- **not** the shape of the error model. Ask;
do not assert. The author knows whether those conditions are actually distinct
to a caller, and you are inferring it from prose.

> **Where trigger 3's output goes.** Question is a severity in
> [`data-plane-report-format.md`](data-plane-report-format.md), and it has a
> form: a plain bullet in the `### Questions` section, **never** a bracketed
> `**[DP-ERR-01] ...**` finding. So a trigger-3 observation is written:
>
> ```markdown
> ### Questions
>
> - `submitInvoice` documents three distinct failures (`inv.tsp:74`) but the
>   error model enumerates no codes to tell them apart. Are these meant to be
>   distinguishable programmatically, or is the distinction only for humans?
> ```
>
> Triggers 1 and 2 are Warning and **are** bracketed findings. One rule, two
> emission forms, decided by which trigger fired -- read the trigger table
> before writing.

> **`Azure.Core.Foundations.Error` is never by itself a finding.** Its `code`
> field is declared `code: string`, documented "One of a server-defined set of
> error codes" -- verified in `typespec-azure-core` 0.70.0,
> `lib/foundations.tsp`. Any spec using the standard Azure.Core error envelope
> therefore has an unenumerated `code` **by construction**. A trigger that fires
> on that fires on the platform, and on roughly 20 of 23 shipped data-plane
> service groups. Only three (cognitiveservices Language, storage, translation)
> bind a typed `union ErrorCode`, so the typed form is the corpus exception, not
> the norm.

**Do not flag** a bare `code: string`, an unmodified Azure.Core error envelope,
or the absence of a typed `union ErrorCode`. Those are the ordinary state of a
conforming data-plane spec.

### The upstream tension -- do not "fix" this back

Trigger 3 used to flag any undocumented `code: string` at Warning. That was
mis-scoped, and the Guidelines point the other way on **venue**:

> :warning: **YOU SHOULD NOT** document specific error status codes in your
> OpenAPI/Swagger spec unless the `default` response cannot properly describe
> the specific error response.

(`rest-error-use-default-response`.) A single `default` error response is the
**correct** shape, and real services publish their code strings in
documentation rather than in the `.tsp`. The absence of enumerated codes in a
spec is therefore frequently conformance, not a defect.

A future maintainer may be tempted to restore the stronger trigger. Do not: it
would fire on the platform's own primitive and on nearly every shipped service.

## DP-ERR-02: `target` identifies what failed

- **Rule ID:** `DP-ERR-02`
- **Severity:** Suggestion

When an error concerns a specific input, `target` **SHOULD** name it -- the
property path or parameter name. Without it, a caller submitting a body with
thirty properties learns only that something in it was wrong.

Flag when an error model omits `target` entirely and the operation takes a
structured request body.

## DP-ERR-03: Actionable messages

- **Rule ID:** `DP-ERR-03`
- **Severity:** Suggestion

`message` is for humans and **SHOULD** state what was wrong _and_ what to do.
Where the spec or examples show message text, flag:

- Messages that restate the code with spaces (`code: InvalidName`,
  `message: "Invalid name"`) -- zero added information.
- Messages that leak internals: stack traces, SQL, internal hostnames, GUIDs
  with no explanation, exception class names.
- Messages containing secrets or credentials -- escalate to Blocking and
  cross-reference [`secret-detection.md`](secret-detection.md).
- Messages that are not localizable because they are assembled from fragments.

## DP-ERR-04: `innererror` for sub-classification

- **Rule ID:** `DP-ERR-04`
- **Severity:** Suggestion

Additional specificity belongs in `innererror`, which nests to arbitrary depth
with its own `code`. This lets a caller branch coarsely on the outer code and
finely on the inner one without the outer code set exploding.

Raise when a spec has a large flat code set that clearly has structure
(`InvalidWidgetName`, `InvalidWidgetSize`, `InvalidWidgetColor` --
`InvalidWidget` + `innererror.code`).

## DP-ERR-05: One error envelope per service

- **Rule ID:** `DP-ERR-05`
- **Severity:** Warning

All operations in a service **MUST** use the same error model. A service where
some operations return `Azure.Core.Foundations.ErrorResponse` and others return
a hand-rolled `{ errorMessage: string }` produces SDKs with two unrelated
exception types. Flag any bespoke error model; name the standard one in the fix.

## DP-ERR-06: Status-code selection is shape, not behavior

- **Rule ID:** `DP-ERR-06`
- **Severity:** Suggestion

Review only what the spec declares:

- A create/update operation declaring no `409` where a uniqueness constraint is
  documented.
- An operation declaring `200` for a create that should be `201`.
- An operation declaring `500` as a documented, expected response.

Do **not** review conditional runtime status selection -- for example the
Guidelines' "return 403 rather than 404 when 404 would leak existence". Whether
the service does that is invisible in a `.tsp` and is explicitly out of scope
(🚫 Runtime).

---

## What this file does not cover

- The error envelope structure itself where the linter enforces it (🔒).
- Whether the service actually returns the codes it documents -- runtime.
- Retry semantics, `Retry-After` values, throttling behavior -- runtime.
- ARM error-response conventions -- wrong plane.
