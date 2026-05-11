import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./ConnectedRegistry.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Versioning;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a connected registry for a container registry.
 */
@parentResource(Registry)
model ConnectedRegistry
  is Azure.ResourceManager.ProxyResource<ConnectedRegistryProperties> {
  ...ResourceNameParameter<
    Resource = ConnectedRegistry,
    KeyName = "connectedRegistryName",
    SegmentName = "connectedRegistries",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@armResourceOperations
interface ConnectedRegistries {
  /**
   * Gets the properties of the connected registry.
   */
  get is ArmResourceRead<ConnectedRegistry>;

  /**
   * Creates a connected registry for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<ConnectedRegistry>;

  /**
   * Updates a connected registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConnectedRegistry,
    PatchModel = ConnectedRegistryUpdateParameters,
    Response = ArmResponse<ConnectedRegistry> | ArmResourceCreatedResponse<
      ConnectedRegistry,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ConnectedRegistry> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a connected registry from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectedRegistry,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all connected registries for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    ConnectedRegistry,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of connectedRegistries to return. The parameters that can be filtered are parent.id (the resource id of the connectedRegistry parent), mode, and connectionState. The supported operator is eq.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ConnectedRegistryListResult>
  >;

  /**
   * Deactivates the connected registry instance.
   */
  deactivate is ArmResourceActionAsync<
    ConnectedRegistry,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resync the connected registry instance.
   */
  @added(Versions.vLatestPreview)
  resync is ArmResourceActionSync<
    ConnectedRegistry,
    void,
    Response = ArmResponse<ConnectedRegistry>
  >;
}

@@maxLength(ConnectedRegistry.name, 50);
@@minLength(ConnectedRegistry.name, 5);
@@doc(ConnectedRegistry.name, "The name of the connected registry.");
@@doc(ConnectedRegistry.properties,
  "The properties of the connected registry."
);
@@doc(ConnectedRegistries.create::parameters.resource,
  "The parameters for creating a connectedRegistry."
);
@@doc(ConnectedRegistries.update::parameters.properties,
  "The parameters for updating a connectedRegistry."
);
