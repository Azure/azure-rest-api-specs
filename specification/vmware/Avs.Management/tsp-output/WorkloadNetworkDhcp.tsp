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
 * NSX DHCP
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WorkloadNetworkDhcpEntity)
model WorkloadNetworkDhcp extends ProxyResourceBase {
  /**
   * NSX DHCP identifier. Generally the same as the DHCP display name
   */
  @path
  @key("dhcpId")
  @segment("dhcpConfigurations")
  @visibility("read")
  name: string;

  /**
   * DHCP properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkDhcpEntity;
}

@armResourceOperations
interface WorkloadNetworkDhcps {
  /**
   * Get dhcp by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetDhcp")
  getDhcp is ArmResourceRead<WorkloadNetworkDhcp>;

  /**
   * Create dhcp by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreateDhcp")
  createDhcp is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDhcp>;

  /**
   * Create or update dhcp by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdateDhcp")
  updateDhcp is ArmCustomPatchAsync<WorkloadNetworkDhcp, WorkloadNetworkDhcp>;

  /**
   * Delete dhcp by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDhcp")
  deleteDhcp is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;

  /**
   * List dhcp in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListDhcp")
  listDhcp is ArmResourceListByParent<WorkloadNetworkDhcp>;
}

@@projectedName(WorkloadNetworkDhcps.createDhcp::parameters.resource,
  "json",
  "workloadNetworkDhcp"
);
@@extension(WorkloadNetworkDhcps.createDhcp::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);
@@doc(WorkloadNetworkDhcps.createDhcp::parameters.resource, "NSX DHCP");
@@projectedName(WorkloadNetworkDhcps.updateDhcp::parameters.properties,
  "json",
  "workloadNetworkDhcp"
);
@@extension(WorkloadNetworkDhcps.updateDhcp::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);
@@doc(WorkloadNetworkDhcps.updateDhcp::parameters.properties, "NSX DHCP");
