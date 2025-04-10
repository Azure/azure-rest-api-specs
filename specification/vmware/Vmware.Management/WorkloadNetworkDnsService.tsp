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
 * NSX DNS Service
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsService
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkDnsServiceProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkDnsService,
    KeyName = "dnsServiceId",
    SegmentName = "dnsServices",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkDnsServices {
  /**
   * Get a WorkloadNetworkDnsService
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetDnsService")
  getDnsService is ArmResourceRead<WorkloadNetworkDnsService>;

  /**
   * Create a WorkloadNetworkDnsService
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_CreateDnsService")
  createDnsService is ArmResourceCreateOrReplaceAsync<WorkloadNetworkDnsService>;

  /**
   * Update a WorkloadNetworkDnsService
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WorkloadNetworks_UpdateDnsService")
  updateDnsService is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    PatchModel = WorkloadNetworkDnsService
  >;

  /**
   * Delete a WorkloadNetworkDnsService
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteDnsService")
  deleteDnsService is ArmResourceDeleteWithoutOkAsync<
    WorkloadNetworkDnsService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List WorkloadNetworkDnsService resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListDnsServices")
  listDnsServices is ArmResourceListByParent<
    WorkloadNetworkDnsService,
    Response = ArmResponse<WorkloadNetworkDnsServicesList>
  >;
}

@@doc(WorkloadNetworkDnsService.name, "ID of the DNS service.");
@@doc(WorkloadNetworkDnsService.properties,
  "The resource-specific properties for this resource."
);
