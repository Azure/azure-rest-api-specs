<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-13
     Derived from the Azure REST API Guidelines (vNext) and TypeSpec Azure LRO
     and paging guidance. Upstream documents take precedence. -->

# Data-Plane Long-Running Operations and Paging

Review semantic relationships that deterministic checks cannot decide. Do not
repeat basic missing-link, missing-status, or invalid-template diagnostics.

> **Authoritative upstream:** [LRO response time](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-response-time),
> [status monitor structure](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-status-monitor-structure),
> [polling behavior](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-poll),
> [server-driven paging](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-support-server-driven-paging),
> and
> [consistent paging options](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-consistent-options-with-pagination).

## TypeSpec mapping

- Data-plane LROs use `Operation-Location` and a status-monitor operation.
  `@pollingOperation(op)` links the initiating operation to that monitor;
  `@finalOperation(op)` links a final resource or result operation.
- `@lroStatus` marks the status property.
  `@lroSucceeded`, `@lroFailed`, and `@lroCanceled` mark terminal variants.
  `@lroResult` and `@lroErrorResult` mark success and failure payloads.
- Paged response models mark the item collection with `@pageItems` and the
  continuation URL with `@nextLink`.
- Missing or invalid required LRO/paging metadata is a compiler/linter concern.
  Review the semantic relationships described below.

## DP-LRO-01: A status monitor must expose failure and result semantics

- **Severity:** Warning.

The monitor contract is status plus an error on failure and a result or result
resource on success. Flag a monitor that can reach failure but exposes no error
payload, or reaches success but provides neither a result payload nor a
documented final resource when the operation produces one. For a custom monitor,
`@lroErrorResult` and `@lroResult` identify those payloads.

Do not report missing status properties, terminal-state values, or other basic
metadata already diagnosed by TypeSpec tooling.

## DP-LRO-03: Cancellation must be coherent

- **Severity:** Suggestion.
- **Strength:** `YOU SHOULD` represent cancellation coherently when the API
  exposes a cancel operation.

Flag a public cancel operation whose monitor has no `@lroCanceled` terminal
state. Do not infer that callers need a cancel operation merely because a
standard or custom status union includes an `@lroCanceled` state.

Do not speculate about whether runtime cancellation is supported when the
surface contains no evidence.

## DP-LRO-04: Polling and final-operation links must target the right operations

- **Severity:** Warning.

Confirm `@pollingOperation` targets the operation returning the intended status
monitor and `@finalOperation`, when present, targets the operation returning the
intended final result.

## DP-LRO-05: Custom monitors need SDK-readable result and error members

- **Severity:** Suggestion.

For a hand-rolled monitor, flag result or error properties missing `@lroResult`
or `@lroErrorResult`, and a custom canceled terminal value missing
`@lroCanceled`. Do not report status, success, or failure markers that
deterministic tooling already requires.

## DP-PAGE-01: Potentially large collections must be paged

- **Severity:** Warning.
- **Strength:** `YOU SHOULD` page a collection if it can ever grow very large.

The upstream condition is whether the collection can ever grow very large.
Flag customer-populated collections and search/query results that are unbounded
but return a single array with no continuation.

Stay silent when the service credibly documents a fixed small bound. Typical
size, implementation simplicity, or snapshot consistency does not establish a
bound.

## DP-PAGE-02: Sibling list operations need one paging shape

- **Severity:** Warning.

Flag inconsistent continuation contracts across sibling list operations in one
service, such as `nextLink` in one operation and an unrelated token or
offset-based shape in another. This requires a graph comparison.

## Out of scope

- Page-size parameter naming and style-only suggestions.
- Runtime ordering, retention windows, polling intervals, and whether a service
  honors a requested page size.
- ARM `Azure-AsyncOperation` and `final-state-via` guidance.
- Basic TypeSpec LRO and paging template diagnostics.
