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
@summary("Available NetworkVirtualApplianceSkus")
model NetworkVirtualApplianceSku
  is Azure.ResourceManager.ProxyResource<NetworkVirtualApplianceSkuPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkVirtualApplianceSku,
    KeyName = "skuName",
    SegmentName = "networkVirtualApplianceSkus",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: TagsObject;

  /** Resource location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface NetworkVirtualApplianceSkus {
  /**
   * Retrieves a single available sku for network virtual appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualApplianceSkus_Get")
  get is ArmResourceRead<
    NetworkVirtualApplianceSku,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * List all SKUs available for a virtual appliance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
