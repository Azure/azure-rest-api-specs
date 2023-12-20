import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLabUser.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A Service Fabric.")
@parentResource(DevTestLabUser)
model DevTestLabServiceFabric is TrackedResource<ServiceFabricProperties> {
  @doc("The name of the service fabric.")
  @path
  @key("name")
  @segment("servicefabrics")
  name: string;
}

@armResourceOperations
interface DevTestLabServiceFabrics {
  @doc("Get service fabric.")
  get is ArmResourceRead<
    DevTestLabServiceFabric,
    {
      ...BaseParameters<DevTestLabServiceFabric>;

      @doc("Specify the $expand query. Example: 'properties($expand=applicableSchedule)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing service fabric. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLabServiceFabric>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of service fabrics. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabServiceFabric, ServiceFabricFragment>;
  @doc("Delete service fabric. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DevTestLabServiceFabric>;
  @doc("List service fabrics in a given user profile.")
  list is ArmResourceListByParent<
    DevTestLabServiceFabric,
    {
      ...BaseParameters<DevTestLabServiceFabric>;

      @doc("Specify the $expand query. Example: 'properties($expand=applicableSchedule)'")
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
  @doc("Lists the applicable start/stop schedules, if any.")
  listApplicableSchedules is ArmResourceActionSync<
    DevTestLabServiceFabric,
    void,
    ApplicableSchedule
  >;
  @doc("Start a service fabric. This operation can take a while to complete.")
  start is ArmResourceActionAsync<DevTestLabServiceFabric, void, void>;
  @doc("Stop a service fabric This operation can take a while to complete.")
  stop is ArmResourceActionAsync<DevTestLabServiceFabric, void, void>;
}
