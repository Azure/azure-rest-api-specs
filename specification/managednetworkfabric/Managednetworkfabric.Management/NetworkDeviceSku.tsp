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
 * The NetworkDeviceSku resource definition.
 */
@subscriptionResource
model NetworkDeviceSku
  is Azure.ResourceManager.ProxyResource<NetworkDeviceSkuProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkDeviceSku,
    KeyName = "networkDeviceSkuName",
    SegmentName = "networkDeviceSkus",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkDeviceSkus {
  /**
   * Get a Network Device SKU details.
   */
  get is ArmResourceRead<
    NetworkDeviceSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List Network Device SKUs for the given subscription.
   */
  listBySubscription is ArmResourceListByParent<
    NetworkDeviceSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(NetworkDeviceSku.name, "Name of the Network Device SKU.");
@@doc(NetworkDeviceSku.properties, "Resource properties.");
