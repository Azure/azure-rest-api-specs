import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * RackSku represents the SKU information of the rack.
 */
@subscriptionResource
model RackSku is Azure.ResourceManager.ProxyResource<RackSkuProperties, false> {
  ...ResourceNameParameter<
    Resource = RackSku,
    KeyName = "rackSkuName",
    SegmentName = "rackSkus",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,126}[a-zA-Z0-9])$"
  >;
}

@armResourceOperations
interface RackSkus {
  /**
   * Get the properties of the provided rack SKU.
   */
  @summary("Retrieve the rack SKU.")
  get is ArmResourceRead<
    RackSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get a list of rack SKUs in the provided subscription.
   */
  @summary("List rack SKUs in the subscription.")
  listBySubscription is ArmResourceListByParent<
    RackSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<RackSkuList>
  >;
}

@@doc(RackSku.name, "The name of the rack SKU.");
@@doc(RackSku.properties, "The list of the resource properties.");
