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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@subscriptionResource
@summary("Available NetworkVirtualApplianceSkus")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkVirtualApplianceSku extends Resource {
  properties?: NetworkVirtualApplianceSkuPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("skuName")
  @segment("networkVirtualApplianceSkus")
  name: string;

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
