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
 * NSX Segment
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkSegment
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkSegmentProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkSegment,
    KeyName = "segmentId",
    SegmentName = "segments",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkSegments {
  /**
   * Get a WorkloadNetworkSegment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetSegment")
  getSegment is ArmResourceRead<WorkloadNetworkSegment>;

  /**
   * Create a WorkloadNetworkSegment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreateSegments")
  createSegments is ArmResourceCreateOrReplaceAsync<WorkloadNetworkSegment>;

  /**
   * Update a WorkloadNetworkSegment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdateSegments")
  updateSegments is ArmCustomPatchAsync<
    WorkloadNetworkSegment,
    PatchModel = WorkloadNetworkSegment
  >;

  /**
   * Delete a WorkloadNetworkSegment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteSegment")
  deleteSegment is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkSegment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkSegment resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListSegments")
  listSegments is ArmResourceListByParent<
    WorkloadNetworkSegment,
    Response = ArmResponse<WorkloadNetworkSegmentsList>
  >;
}

@@doc(WorkloadNetworkSegment.name, "The ID of the NSX Segment");
@@doc(WorkloadNetworkSegment.properties,
  "The resource-specific properties for this resource."
);
