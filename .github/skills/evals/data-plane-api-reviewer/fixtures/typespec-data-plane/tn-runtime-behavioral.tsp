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
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://auditlog.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Audit Log service", { endpoint: string })
namespace AuditLog;

alias ServiceTraits = SupportsRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
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

  @doc("""
    Principal that performed the audited action, as a Microsoft Entra object ID
    in GUID form. Service-initiated actions use the reserved value `system`.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  actor: string;

  @doc("""
    Action that was performed, as a service-defined verb in `noun.verb` form,
    such as `resource.create`. The set of verbs is registered per tenant and is
    published in the service documentation rather than in this specification.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  action: string;

  @doc("""
    Caller-supplied annotations attached to the event at ingestion. The service
    preserves key order, key casing, and value types exactly as submitted, and
    returns them unchanged.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  get is Operations.ResourceRead<AuditEvent>;

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
  list is Operations.ResourceList<
    AuditEvent,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("""
    Records an audit event.

    The service assigns `id` and `recordedAt`; the caller supplies `actor`,
    `action`, and `annotations`.

    Repeatable requests are supported: resubmitting the same
    `Repeatability-Request-ID` within the deduplication window of 24 hours
    returns the originally recorded event rather than creating a second one.

    Ingestion is asynchronous downstream of the response: a recorded event is
    durable when this call returns, but may not appear in `list` results for up
    to 30 seconds under backlog.
    """)
  create is Operations.ResourceCreateWithServiceProvidedName<AuditEvent>;
}

