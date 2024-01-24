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
/**
 * An object that represents a scope map for a container registry.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Registry)
@Azure.ResourceManager.Private.armResourceInternal(ScopeMapProperties)
@includeInapplicableMetadataInPayload(false)
model ScopeMap extends ProxyResourceBase {
  /**
   * The name of the scope map.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-_]*$")
  @path
  @key("scopeMapName")
  @segment("scopeMaps")
  name: string;

  /**
   * The properties of the scope map.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScopeMapProperties;
}

@armResourceOperations
interface ScopeMaps {
  /**
   * Gets the properties of the specified scope map.
   */
  get is ArmResourceRead<ScopeMap>;

  /**
   * Creates a scope map for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<
    ScopeMap,
    BaseParameters<ScopeMap>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a scope map with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    ScopeMap,
    ScopeMapUpdateParameters,
    BaseParameters<ScopeMap>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a scope map from a container registry.
   */
  delete is ArmResourceDeleteAsync<
    ScopeMap,
    BaseParameters<ScopeMap>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the scope maps for the specified container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopeMaps_List")
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
