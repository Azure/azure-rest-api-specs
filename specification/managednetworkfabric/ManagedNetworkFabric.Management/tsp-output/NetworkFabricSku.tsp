import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric SKU resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(NetworkFabricSkuProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkFabricSku extends ProxyResourceBase {
  /**
   * Name of the Network Fabric SKU.
   */
  @path
  @key("networkFabricSkuName")
  @segment("networkFabricSkus")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: NetworkFabricSkuProperties;
}

@armResourceOperations
interface NetworkFabricSkus {
  /**
   * Implements Network Fabric SKU GET method.
   */
  get is ArmResourceRead<NetworkFabricSku>;

  /**
   * Implements Network Fabric SKUs list by subscription GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabricSkus_ListBySubscription")
  listBySubscription is ArmResourceListByParent<NetworkFabricSku>;
}
