import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceTypeRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ProviderHub;

@parentResource(ResourceTypeRegistration)
model SkuResource is ProxyResource<ResourceTypeSku> {
  @doc("The SKU.")
  @path
  @key("sku")
  @segment("skus")
  name: string;
}

@armResourceOperations
interface Skus {
  @doc("Gets the sku details for the given resource type and sku name.")
  get is ArmResourceRead<SkuResource>;
  @doc("Creates or updates the resource type skus in the given resource type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SkuResource>;
  @doc("Deletes a resource type sku.")
  delete is ArmResourceDeleteSync<SkuResource>;
  @doc("Gets the list of skus for the given resource type.")
  listByResourceTypeRegistrations is ArmResourceListByParent<SkuResource>;
}
