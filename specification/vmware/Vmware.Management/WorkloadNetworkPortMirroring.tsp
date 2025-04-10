import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * NSX Port Mirroring
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkPortMirroring
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkPortMirroringProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkPortMirroring,
    KeyName = "portMirroringId",
    SegmentName = "portMirroringProfiles",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkPortMirrorings {
  /**
   * Get a WorkloadNetworkPortMirroring
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetPortMirroring")
  getPortMirroring is ArmResourceRead<WorkloadNetworkPortMirroring>;

  /**
   * Create a WorkloadNetworkPortMirroring
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreatePortMirroring")
  createPortMirroring is ArmResourceCreateOrReplaceAsync<WorkloadNetworkPortMirroring>;

  /**
   * Update a WorkloadNetworkPortMirroring
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdatePortMirroring")
  updatePortMirroring is ArmCustomPatchAsync<
    WorkloadNetworkPortMirroring,
    PatchModel = WorkloadNetworkPortMirroring
  >;

  /**
   * Delete a WorkloadNetworkPortMirroring
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeletePortMirroring")
  deletePortMirroring is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkPortMirroring,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkPortMirroring resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListPortMirroring")
  listPortMirroring is ArmResourceListByParent<
    WorkloadNetworkPortMirroring,
    Response = ArmResponse<WorkloadNetworkPortMirroringList>
  >;
}

@@doc(WorkloadNetworkPortMirroring.name,
  "ID of the NSX port mirroring profile."
);
@@doc(WorkloadNetworkPortMirroring.properties,
  "The resource-specific properties for this resource."
);
