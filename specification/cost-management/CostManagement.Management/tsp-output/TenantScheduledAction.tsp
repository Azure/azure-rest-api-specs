import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CostManagement;
@doc("Scheduled action definition.")
@tenantResource
model TenantScheduledAction is ProxyResource<ScheduledActionProperties> {
  @doc("Scheduled action name.")
  @path
  @key("name")
  @segment("scheduledActions")
  name: string;
}

@armResourceOperations
interface TenantScheduledActions {
  @doc("Get the private scheduled action by name.")
  get is ArmResourceRead<TenantScheduledAction>;
  @doc("Create or update a private scheduled action.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    TenantScheduledAction,
    {
      ...BaseParameters<TenantScheduledAction>;

      @doc("ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Delete a private scheduled action.")
  delete is ArmResourceDeleteSync<TenantScheduledAction>;
  @doc("Processes a private scheduled action.")
  run is ArmResourceActionSync<TenantScheduledAction, void, void>;
}
