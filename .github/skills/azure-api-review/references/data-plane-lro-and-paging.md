<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext) -- Long-Running Operations & Jobs,
         Collections & Pagination
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - TypeSpec Azure library docs (Azure.Core LRO and paging templates)
     The upstream documents always take precedence if there is a conflict.
     Rules here are agent-owned; do not restate what
     `long-running-polling-operation-required` already enforces. -->

# Data-Plane Long-Running Operations and Pagination

Applies to data-plane TypeSpec. The ARM control-plane equivalents --
`x-ms-long-running-operation-options`, `final-state-via`,
`Azure-AsyncOperation` -- are documented in
[`lro-final-state-via.md`](lro-final-state-via.md) and **do not apply here**.
Data-plane services poll via `Operation-Location` and a status monitor
(`openapi-review.instructions.md` §21).

> **Authoritative upstream:** [LRO response time](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-response-time),
> [status monitor structure](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-status-monitor-structure),
> [polling behavior](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-poll),
> [server-driven paging](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-support-server-driven-paging),
> [consistent paging options](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-consistent-options-with-pagination),
> and
> [`maxpagesize`](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-maxpagesize-param)
> in the Azure REST API Guidelines. TypeSpec-specific status-monitor metadata is
> defined by the
> [Azure.Core LRO decorators](https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference/decorators/#Azure.Core.lroErrorResult).
> The upstream wire contract and TypeSpec decorator reference take precedence.

`@azure-tools/typespec-azure-core/long-running-polling-operation-required`
enforces that an LRO _has_ a linked polling operation. It does not judge whether
the status monitor is usable, whether terminal states are complete, or whether
paging is consistent. That is this file.

---

## LRO

### DP-LRO-01: Status monitor completeness

- **Rule ID:** `DP-LRO-01`
- **Severity:** Warning

The status monitor returned by the polling operation **MUST** let a caller
determine, without out-of-band knowledge:

1. Whether the operation is still running, succeeded, or failed -- via a
   `status` property whose union includes at minimum `NotStarted`/`Running`,
   `Succeeded`, `Failed`, `Canceled`.
2. **Why** it failed -- an `error` property using the standard error model (see
   [`data-plane-error-design.md`](data-plane-error-design.md)). A status monitor
   that can reach `Failed` with no way to surface the reason is a 3am problem;
   flag it.
3. Where the result is, if the operation produces one -- a `result` property, or
   a documented resource URL.

Flag a status monitor whose `status` union has only `Succeeded`/`Failed`, or
that has no `error` member.

### DP-LRO-02: Should this even be an LRO?

- **Rule ID:** `DP-LRO-02`
- **Severity:** Suggestion

An operation that completes in well under a second is not a long-running
operation, and modeling it as one imposes polling on every caller and every
SDK. Conversely, an operation that can take minutes but is modelled
synchronously will time out at gateways and give callers no progress signal.

Raise as a question when the shape looks mismatched -- for example, a `:validate`
action modelled as an LRO, or a `:trainModel` action modelled synchronously.
This is a judgment call; never blocking.

### DP-LRO-03: Cancellation and terminal-state reachability

- **Rule ID:** `DP-LRO-03`
- **Severity:** Suggestion

If the `status` union includes `Canceled`, there **SHOULD** be an operation that
causes cancellation. A terminal state no caller can reach is either dead surface
or an undocumented capability. Flag the mismatch in either direction:

- `Canceled` in the union with no cancel operation.
- A cancel operation with no `Canceled` state in the union.

### DP-LRO-04: Polling linkage

- **Rule ID:** `DP-LRO-04`
- **Severity:** Warning

Verify `@pollingOperation` points at an operation that actually returns the
status monitor, and `@finalOperation` (when present) at one that returns the
final result. A linkage that compiles but points at the wrong operation produces
an SDK poller that never terminates -- the linter checks that a link exists, not
that it is correct.

### DP-LRO-05: Custom status monitors -- the parts the linter does not check

- **Rule ID:** `DP-LRO-05`
- **Severity:** Suggestion
- **Upstream:** [status monitor structure](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-status-monitor-structure)
  in the Azure REST API Guidelines and the
  [Azure.Core LRO decorators](https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference/decorators/#Azure.Core.lroErrorResult)

A service with a hand-rolled status monitor -- typically a grandfathered LRO --
must tell the emitters how to read it, or the shape is legible to a human and
opaque to every SDK generator.

**Most of this is linter-owned; check before reporting.** Verified empirically
against `@azure-tools/typespec-azure-core` 0.70.0: a monitor whose status union
uses a bespoke vocabulary (`Finished`/`Broken`/...) and marks nothing fails
compilation with `lro-status-missing` (**error**) plus
`polling-operation-no-status-monitor` (warning). A service therefore cannot ship
a custom monitor without either `@lroSucceeded`/`@lroFailed` or the literal
`Succeeded`/`Failed` values the linter recognizes by name. **Never raise a
finding for a missing `@lroSucceeded` or `@lroFailed`** -- it is 🔒, the build
has already failed, and repeating it helps nobody.

What the linter does **not** check, and you therefore own:

| Decorator         | Applies to                     | Marks                           |
| ----------------- | ------------------------------ | ------------------------------- |
| `@lroCanceled`    | `EnumMember` \| `UnionVariant` | the terminal cancellation state |
| `@lroResult`      | `ModelProperty`                | the result on success           |
| `@lroErrorResult` | `ModelProperty`                | the error on failure            |

All sit in the `Azure.Core` namespace alongside the linter-enforced
`@lroStatus`, `@lroSucceeded` and `@lroFailed`.

Raise, at Suggestion severity:

- A status union with a cancellation state that is not marked `@lroCanceled`.
  It compiles clean, and a generated poller treats cancellation as an
  unrecognized non-terminal state -- so the poller hangs on a canceled
  operation.
- A monitor producing a result or an error with no `@lroResult` /
  `@lroErrorResult`, so neither is typed for the SDK. This overlaps
  `DP-LRO-01`; report it once, under whichever rule fits better.

Never Blocking: an existing service's monitor is usually grandfathered and
changing it is breaking. For a genuinely new service, note once that the
standard `Azure.Core` LRO templates provide all of this by construction.

---

## Pagination

### DP-PAGE-01: List operations are paged

- **Rule ID:** `DP-PAGE-01`
- **Severity:** Warning

Any operation returning a collection **SHOULD** be paged, using the `Azure.Core`
paging templates so the response carries `value` and `nextLink`.

The upstream Guideline states this conditionally, verbatim:

> :ballot_box_with_check: **YOU SHOULD** support paging today **if there is
> ever a chance in the future that the number of items can grow to be very
> large.**

The condition is part of the rule. A collection the service fixes -- supported
languages, regions, a documented and small sub-collection -- does not meet it,
so an unpaged list there is **not a violation** and there is nothing to report.

**The condition is "can it _ever_ grow very large", and nothing else.** That is
the only question a rationale has to answer. Arguments that do not answer it
earn no exception however well made:

| Argument                                               | Why it does not answer the condition    |
| ------------------------------------------------------ | --------------------------------------- |
| "99.9% of requests return fewer than 250 items"        | Typical size, not maximum size.         |
| "A snapshot is atomic; a cursor would let ranks shift" | Consistency, a different subject.       |
| "Avoiding cursor state keeps the common path simple"   | Implementation cost, not size.          |
| "The collection is capped at 200 by service policy"    | **Answers it.** Bounded, so no finding. |

**Check the rest of the spec for evidence against the rationale.** A
`...TooLarge` error, a `maxResults` cap that can be raised, or a documented
truncation behavior is the service's own statement that the collection can grow
-- and it outweighs a paragraph asserting that it usually does not.

**Do not flag** a non-paged list when the collection is provably bounded and
small, and **do not flag it merely because the bound is stated in a `@doc`
rather than enforced by the type system** -- a documented bound is exactly the
evidence this exception asks for, because a bound is an answer to the condition.
Judge whether the stated bound is **credible**; if it is, stay silent. If you
doubt it, ask a question at Suggestion severity rather than asserting a
violation. A reviewer that demands paging on every array is the archetypal noisy
bot.

Signals that paging is genuinely missing:

- The collection is customer-populated, so its size is unbounded by definition.
- **The operation is a search or query.** A search over customer data is
  unbounded by construction: the caller chooses the predicate, so the service
  cannot bound the result set. Treat a rationale that argues typical result size
  here as failing the condition -- it is describing the common case of an
  unbounded set, not bounding it.
- A sibling list operation on the same service **is** paged -- inconsistency
  within one service is the strongest signal.

### DP-PAGE-02: Paging consistency across sibling operations

- **Rule ID:** `DP-PAGE-02`
- **Severity:** Warning

All list operations within one service **MUST** use the same paging shape. Mixed
shapes -- one operation with `nextLink`, another with a `continuationToken`
property, a third with `skip`/`top` -- produce SDKs where each list behaves
differently. This is invisible in a single-operation read and obvious in the
graph pass.

### DP-PAGE-03: Paging parameters

- **Rule ID:** `DP-PAGE-03`
- **Severity:** Suggestion
- **Upstream:** [`maxpagesize` parameter](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-maxpagesize-param)
  and
  [`maxpagesize` definition](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-maxpagesize-definition)

- `maxpagesize` is the Guidelines-sanctioned page-size parameter; flag
  `pageSize`, `limit`, `count`, `top` as alternatives that will read as
  inconsistent against other Azure services.
- A `skip`-based pager over a mutable collection has correctness problems
  (items shift between pages). Raise it as a question when the collection is
  mutable.

Note that the **behavior** of paging -- whether ordering is stable across pages,
whether the service honors the requested `maxpagesize`, how long a `nextLink`
remains valid -- is runtime behavior and is out of scope. Flag the shape, never
the behavior.

---

## What this file does not cover

- `long-running-polling-operation-required` itself (🔒 linted -- agent silent).
- `Azure-AsyncOperation`, `final-state-via`, ARM async contract -- wrong plane.
- Runtime polling intervals, `Retry-After` values, status-monitor retention
  windows, ordering stability -- 🚫 Runtime, out of scope.
