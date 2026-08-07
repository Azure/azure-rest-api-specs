import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Notification Routing" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://notificationrouting.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Notification Routing service",
  {
    endpoint: url,
  }
)
namespace NotificationRouting;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("""
  A route that delivers notifications to a caller-selected endpoint.

  Routes have caller-chosen names and a conventional read, replace, delete, and
  list lifecycle. All durable route settings are returned except
  `routingLabel`, which remains owned by the caller.
  """)
@resource("routes")
model NotificationRoute {
  @doc("Name of the route. Unique within the calling account and immutable after creation.")
  @key("routeName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("""
    Endpoint that receives notifications for this route. The service validates
    the scheme and host when the route is written and returns the normalized URL
    on subsequent reads.
    """)
  destination: url;

  @doc("Policy used to schedule delivery attempts.")
  deliveryMode: DeliveryMode;

  @doc("""
    Caller-defined label stored with the route and copied to delivery audit
    records.

    The label is deliberately accepted on create and update but omitted from
    responses. Callers already own the label in their deployment configuration;
    not echoing it reduces response data and avoids making a stale service copy
    appear authoritative.
    """)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  routingLabel: string;

  @doc("Time at which the route was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("Time at which the route was most recently changed, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("""
  Policy used to schedule delivery attempts.

  The service may add delivery policies without changing the route schema, so
  clients must preserve values they do not yet recognize.
  """)
union DeliveryMode {
  string,

  @doc("Attempt delivery as soon as the notification is accepted.")
  Immediate: "Immediate",

  @doc("Combine notifications for up to one minute before delivery.")
  Buffered: "Buffered",
}

@doc("""
  Operations on notification routes.

  The interface exposes the complete resource lifecycle so callers can
  round-trip, enumerate, and clean up every route they create.
  """)
interface Routes {
  @doc("Gets a route by name.")
  get is StandardResourceOperations.ResourceRead<NotificationRoute>;

  @doc("Creates a route, or replaces an existing route with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<NotificationRoute>;

  @doc("Deletes a route. Deleting a route that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<NotificationRoute>;

  @doc("Lists the routes in the calling account.")
  list is StandardResourceOperations.ResourceList<
    NotificationRoute,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
