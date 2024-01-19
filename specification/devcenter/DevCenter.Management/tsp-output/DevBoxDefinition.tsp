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
@doc("Represents a definition for a Developer Machine.")
@parentResource(DevCenter)
model DevBoxDefinition is TrackedResource<DevBoxDefinitionProperties> {
  @doc("The name of the Dev Box definition.")
  @path
  @key("devBoxDefinitionName")
  @segment("devboxdefinitions")
  name: string;
}

@armResourceOperations
interface DevBoxDefinitions {
  @doc("Gets a Dev Box definition")
  get is ArmResourceRead<DevBoxDefinition>;

  @doc("Creates or updates a Dev Box definition.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DevBoxDefinition,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

  @doc("Partially updates a Dev Box definition.")
  update is ArmCustomPatchAsync<
    DevBoxDefinition,
    DevBoxDefinitionUpdate,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a Dev Box definition")
  delete is ArmResourceDeleteAsync<
    DevBoxDefinition,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

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

@@projectedName(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "Represents a Dev Box definition."
);
@@projectedName(DevBoxDefinitions.update::parameters.properties,
  "json",
  "body"
);
@@extension(DevBoxDefinitions.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DevBoxDefinitions.update::parameters.properties,
  "Represents a Dev Box definition."
);
