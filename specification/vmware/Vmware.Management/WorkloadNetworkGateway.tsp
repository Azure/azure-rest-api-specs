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
 * NSX Gateway.
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkGateway
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkGatewayProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkGateway,
    KeyName = "gatewayId",
    SegmentName = "gateways",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkGateways {
  /**
   * Get a WorkloadNetworkGateway
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetGateway")
  getGateway is ArmResourceRead<WorkloadNetworkGateway>;

  /**
   * List WorkloadNetworkGateway resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListGateways")
  listGateways is ArmResourceListByParent<
    WorkloadNetworkGateway,
    Response = ArmResponse<WorkloadNetworkGatewayList>
  >;
}

@@doc(WorkloadNetworkGateway.name, "The ID of the NSX Gateway");
@@doc(WorkloadNetworkGateway.properties,
  "The resource-specific properties for this resource."
);
