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
@doc("An environment, which is essentially an ARM template deployment.")
@parentResource(DevTestLabUser)
model DevTestLabEnvironment is TrackedResource<EnvironmentProperties> {
  @doc("The name of the environment.")
  @path
  @key("name")
  @segment("environments")
  name: string;
}

@armResourceOperations
interface DevTestLabEnvironments {
  @doc("Get environment.")
  get is ArmResourceRead<
    DevTestLabEnvironment,
    {
      ...BaseParameters<DevTestLabEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing environment. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLabEnvironment>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of environments. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabEnvironment, DtlEnvironmentFragment>;
  @doc("Delete environment. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DevTestLabEnvironment>;
  @doc("List environments in a given user profile.")
  list is ArmResourceListByParent<
    DevTestLabEnvironment,
    {
      ...BaseParameters<DevTestLabEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
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
}
