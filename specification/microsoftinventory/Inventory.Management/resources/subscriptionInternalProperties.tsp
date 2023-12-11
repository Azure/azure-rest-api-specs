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
@service({
  title: "Microsoft Inventory",
  version: "2024-01-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Inventory;

@subscriptionResource
@singleton
model SubscriptionInternalPropertyResource
  is ProxyResource<SubscriptionInternalProperties> {
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
