import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an allowed environment type.")
@parentResource(Project)
model AllowedEnvironmentType
  is Azure.ResourceManager.ProxyResource<AllowedEnvironmentTypeProperties> {
  ...ResourceNameParameter<
    Resource = AllowedEnvironmentType,
    KeyName = "environmentTypeName",
    SegmentName = "allowedEnvironmentTypes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface AllowedEnvironmentTypes {
  @doc("Gets an allowed environment type.")
  get is ArmResourceRead<AllowedEnvironmentType>;

  @doc("Lists allowed environment types for a project.")
  list is ArmResourceListByParent<
    AllowedEnvironmentType,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = AllowedEnvironmentTypeListResult
  >;
}

@@maxLength(AllowedEnvironmentType.name, 63);
@@minLength(AllowedEnvironmentType.name, 3);
@@doc(AllowedEnvironmentType.name, "The name of the environment type.");
@@doc(AllowedEnvironmentType.properties,
  "Properties of an allowed environment type."
);
