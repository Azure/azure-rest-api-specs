import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevCenter;
@doc("Represents an allowed environment type.")
@parentResource(Project)
model AllowedEnvironmentType
  is ProxyResource<AllowedEnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @key("environmentTypeName")
  @segment("allowedEnvironmentTypes")
  name: string;
}

@armResourceOperations
interface ProjectAllowedEnvironmentTypes {
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
