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
 * NSX DNS Zone
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsZone
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkDnsZoneProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkDnsZone,
    KeyName = "dnsZoneId",
    SegmentName = "dnsZones",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkDnsZones {
  /**
   * Get a WorkloadNetworkDnsZone
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetDnsZone")
  getDnsZone is ArmResourceRead<WorkloadNetworkDnsZone>;

  /**
   * Create a WorkloadNetworkDnsZone
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreateDnsZone")
  createDnsZone is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDnsZone>;

  /**
   * Update a WorkloadNetworkDnsZone
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdateDnsZone")
  updateDnsZone is ArmCustomPatchAsync<
    WorkloadNetworkDnsZone,
    PatchModel = WorkloadNetworkDnsZone
  >;

  /**
   * Delete a WorkloadNetworkDnsZone
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDnsZone")
  deleteDnsZone is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkDnsZone,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkDnsZone resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListDnsZones")
  listDnsZones is ArmResourceListByParent<
    WorkloadNetworkDnsZone,
    Response = ArmResponse<WorkloadNetworkDnsZonesList>
  >;
}

@@doc(WorkloadNetworkDnsZone.name, "ID of the DNS zone.");
@@doc(WorkloadNetworkDnsZone.properties,
  "The resource-specific properties for this resource."
);
