import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CostManagement;
@doc("Scheduled action definition.")
@tenantResource
model ScheduledAction is ProxyResource<ScheduledActionProperties> {
  @doc("Scheduled action name.")
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
