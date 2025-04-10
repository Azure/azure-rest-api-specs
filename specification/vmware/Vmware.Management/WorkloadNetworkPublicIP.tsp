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
 * NSX Public IP Block
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkPublicIP
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkPublicIPProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkPublicIP,
    KeyName = "publicIPId",
    SegmentName = "publicIPs",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkPublicIPS {
  /**
   * Get a WorkloadNetworkPublicIP
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetPublicIP")
  getPublicIP is ArmResourceRead<WorkloadNetworkPublicIP>;

  /**
   * Create a WorkloadNetworkPublicIP
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreatePublicIP")
  createPublicIP is ArmResourceCreateOrReplaceAsync<WorkloadNetworkPublicIP>;

  /**
   * Delete a WorkloadNetworkPublicIP
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeletePublicIP")
  deletePublicIP is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkPublicIP,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkPublicIP resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListPublicIPs")
  listPublicIPs is ArmResourceListByParent<
    WorkloadNetworkPublicIP,
    Response = ArmResponse<WorkloadNetworkPublicIPsList>
  >;
}

@@doc(WorkloadNetworkPublicIP.name, "ID of the DNS zone.");
@@doc(WorkloadNetworkPublicIP.properties,
  "The resource-specific properties for this resource."
);
