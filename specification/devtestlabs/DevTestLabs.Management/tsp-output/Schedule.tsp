import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
@doc("A schedule.")
model Schedule is TrackedResource<ScheduleProperties> {
  @doc("The name of the schedule.")
  @key("name")
  @segment("schedules")
  name: string;
}

@armResourceOperations
@projectedName("client", "GlobalSchedules")
interface Schedules_GlobalSchedules {
  @doc("Get schedule.")
  get is ArmResourceRead<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("Specify the $expand query. Example: 'properties($select=status)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  @doc("Allows modifying tags of schedules. All other properties will be ignored.")
  update is ArmCustomPatchSync<Schedule, ScheduleFragment>;

  @doc("Delete schedule.")
  delete is ArmResourceDeleteSync<Schedule>;

  @doc("List schedules in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("Specify the $expand query. Example: 'properties($select=status)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;

  @doc("List schedules in a subscription.")
  listBySubscription is ArmListBySubscription<Schedule>;

  @doc("Execute a schedule. This operation can take a while to complete.")
  execute is ArmResourceActionAsync<Schedule, void, void>;

  @doc("Updates a schedule's target resource Id. This operation can take a while to complete.")
  retarget is ArmResourceActionAsync<
    Schedule,
    RetargetScheduleProperties,
    void
  >;
}
