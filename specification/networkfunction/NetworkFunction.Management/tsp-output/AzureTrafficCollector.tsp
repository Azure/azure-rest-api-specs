import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NetworkFunction;
@doc("Azure Traffic Collector resource.")
model AzureTrafficCollector
  is TrackedResource<AzureTrafficCollectorPropertiesFormat> {
  @doc("Azure Traffic Collector name")
  @key("azureTrafficCollectorName")
  @segment("azureTrafficCollectors")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface AzureTrafficCollectors {
  @doc("Gets the specified Azure Traffic Collector in a specified resource group")
  get is ArmResourceRead<AzureTrafficCollector>;

  @doc("Creates or updates a Azure Traffic Collector resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureTrafficCollector>;

  @doc("Updates the specified Azure Traffic Collector tags.")
  updateTags is ArmCustomPatchSync<AzureTrafficCollector, TagsObject>;

  @doc("Deletes a specified Azure Traffic Collector resource.")
  delete is ArmResourceDeleteAsync<AzureTrafficCollector>;
}

@armResourceOperations
@projectedName("client", "AzureTrafficCollectorsByResourceGroup")
interface AzureTrafficCollectors_AzureTrafficCollectorsByResourceGroup {
  @doc("Return list of Azure Traffic Collectors in a Resource Group")
  list is ArmResourceListByParent<AzureTrafficCollector>;
}
