# Classification

For each violation decide one of three labels, and always record the **evidence**.

| Label            | Meaning                                                                                                                                           | Action                                                |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| `user-error`     | The flagged encoding genuinely differs from what the author intended on the wire. The rule caught a real modeling bug.                            | Suppress in-place with the requester's justification. |
| `false-positive` | The encoding matches the author's intent; the rule's expectation is wrong (too strict, wrong comparison target, legacy pattern it doesn't model). | Do **not** suppress. Report so the rule can be fixed. |
| `indeterminate`  | Intent cannot be established from available evidence.                                                                                             | Do **not** suppress. Report as indeterminate.         |

## General procedure

1. Start from the **ground-truth** row (actual vs expected the rule computed).
2. Determine **author intent** — what the operation is supposed to return / do on
   the wire — from, in order of strength:
   - the generated **Swagger** (what clients actually see);
   - the **spec source** (declared responses, `LroHeaders`, template used, doc
     comments, existing suppressions/comments explaining intent);
   - the **rule's PR** (description, message text, and especially its test cases,
     which encode intended pass/fail examples);
   - **repo conventions** and the requester's stated policy.
3. Compare intent to the encoding:
   - encoding ≠ intent → **user-error**;
   - encoding = intent but rule flagged it → **false-positive**;
   - intent unclear / conflicting → **indeterminate**.
4. When the requester states a policy directive ("actions must return their
   intended response type", "delete must be void"), treat it as ground truth for
   intent and apply it uniformly — don't re-litigate each instance.

## Worked example: `lro-response-mismatch`

The procedure above is rule-agnostic. This section applies it to one concrete
rule as an illustration — the same steps (ground truth → intent → compare →
classify → fix/suppress) transfer to any rule; only the rule's contract and the
"expected" convention change.

This rule compares an ARM LRO's **encoded `finalResult`** (from `getLroMetadata`)
against the expected result for the operation shape. Establish the encoded
`finalResult` from `getLroMetadata` (instrument the rule if needed) — **do not
guess it** from the source. Policy used to classify:

- **PUT / PATCH must resolve `finalResult` to the resource type.**
  - `finalResult = void` (custom `LroHeaders`/response dropped
    `FinalResult=<resource>`) → **user-error**: the LRO yields no resource.
  - `finalResult` = a _different_ named type than the resource (e.g. a sub-resource
    `PrivateEndpointConnection` on an interface whose resource is the parent) →
    **user-error**: the operation should resolve to the resource it is modeled on;
    fix by modeling the create on the correct resource or setting `FinalResult`.
  - `finalResult` = the resource type → pass. A **false-positive** would require the
    rule to flag a PUT/PATCH whose `finalResult` _actually equals_ the resource type.
- **DELETE must be void on the wire.**
  - `finalResult` is anything non-void — `OperationStatusResult`, a named result
    model, a resource type, or `unknown` (e.g. a body-returning delete kept for
    backward compatibility) → **user-error**: delete LROs must resolve to `void`;
    suppress the deliberate deviation, or drop the body (a breaking change).
  - A **false-positive** would require the rule to flag a delete whose `finalResult`
    is _actually_ `void`.
- **POST actions must return their intended response.** Intent comes from **either**
  the operation template's `Response` parameter **or** the declared 200 response
  body (a 204 / no-body action → `void`). POST is the only shape with genuine
  wiggle room, so check both signals.
  - `finalResult = void` while a non-void `Response`/200 body is declared (often a
    custom `LroHeaders`/`final-state-via` that drops the body) → **user-error**: the
    action delivers nothing. Fix by using the standard template or setting
    `FinalResult=<Response>` on the intended terminal header.
  - `finalResult` = an `ArmResponse<T>` **envelope** (including a named alias like
    `ArmXResponse is ArmResponse<T>`) passed as `Response`, while the intended
    payload is the bare `T` → **user-error**: the envelope carries HTTP
    status/headers; the intended `finalResult` is `T`. Fix by passing `Response = T`
    (`ArmResourceActionAsync` already wraps it in the 200 envelope). This is the rule
    acting as intended, **not** a false positive, even though the envelope's wire
    body is `T`.
  - POST declares both a 200-with-body and a 204 → **user-error** (`conflicting
responses`): keep one terminal shape.
  - A **false-positive** would require the rule to flag a POST whose `finalResult`
    _actually equals_ its intended response (template `Response` param or 200 body).

The transferable lesson: a **false-positive means the encoding already matches the
convention but the rule fired anyway** (a computation bug) — e.g. it would have to
flag an actually-void delete or an actually-resource PUT. An author _intending_ to
encode a non-idiomatic value (body-returning delete, envelope-as-`Response`,
sub-resource PUT) is a **user-error**, not a false positive. Decide from **what the
wire response is meant to be** (Swagger + source + `getLroMetadata` + the
requester's policy), not from the rule alone.
