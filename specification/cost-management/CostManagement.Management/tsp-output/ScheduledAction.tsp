import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
@doc("Scheduled action definition.")
@tenantResource
model ScheduledAction is ProxyResource<ScheduledActionProperties> {
  @doc("Scheduled action name.")
  @path
  @key("name")
  @segment("scheduledActions")
  name: string;
}

@armResourceOperations
interface ScheduledActions {
  @doc("Get the private scheduled action by name.")
  get is ArmResourceRead<ScheduledAction>;

  @doc("Create or update a private scheduled action.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ScheduledAction,
    {
      ...BaseParameters<ScheduledAction>;

      @doc("ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Delete a private scheduled action.")
  delete is ArmResourceDeleteSync<ScheduledAction>;

  @doc("Processes a private scheduled action.")
  run is ArmResourceActionSync<ScheduledAction, void, void>;
}

@@projectedName(ScheduledActions.createOrUpdate::parameters.resource,
  "json",
  "scheduledAction"
);
@@extension(ScheduledActions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "scheduledAction"
);
@@doc(ScheduledActions.createOrUpdate::parameters.resource,
  "Scheduled action to be created or updated."
);
