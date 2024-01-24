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
 * NSX DNS Zone
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkDnsZoneProperties
)
@includeInapplicableMetadataInPayload(false)
model WorkloadNetworkDnsZone extends ProxyResourceBase {
  /**
   * NSX DNS Zone identifier. Generally the same as the DNS Zone's display name
   */
  @path
  @key("dnsZoneId")
  @segment("dnsZones")
  name: string;

  /**
   * DNS Zone properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkDnsZoneProperties;
}

@armResourceOperations
interface WorkloadNetworkDnsZones {
  /**
   * Get a DNS zone by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetDnsZone")
  getDnsZone is ArmResourceRead<WorkloadNetworkDnsZone>;

  /**
   * Create a DNS zone by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreateDnsZone")
  createDnsZone is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDnsZone>;

  /**
   * Create or update a DNS zone by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdateDnsZone")
  updateDnsZone is ArmCustomPatchAsync<
    WorkloadNetworkDnsZone,
    WorkloadNetworkDnsZone
  >;

  /**
   * Delete a DNS zone by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDnsZone")
  deleteDnsZone is ArmResourceDeleteAsync<WorkloadNetworkDnsZone>;

  /**
   * List of DNS zones in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListDnsZones")
  listDnsZones is ArmResourceListByParent<WorkloadNetworkDnsZone>;
}

@@projectedName(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "json",
  "workloadNetworkDnsZone"
);
@@extension(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);
@@doc(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "NSX DNS Zone"
);
@@projectedName(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "json",
  "workloadNetworkDnsZone"
);
@@extension(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);
@@doc(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "NSX DNS Zone"
);
