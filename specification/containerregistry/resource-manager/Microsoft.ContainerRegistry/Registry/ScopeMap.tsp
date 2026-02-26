import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./ScopeMap.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a scope map for a container registry.
 */
@parentResource(Registry)
model ScopeMap is Azure.ResourceManager.ProxyResource<ScopeMapProperties> {
  ...ResourceNameParameter<
    Resource = ScopeMap,
    KeyName = "scopeMapName",
    SegmentName = "scopeMaps",
    NamePattern = "^[a-zA-Z0-9-_]*$"
  >;
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
  create is ArmResourceCreateOrReplaceAsync<ScopeMap>;

  /**
   * Updates a scope map with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ScopeMap,
    PatchModel = ScopeMapUpdateParameters,
    Response = ArmResponse<ScopeMap> | ArmResourceCreatedResponse<
      ScopeMap,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ScopeMap> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a scope map from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ScopeMap,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the scope maps for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    ScopeMap,
    Response = ArmResponse<ScopeMapListResult>
  >;
}

@@maxLength(ScopeMap.name, 50);
@@minLength(ScopeMap.name, 5);
@@doc(ScopeMap.name, "The name of the scope map.");
@@doc(ScopeMap.properties, "The properties of the scope map.");
@@doc(ScopeMaps.create::parameters.resource,
  "The parameters for creating a scope map."
);
@@doc(ScopeMaps.update::parameters.properties,
  "The parameters for updating a scope map."
);
