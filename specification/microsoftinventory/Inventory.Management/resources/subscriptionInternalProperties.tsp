import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
/** import "@azure-tools/typespec-autorest"; */
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/subscriptioninternalproperty.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft Inventory" })
@versioned(Microsoft.Inventory.Versions)
namespace Microsoft.Inventory;

@singleton
model SubscriptionInternalPropertyResource
  is ExtensionResource<SubscriptionInternalProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "There is no defined pattern. The only value can be 'default'."
  @segment("subscriptionInternalProperties")
  @doc("Subscription billing properties")
  @key("subscriptionInternalPropertyName")
  @path
  name: "default";
}

@armResourceOperations
interface SubscriptionInternalPropertyResources {
  @doc("Gets Subscription's internal properties.")
  get is ArmResourceRead<SubscriptionInternalPropertyResource>;
  list is ArmResourceListByParent<SubscriptionInternalPropertyResource>;
}
