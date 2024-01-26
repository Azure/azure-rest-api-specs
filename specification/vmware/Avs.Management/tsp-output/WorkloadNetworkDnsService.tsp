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
 * NSX DNS Service
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkDnsServiceProperties
)
model WorkloadNetworkDnsService extends ProxyResourceBase {
  /**
   * NSX DNS Service identifier. Generally the same as the DNS Service's display name
   */
  @path
  @key("dnsServiceId")
  @segment("dnsServices")
  @visibility("read")
  name: string;

  /**
   * DNS Service properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkDnsServiceProperties;
}

@armResourceOperations
interface WorkloadNetworkDnsServices {
  /**
   * Get a DNS service by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetDnsService")
  getDnsService is ArmResourceRead<WorkloadNetworkDnsService>;

  /**
   * Create a DNS service by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreateDnsService")
  createDnsService is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDnsService>;

  /**
   * Create or update a DNS service by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdateDnsService")
  updateDnsService is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsService
  >;

  /**
   * Delete a DNS service by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDnsService")
  deleteDnsService is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;

  /**
   * List of DNS services in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListDnsServices")
  listDnsServices is ArmResourceListByParent<WorkloadNetworkDnsService>;
}

@@projectedName(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "json",
  "workloadNetworkDnsService"
);
@@extension(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);
@@doc(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "NSX DNS Service"
);
@@projectedName(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "json",
  "workloadNetworkDnsService"
);
@@extension(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);
@@doc(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "NSX DNS Service"
);
