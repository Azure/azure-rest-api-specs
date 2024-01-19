import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
@doc("An object that represents a scope map for a container registry.")
@parentResource(Registry)
model ScopeMap is ProxyResource<ScopeMapProperties> {
  @doc("The name of the scope map.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-_]*$")
  @path
  @key("scopeMapName")
  @segment("scopeMaps")
  name: string;
}

@armResourceOperations
interface ScopeMaps {
  @doc("Gets the properties of the specified scope map.")
  get is ArmResourceRead<ScopeMap>;

  @doc("Creates a scope map for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<
    ScopeMap,
    BaseParameters<ScopeMap>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a scope map with the specified parameters.")
  update is ArmCustomPatchAsync<
    ScopeMap,
    ScopeMapUpdateParameters,
    BaseParameters<ScopeMap>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a scope map from a container registry.")
  delete is ArmResourceDeleteAsync<
    ScopeMap,
    BaseParameters<ScopeMap>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the scope maps for the specified container registry.")
  list is ArmResourceListByParent<ScopeMap>;
}

@@projectedName(ScopeMaps.create::parameters.resource,
  "json",
  "scopeMapCreateParameters"
);
@@extension(ScopeMaps.create::parameters.resource,
  "x-ms-client-name",
  "scopeMapCreateParameters"
);
@@doc(ScopeMaps.create::parameters.resource,
  "The parameters for creating a scope map."
);
@@projectedName(ScopeMaps.update::parameters.properties,
  "json",
  "scopeMapUpdateParameters"
);
@@extension(ScopeMaps.update::parameters.properties,
  "x-ms-client-name",
  "scopeMapUpdateParameters"
);
@@doc(ScopeMaps.update::parameters.properties,
  "The parameters for updating a scope map."
);
