import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * NSX Segment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkSegmentProperties
)
model WorkloadNetworkSegment extends ProxyResourceBase {
  /**
   * NSX Segment identifier. Generally the same as the Segment's display name
   */
  @path
  @key("segmentId")
  @segment("segments")
  @visibility("read")
  name: string;

  /**
   * The properties of a Workload Segment proxy resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkSegmentProperties;
}

@armResourceOperations
interface WorkloadNetworkSegments {
  /**
   * Get a segment by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetSegment")
  getSegment is ArmResourceRead<WorkloadNetworkSegment>;

  /**
   * Create a segment by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreateSegments")
  createSegments is ArmResourceCreateOrReplaceAsync<WorkloadNetworkSegment>;

  /**
   * Create or update a segment by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdateSegments")
  updateSegments is ArmCustomPatchAsync<
    WorkloadNetworkSegment,
    WorkloadNetworkSegment
  >;

  /**
   * Delete a segment by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteSegment")
  deleteSegment is ArmResourceDeleteAsync<WorkloadNetworkSegment>;

  /**
   * List of segments in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListSegments")
  listSegments is ArmResourceListByParent<WorkloadNetworkSegment>;
}

@@projectedName(WorkloadNetworkSegments.createSegments::parameters.resource,
  "json",
  "workloadNetworkSegment"
);
@@extension(WorkloadNetworkSegments.createSegments::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkSegment"
);
@@doc(WorkloadNetworkSegments.createSegments::parameters.resource,
  "NSX Segment"
);
@@projectedName(WorkloadNetworkSegments.updateSegments::parameters.properties,
  "json",
  "workloadNetworkSegment"
);
@@extension(WorkloadNetworkSegments.updateSegments::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkSegment"
);
@@doc(WorkloadNetworkSegments.updateSegments::parameters.properties,
  "NSX Segment"
);
