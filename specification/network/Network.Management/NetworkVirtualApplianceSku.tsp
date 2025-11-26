import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Definition of the NetworkVirtualApplianceSkus resource.
 */
@subscriptionResource
model NetworkVirtualApplianceSku
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkVirtualApplianceSkuPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkVirtualApplianceSku,
    KeyName = "skuName",
    SegmentName = "networkVirtualApplianceSkus",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkVirtualApplianceSkus {
  /**
   * Retrieves a single available sku for network virtual appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualApplianceSkus_Get")
  get is ArmResourceRead<
    NetworkVirtualApplianceSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * List all SKUs available for a virtual appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualApplianceSkus_List")
  list is ArmResourceListByParent<
    NetworkVirtualApplianceSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;
}

@@doc(NetworkVirtualApplianceSku.name, "Name of the Sku.");
@@doc(NetworkVirtualApplianceSku.properties,
  "NetworkVirtualApplianceSku properties."
);
