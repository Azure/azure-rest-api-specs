import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Task Queue" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://taskqueue.azure.com/.default"],
    }
  ]>
)
@server("{endpoint}", "Task Queue service", { endpoint: url })
namespace TaskQueue;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("A unit of work submitted to the queue.")
@resource("tasks")
model QueuedTask {
  @doc("Identifier of the task. Assigned by the service and immutable.")
  @key("taskId")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Queue the task was submitted to. Must name a queue registered for the tenant.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueName: string;

  @doc("Caller-supplied payload, passed to the worker unchanged.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  payload: string;

  @doc("Time at which the service accepted the task, in UTC.")
  @visibility(Lifecycle.Read)
  acceptedAt: utcDateTime;
}

@doc("Operations on queued tasks.")
interface Tasks {
  @doc("Gets a task by identifier.")
  get is StandardResourceOperations.ResourceRead<QueuedTask>;

  @doc("""
    Submits a task to a queue.

    The service validates `queueName` against the set of queues registered for
    the tenant and rejects unknown queues with 400. Validation is performed
    after authorization, so an unauthorized caller receives 403 without
    learning whether the queue exists.

    A payload larger than the per-tenant limit is rejected with 413, and
    submissions beyond the per-tenant rate limit are rejected with 429.
    """)
  create is StandardResourceOperations.ResourceCreateWithServiceProvidedName<QueuedTask>;

  @doc("Lists tasks accepted for the calling tenant.")
  list is StandardResourceOperations.ResourceList<
    QueuedTask,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
