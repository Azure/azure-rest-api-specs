import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A schedule.")
model DevTestLabGlobalSchedule is TrackedResource<ScheduleProperties> {
  @doc("The name of the schedule.")
  @path
  @key("name")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface DevTestLabGlobalSchedules {
  @doc("Get schedule.")
  get is ArmResourceRead<
    DevTestLabGlobalSchedule,
    {
      ...BaseParameters<DevTestLabGlobalSchedule>;

      @doc("Specify the $expand query. Example: 'properties($select=status)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabGlobalSchedule>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of schedules. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabGlobalSchedule, ScheduleFragment>;
  @doc("Delete schedule.")
  delete is ArmResourceDeleteSync<DevTestLabGlobalSchedule>;
  @doc("List schedules in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DevTestLabGlobalSchedule,
    {
      ...BaseParameters<DevTestLabGlobalSchedule>;

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
  listBySubscription is ArmListBySubscription<DevTestLabGlobalSchedule>;
  @doc("Execute a schedule. This operation can take a while to complete.")
  execute is ArmResourceActionAsync<DevTestLabGlobalSchedule, {}, {}>;
  @doc("Updates a schedule's target resource Id. This operation can take a while to complete.")
  retarget is ArmResourceActionAsync<
    DevTestLabGlobalSchedule,
    RetargetScheduleProperties,
    {}
  >;
}
