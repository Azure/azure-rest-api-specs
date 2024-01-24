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
 * NSX Port Mirroring
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkPortMirroringProperties
)
@includeInapplicableMetadataInPayload(false)
model WorkloadNetworkPortMirroring extends ProxyResourceBase {
  /**
   * NSX Port Mirroring identifier. Generally the same as the Port Mirroring display name
   */
  @path
  @key("portMirroringId")
  @segment("portMirroringProfiles")
  name: string;

  /**
   * Port Mirroring Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkPortMirroringProperties;
}

@armResourceOperations
interface WorkloadNetworkPortMirrorings {
  /**
   * Get a port mirroring profile by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetPortMirroring")
  getPortMirroring is ArmResourceRead<WorkloadNetworkPortMirroring>;

  /**
   * Create a port mirroring profile by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreatePortMirroring")
  createPortMirroring is ArmResourceCreateOrReplaceAsync<WorkloadNetworkPortMirroring>;

  /**
   * Create or update a port mirroring profile by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdatePortMirroring")
  updatePortMirroring is ArmCustomPatchAsync<
    WorkloadNetworkPortMirroring,
    WorkloadNetworkPortMirroring
  >;

  /**
   * Delete a port mirroring profile by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeletePortMirroring")
  deletePortMirroring is ArmResourceDeleteAsync<WorkloadNetworkPortMirroring>;

  /**
   * List of port mirroring profiles in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListPortMirroring")
  listPortMirroring is ArmResourceListByParent<WorkloadNetworkPortMirroring>;
}

@@projectedName(WorkloadNetworkPortMirrorings.createPortMirroring::parameters.resource,
  "json",
  "workloadNetworkPortMirroring"
);
@@extension(WorkloadNetworkPortMirrorings.createPortMirroring::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkPortMirroring"
);
@@doc(WorkloadNetworkPortMirrorings.createPortMirroring::parameters.resource,
  "NSX port mirroring"
);
@@projectedName(WorkloadNetworkPortMirrorings.updatePortMirroring::parameters.properties,
  "json",
  "workloadNetworkPortMirroring"
);
@@extension(WorkloadNetworkPortMirrorings.updatePortMirroring::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkPortMirroring"
);
@@doc(WorkloadNetworkPortMirrorings.updatePortMirroring::parameters.properties,
  "NSX port mirroring"
);
