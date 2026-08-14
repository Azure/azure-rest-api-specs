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

## DP-LRO-01: A status monitor must expose failure and result semantics

- **Severity:** Warning.

Flag a monitor that can reach failure but exposes no error result, or reaches
success but provides no result or documented result resource when the operation
produces one.

Do not report missing status properties, terminal-state values, or other basic
metadata already diagnosed by TypeSpec tooling.

## DP-LRO-03: Cancellation must be coherent

- **Severity:** Suggestion.

Flag a cancellation operation with no canceled terminal state, or a canceled
state with a newly introduced public cancel operation mismatch. This is a
cross-operation consistency check.

Do not speculate about whether runtime cancellation is supported when the
surface contains no evidence.

## DP-LRO-04: Polling and final-operation links must target the right operations

- **Severity:** Warning.

Confirm the linked polling operation returns the intended status monitor and a
final operation returns the intended result. A link that exists but points to
the wrong operation can produce an SDK poller that never completes correctly.

## DP-LRO-05: Custom monitors need SDK-readable result and error members

- **Severity:** Suggestion.

For a hand-rolled monitor, flag result or error properties whose semantics are
not identified for generated pollers with `@lroResult` or `@lroErrorResult`.
Use `@lroCanceled` when a custom terminal value represents cancellation. Do not
report status, success, or failure markers that deterministic tooling already
requires.

## DP-PAGE-01: Potentially large collections must be paged

- **Severity:** Warning.

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
