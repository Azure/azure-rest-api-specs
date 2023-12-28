import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Microsoft Defender for Cloud is provided in two pricing tiers: free and standard. The standard tier offers advanced security capabilities, while the free tier offers basic security features.")
@subscriptionResource
model Pricing is ProxyResource<PricingProperties> {
  @doc("name of the pricing configuration")
  @key("pricingName")
  @segment("pricings")
  name: string;
}

@armResourceOperations
interface Pricings {
  @doc("Gets a provided Microsoft Defender for Cloud pricing configuration in the subscription.")
  get is ArmResourceRead<Pricing>;
  @doc("Updates a provided Microsoft Defender for Cloud pricing configuration in the subscription.")
  update is ArmResourceCreateOrReplaceSync<Pricing>;
  @doc("Lists Microsoft Defender for Cloud pricing configurations in the subscription.")
  list is ArmResourceListByParent<Pricing>;
}
