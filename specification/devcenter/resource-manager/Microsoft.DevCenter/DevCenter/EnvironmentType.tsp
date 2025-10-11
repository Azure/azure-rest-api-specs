import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an environment type.")
@parentResource(DevCenter)
model EnvironmentType
  is Azure.ResourceManager.ProxyResource<EnvironmentTypeProperties> {
  ...ResourceNameParameter<
    Resource = EnvironmentType,
    KeyName = "environmentTypeName",
    SegmentName = "environmentTypes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is a valid property."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface EnvironmentTypes {
  @doc("Gets an environment type.")
  get is ArmResourceRead<EnvironmentType>;

  @doc("Creates or updates an environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnvironmentType>;

  @doc("Partially updates an environment type.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    EnvironmentType,
    PatchModel = EnvironmentTypeUpdate
  >;

  @doc("Deletes an environment type.")
  delete is ArmResourceDeleteSync<EnvironmentType>;

  @doc("Lists environment types for the devcenter.")
  listByDevCenter is ArmResourceListByParent<
    EnvironmentType,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = EnvironmentTypeListResult
  >;
}

@@maxLength(EnvironmentType.name, 63);
@@minLength(EnvironmentType.name, 3);
@@doc(EnvironmentType.name, "The name of the environment type.");
@@doc(EnvironmentType.properties, "Properties of an environment type.");
@@doc(EnvironmentTypes.createOrUpdate::parameters.resource,
  "Represents an Environment Type."
);
@@doc(EnvironmentTypes.update::parameters.properties,
  "Updatable environment type properties."
);
