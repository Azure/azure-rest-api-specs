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
 * NSX Gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkGatewayProperties
)
model WorkloadNetworkGateway extends ProxyResourceBase {
  /**
   * NSX Gateway identifier. Generally the same as the Gateway's display name
   */
  @path
  @key("gatewayId")
  @segment("gateways")
  @visibility("read")
  name: string;

  /**
   * Gateway properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkGatewayProperties;
}

@armResourceOperations
interface WorkloadNetworkGateways {
  /**
   * Get a gateway by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetGateway")
  getGateway is ArmResourceRead<WorkloadNetworkGateway>;

  /**
   * List of gateways in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListGateways")
  listGateways is ArmResourceListByParent<WorkloadNetworkGateway>;
}
