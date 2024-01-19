import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Represents an allowed environment type.")
@parentResource(Project)
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an allowed environment type.")
  @operationId("ProjectAllowedEnvironmentTypes_Get")
  get is ArmResourceRead<AllowedEnvironmentType>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists allowed environment types for a project.")
  @operationId("ProjectAllowedEnvironmentTypes_List")
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
