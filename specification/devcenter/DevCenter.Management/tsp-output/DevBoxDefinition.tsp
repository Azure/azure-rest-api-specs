import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a definition for a Developer Machine.")
@parentResource(DevCenter)
model DevBoxDefinition is TrackedResource<DevBoxDefinitionProperties> {
  @doc("The name of the Dev Box definition.")
  @key("devBoxDefinitionName")
  @segment("devboxdefinitions")
  name: string;
}

@armResourceOperations
interface DevBoxDefinitions {
  @doc("Gets a Dev Box definition")
  get is ArmResourceRead<DevBoxDefinition>;
  @doc("Creates or updates a Dev Box definition.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevBoxDefinition>;
  @doc("Partially updates a Dev Box definition.")
  update is ArmCustomPatchAsync<DevBoxDefinition, DevBoxDefinitionUpdate>;
  @doc("Deletes a Dev Box definition")
  delete is ArmResourceDeleteAsync<DevBoxDefinition>;
  @doc("List Dev Box definitions for a devcenter.")
  listByDevCenter is ArmResourceListByParent<
    DevBoxDefinition,
    {
      ...BaseParameters<DevBoxDefinition>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
