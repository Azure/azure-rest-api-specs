import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The managed private endpoint resource type.
 */
@parentResource(ManagedGrafana)
model ManagedPrivateEndpointModel
  is Azure.ResourceManager.TrackedResource<ManagedPrivateEndpointModelProperties> {
  ...ResourceNameParameter<
    Resource = ManagedPrivateEndpointModel,
    KeyName = "managedPrivateEndpointName",
    SegmentName = "managedPrivateEndpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedPrivateEndpointModels {
  /**
   * Get a specific managed private endpoint of a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedPrivateEndpoints_Get")
  get is ArmResourceRead<ManagedPrivateEndpointModel>;

  /**
   * Create or update a managed private endpoint for a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.Core.useFinalStateVia("original-uri")
  @operationId("ManagedPrivateEndpoints_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ManagedPrivateEndpointModel,
    Response = ArmResourceUpdatedResponse<ManagedPrivateEndpointModel> | ArmResourceCreatedResponse<
      Resource = ManagedPrivateEndpointModel,
      LroHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Update a managed private endpoint for an existing grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("ManagedPrivateEndpoints_Update")
  update is ArmCustomPatchAsync<
    ManagedPrivateEndpointModel,
    PatchModel = ManagedPrivateEndpointUpdateParameters,
    Response = ArmResponse<ManagedPrivateEndpointModel> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ManagedPrivateEndpointModel> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: ManagedPrivateEndpointModel;
    })
  >;

  /**
   * Delete a managed private endpoint for a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ManagedPrivateEndpoints_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedPrivateEndpointModel,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all managed private endpoints of a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedPrivateEndpoints_List")
  list is ArmResourceListByParent<
    ManagedPrivateEndpointModel,
    Response = ArmResponse<ManagedPrivateEndpointModelListResponse>
  >;
}

@@doc(ManagedPrivateEndpointModel.name,
  "The managed private endpoint name of Azure Managed Grafana."
);
@@doc(ManagedPrivateEndpointModel.properties, "Resource properties.");
@@doc(ManagedPrivateEndpointModels.create::parameters.resource,
  "The managed private endpoint to be created or updated."
);
@@doc(ManagedPrivateEndpointModels.update::parameters.properties,
  "Properties that can be updated to an existing managed private endpoint."
);
