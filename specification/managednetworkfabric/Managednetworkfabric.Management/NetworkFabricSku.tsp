import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric SKU resource definition.
 */
@subscriptionResource
model NetworkFabricSku
  is Azure.ResourceManager.ProxyResource<NetworkFabricSkuProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkFabricSku,
    KeyName = "networkFabricSkuName",
    SegmentName = "networkFabricSkus",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkFabricSkus {
  /**
   * Implements Network Fabric SKU GET method.
   */
  get is ArmResourceRead<
    NetworkFabricSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Implements Network Fabric SKUs list by subscription GET method.
   */
  listBySubscription is ArmResourceListByParent<
    NetworkFabricSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(NetworkFabricSku.name, "Name of the Network Fabric SKU.");
@@doc(NetworkFabricSku.properties, "Resource properties.");
