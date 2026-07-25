// FIXTURE (TRUE NEGATIVE -- class 4: runtime-behavioral).
// Every doc comment below describes SERVICE RUNTIME BEHAVIOUR: sort ordering
// and its stability, retention windows, page-size behaviour, validation
// semantics, conditional status codes, idempotency, Retry-After values,
// throttling, and value preservation. None of it is statically checkable from
// a .tsp file, and all of it is 🚫 Runtime in
// references/data-plane-linter-rule-coverage.md.
//
// The reviewer must not invent a static finding from prose. The correct
// output is silence. Any finding that asserts something about ordering,
// retention, throttling, validation semantics, or preservation is a test
// failure.
//
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Audit Log" })
@versioned(Versions)
@server("https://{endpoint}", "Audit Log service", { endpoint: string })
namespace AuditLog;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("""
  A recorded audit event.

  Events are retained for 90 days from `recordedAt`, after which they are
  permanently deleted and reads return 404. Retention is not configurable in
  this API version.
  """)
@resource("events")
model AuditEvent {
  @doc("Identifier of the event. Assigned by the service and immutable.")
  @key("eventId")
  @visibility(Lifecycle.Read)
  id: uuid;

  @doc("""
    Time at which the service recorded the event, in UTC. This is the service's
    receive time, not the time reported by the caller; the two may differ under
    ingestion backlog.
    """)
  @visibility(Lifecycle.Read)
  recordedAt: utcDateTime;

  @doc("Principal that performed the audited action.")
  @visibility(Lifecycle.Read)
  actor: string;

  @doc("""
    Action that was performed, as a service-defined verb such as
    `resource.create`.
    """)
  @visibility(Lifecycle.Read)
  action: string;

  @doc("""
    Caller-supplied annotations attached to the event at ingestion. The service
    preserves key order, key casing, and value types exactly as submitted, and
    returns them unchanged.
    """)
  @visibility(Lifecycle.Read)
  annotations: Record<string>;
}

@doc("Operations on audit events.")
interface Events {
  @doc("""
    Gets a single audit event.

    Returns 404 when the event does not exist. Also returns 404, rather than
    403, when the event exists but the caller is not authorized to read it, so
    that the response does not disclose the existence of events in other
    tenants.
    """)
  get is StandardResourceOperations.ResourceRead<AuditEvent>;

  @doc("""
    Lists audit events.

    Results are ordered by `recordedAt` descending, with `id` as a stable
    tie-breaker, so that pagination is repeatable across pages even while new
    events are being ingested. Events ingested after the first page is served
    do not appear in subsequent pages of the same enumeration.

    The service chooses the page size; `maxpagesize` is a hint and the service
    may return fewer items than requested. An empty page with a `nextLink` is
    valid and callers must follow it.

    Requests exceeding the per-tenant rate limit are rejected with 429 and a
    `Retry-After` header whose value is computed from the caller's current
    quota consumption.
    """)
  list is StandardResourceOperations.ResourceList<
    AuditEvent,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("""
    Submits an audit event for ingestion.

    The request is idempotent on `clientRequestId`: resubmitting the same
    identifier within the deduplication window of 24 hours returns the
    originally recorded event rather than creating a second one.

    The service validates `action` against the set of verbs registered for the
    tenant and rejects unknown verbs with 400. Validation is performed after
    authorization, so an unauthorized caller receives 403 without learning
    whether the verb is valid.
    """)
  @route("/events:record")
  @post
  record(
    @doc("Caller-supplied identifier used for deduplication.")
    @header
    clientRequestId: uuid,

    @doc("The event to record.")
    @body
    body: AuditEvent,
  ): AuditEvent;
}
