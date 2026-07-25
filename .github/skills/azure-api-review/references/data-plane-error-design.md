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

The test to apply throughout: **can a caller write code against this error, and
can an on-call engineer diagnose from it?** If the only way to distinguish two
failures is to string-match `message`, the error design has failed.

---

## DP-ERR-01: Stable, documented `code` values

- **Rule ID:** `DP-ERR-01`
- **Severity:** Warning

The `code` field is the machine-readable contract. It **MUST** be:

- **Stable** -- treated as part of the API surface. Changing or removing a
  `code` in a stable version is a breaking change (see `DP-VERSION-01` in
  [`data-plane-resource-modeling.md`](data-plane-resource-modeling.md)).
- **Enumerated and documented** -- the spec, or the operation's `@doc`, should
  say which codes an operation can return. `code: string` with no documentation
  anywhere means callers cannot branch on failure except by string matching.
- **Distinct per condition** -- one `InvalidRequest` code covering eleven
  different validation failures is not actionable.

Flag: an error model with a bare undocumented `code: string`; an operation whose
docs describe failure conditions in prose but never name the corresponding
codes.

### `code` naming

`PascalCase`, no spaces, no punctuation, not a sentence, not an HTTP status
number. `InvalidWidgetName` is a code; `Invalid widget name.` is a message and
`400` is a status.

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
