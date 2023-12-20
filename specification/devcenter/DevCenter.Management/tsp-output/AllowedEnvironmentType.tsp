import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents an allowed environment type.")
@parentResource(DevCenterProject)
model AllowedEnvironmentType
  is ProxyResource<AllowedEnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("allowedEnvironmentTypes")
  name: string;
}

@armResourceOperations
interface AllowedEnvironmentTypes {
  @doc("Gets an allowed environment type.")
  get is ArmResourceRead<AllowedEnvironmentType>;
  @doc("Lists allowed environment types for a project.")
  list is ArmResourceListByParent<
    AllowedEnvironmentType,
    {
      ...BaseParameters<AllowedEnvironmentType>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
