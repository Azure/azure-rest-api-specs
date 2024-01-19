import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Represents an environment type.")
@parentResource(DevCenter)
model EnvironmentType is ProxyResource<EnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  name: string;
}

@armResourceOperations
interface EnvironmentTypes {
  @doc("Gets an environment type.")
  get is ArmResourceRead<EnvironmentType>;

  @doc("Creates or updates an environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnvironmentType>;

  @doc("Partially updates an environment type.")
  update is ArmCustomPatchSync<EnvironmentType, EnvironmentTypeUpdate>;

  @doc("Deletes an environment type.")
  delete is ArmResourceDeleteSync<EnvironmentType>;

  @doc("Lists environment types for the devcenter.")
  listByDevCenter is ArmResourceListByParent<
    EnvironmentType,
    {
      ...BaseParameters<EnvironmentType>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(EnvironmentTypes.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(EnvironmentTypes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(EnvironmentTypes.createOrUpdate::parameters.resource,
  "Represents an Environment Type."
);
@@projectedName(EnvironmentTypes.update::parameters.properties, "json", "body");
@@extension(EnvironmentTypes.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(EnvironmentTypes.update::parameters.properties,
  "Updatable environment type properties."
);
