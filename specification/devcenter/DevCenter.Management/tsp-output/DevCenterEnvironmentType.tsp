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
@doc("Represents an environment type.")
@parentResource(DevCenter)
model DevCenterEnvironmentType is ProxyResource<EnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  name: string;
}

@armResourceOperations
interface DevCenterEnvironmentTypes {
  @doc("Gets an environment type.")
  get is ArmResourceRead<DevCenterEnvironmentType>;
  @doc("Creates or updates an environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevCenterEnvironmentType>;
  @doc("Partially updates an environment type.")
  update is ArmTagsPatchSync<DevCenterEnvironmentType>;
  @doc("Deletes an environment type.")
  delete is ArmResourceDeleteSync<DevCenterEnvironmentType>;
  @doc("Lists environment types for the devcenter.")
  listByDevCenter is ArmResourceListByParent<
    DevCenterEnvironmentType,
    {
      ...BaseParameters<DevCenterEnvironmentType>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
